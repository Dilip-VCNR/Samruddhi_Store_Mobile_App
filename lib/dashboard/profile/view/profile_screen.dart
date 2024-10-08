import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/provider/auth_provider.dart';
import '../../../database/app_pref.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List options = [
    {'title': 'Edit Profile', 'icon': Icons.edit, 'clickType': 'edit_profile'},
    // {
    //   'title': 'Custom reports',
    //   'icon': Icons.event_note,
    //   'clickType': 'my_address'
    // },
    // {
    //   'title': 'Manage delivery type',
    //   'icon': Icons.delivery_dining,
    //   'clickType': 'my_orders'
    // },
    {'title': 'About', 'icon': Icons.info_outline, 'clickType': 'about'},
    {'title': 'FAQ’S', 'icon': Icons.question_mark_rounded, 'clickType': 'faq'},
    {
      'title': 'Privacy policy',
      'icon': Icons.fingerprint,
      'clickType': 'privacy'
    },
    {
      'title': 'Mail to us',
      'icon': Icons.mail_lock_outlined,
      'clickType': 'mail'
    },
    {
      'title': 'Terms and conditions',
      'icon': Icons.edit_note_rounded,
      'clickType': 'tc'
    },
    {
      'title': 'Log out',
      'icon': Icons.power_settings_new,
      'clickType': 'logout'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.profileScreenContext = context;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        key: ValueKey(
                            '${UrlConstant.imageBaseUrl}${prefModel.userData!.storeImgArray![0].imageUrl}'),
                        radius: 50,
                        backgroundImage: NetworkImage(
                            '${UrlConstant.imageBaseUrl}${prefModel.userData!.storeImgArray![0].imageUrl!}?v=${Random().nextInt(100)}'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenSize.width / 1.75,
                            child: Text(
                              '${prefModel.userData!.displayName}',
                              style: const TextStyle(
                                color: Color(0xFF3E3E3E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width / 1.75,
                            child: Text(
                              '${prefModel.userData!.mobile}',
                              style: const TextStyle(
                                color: Color(0xFF545454),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.53,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width / 1.75,
                            child: Text(
                              '${prefModel.userData!.emailId}',
                              style: const TextStyle(
                                color: Color(0xFF545454),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.53,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    height: 1,
                  ),
                  for (int i = 0; i < options.length; i++)
                    InkWell(
                      onTap: () async {
                        switch (options[i]['clickType']) {
                          case 'edit_profile':
                            authProvider.moveToEditProfile();
                            break;
                          case 'about':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.about,
                                  'title': "About",
                                });
                            break;
                          case 'faq':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.faq,
                                  'title': "FAQ'S",
                                });
                            break;
                          case 'privacy':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.privacyPolicy,
                                  'title': "Privacy Policy",
                                });
                            break;
                          case 'mail':
                            if (!await launchUrl(
                              Uri.parse("mailto:support@thebuysapp.com"),
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch');
                            }
                            break;
                          case 'tc':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.termsOfUse,
                                  'title': "Terms of use",
                                });
                            break;
                          case 'logout':
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LogoutConfirmationDialog();
                              },
                            ).then((confirmed) {
                              if (confirmed == true) {
                                prefModel.userData=null;
                                prefModel.selectedAddress=null;
                                AppPref.setPref(prefModel);
                                showSuccessToast(context, "Logout successful");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.loginRoute, (route) => false);
                              }
                            });
                            break;
                          default:
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: screenSize.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  options[i]['icon'],
                                  color: AppColors.fontColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  options[i]['title'],
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text("v1.1.2"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogoutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog and return false
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(true); // Dismiss the dialog and return true
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
