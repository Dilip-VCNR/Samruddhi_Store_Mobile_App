import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/routes.dart';
import '../../utils/url_constants.dart';


class MarkLocation extends StatefulWidget {
  const MarkLocation({Key? key}) : super(key: key);

  @override
  State<MarkLocation> createState() => _MarkLocationState();
}

class _MarkLocationState extends State<MarkLocation> {

  ValueNotifier<CameraPosition>? cameraPositionNotifier;
  @override
  void dispose() {
    cameraPositionNotifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Position currentLocation = arguments['currentLocation'];
    cameraPositionNotifier = ValueNotifier<CameraPosition>(CameraPosition(
        target: LatLng(arguments['currentLocation'].latitude,
            arguments['currentLocation'].longitude),
        zoom: 14.0));
    var screenSize = MediaQuery.of(context).size;

    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add new address',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  authProvider.searchController.clear();
                  authProvider.mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              currentLocation.latitude, currentLocation.longitude),
                          zoom: 17.0),
                    ),
                  );
                },
                label: const Text(
                  "Use current location",
                  style: TextStyle(color: Colors.black),
                ),
                icon: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
              )),
          body: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
                  zoom: 14.0,
                ),
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  setState(() {
                    authProvider.mapController = controller;
                  });
                },
                onCameraMove: (position) {
                  cameraPositionNotifier!.value = position;
                },
              ),
              const Center(
                  child: Icon(Icons.location_pin,
                      color: AppColors.primaryColor, size: 50)),
              Positioned(
                  top: 10,
                  child: Container(
                    width: screenSize.width,
                    padding: const EdgeInsets.all(20),
                    child: GooglePlacesAutoCompleteTextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        inputDecoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: InkWell(
                              onTap: () {
                                authProvider.searchController.clear();
                              },
                              child: const Icon(Icons.clear)),
                          hintText: 'Search a place',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textEditingController: authProvider.searchController,
                        googleAPIKey: UrlConstant.googleApiKey,
                        debounceTime: 400,
                        countries: const ["In"],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            authProvider.location = prediction.description ?? "Search location";
                          });
                          var newLatLng = LatLng(double.parse(prediction.lat!),
                              double.parse(prediction.lng!));

                          authProvider.mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: newLatLng, zoom: 17),
                            ),
                          );
                        },
                        itmClick: (prediction) async {
                          authProvider.searchController.text = prediction.description!;
                          authProvider.searchController.selection = TextSelection.fromPosition(
                              TextPosition(offset: prediction.description!.length));
                        }),
                  ))
            ],
          ),
          bottomNavigationBar: _buildMapConfirmationBar(screenSize, arguments),
        );

      },
    );
  }

  Widget _buildMapConfirmationBar(
      Size screenSize, Map<dynamic, dynamic> arguments) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return ValueListenableBuilder<CameraPosition>(
          valueListenable: cameraPositionNotifier!,
          builder: (context, cameraPosition, _) {
            return FutureBuilder<Map<String, dynamic>>(
              future:
              authProvider.getAddressFromLatLong(cameraPosition.target),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: screenSize.height / 6,
                    width: screenSize.width,
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                      padding: const EdgeInsets.all(20),
                      width: screenSize.width,
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 40,
                                color: AppColors.primaryColor,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!['subLocality'] != ""
                                        ? snapshot.data!['subLocality']
                                        : snapshot.data!['name'].toString(),
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: screenSize.width / 2,
                                      child: Text(
                                        snapshot.data!['locality'],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showInputCompleteAddressModal(context, snapshot.data!,
                                  cameraPosition.target, arguments,authProvider);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 13.0),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Enter full address',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
                } else {
                  return Container(
                    width: screenSize.width,
                    height: screenSize.height / 4,
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Error retrieving location',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            );
          },
        );

      },
    );
  }

  showInputCompleteAddressModal(
      BuildContext context,
      Map<String, dynamic> locationData,
      LatLng target,
      Map<dynamic, dynamic> arguments, AuthProvider authProvider) {
    final formKey = GlobalKey<FormState>();

    TextEditingController addressController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController postalCodeController = TextEditingController();
    postalCodeController.text = locationData['postalCode'].toString();
    stateController.text = locationData['administrativeArea'].toString();
    cityController.text = locationData['subAdministrativeArea'].toString();
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Enter address details",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter complete address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.line_weight),
                        hintText: 'Complete address',
                        counterText: "",
                        isCollapsed: true,
                        filled: true,
                        fillColor: AppColors.inputFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: stateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.countertops_outlined),
                        hintText: 'State',
                        counterText: "",
                        isCollapsed: true,
                        filled: true,
                        fillColor: AppColors.inputFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        hintText: 'City',
                        counterText: "",
                        isCollapsed: true,
                        filled: true,
                        fillColor: AppColors.inputFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: postalCodeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your postal code';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.pin_drop),
                        hintText: 'Postal Code',
                        counterText: "",
                        isCollapsed: true,
                        filled: true,
                        fillColor: AppColors.inputFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          authProvider.registerNewStore(context);
                          print("hello");
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.dashboardRoute, (route) => false);
                        }
                        return;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Save address',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
