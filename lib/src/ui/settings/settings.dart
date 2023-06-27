import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/src/ui/conetWebPage.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/settings/changePassword.dart';
import 'package:conet/src/ui/settings/myprofile.dart';
import 'package:conet/src/ui/settings/socialContact.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../networking/apiBaseHelper.dart';

class Settings extends StatefulWidget {
  var totalcount;

  Settings({this.totalcount}) : super();
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  TextEditingController? _outputController;
  final List<DeviceContactData> _importportcontacts = [];
  bool _loader = false;

  int totalUsers = 0;
  int totalConnection = 0;
  int totalContact = 0;
  var version = "";

  @override
  void initState() {
    super.initState();

    setValue();

    _outputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: SvgPicture.asset(
          "assets/logo.svg",
          height: 20,
          width: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MyProfile(preferences.getString("phone")),
                  ),
                );
              },
              title: Text("My Profile", style: Theme.of(context).textTheme.headline3),
              subtitle: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "Business, ",
                        style: Theme.of(context).textTheme.headline3!.apply(color: AppColor.accentColor)),
                    TextSpan(
                      text: "Personal",
                      style: Theme.of(context).textTheme.headline3!.apply(color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_profile.svg",
                height: 40,
              ),
            ),
            // Divider(height: 1, color: Colors.grey.shade200),
            // ListTile(
            //   onTap: () {},
            //   title: Text(
            //     "Contact List",
            //     style: TextStyle(
            //         fontSize: 18.0,
            //         fontFamily: "Sf-Regular",
            //         color: AppColor.blackColor),
            //   ),
            //   leading: SvgPicture.asset(
            //     "assets/icons/ic_settings_contactlist.svg",
            //     height: 40,
            //   ),
            // ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ),
                );
              },
              title: Text(
                "Change Password",
                style: Theme.of(context).textTheme.headline3,
              ),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_changepsw.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                _showDialog();
              },
              title: Text("Import Contacts", style: Theme.of(context).textTheme.headline3),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_contactlist.svg",
                height: 40,
              ),
            ),

            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                _checkPermission();
              },
              title: Text("QR Code Scanner", style: Theme.of(context).textTheme.headline3),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_qrscan.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SocialContact(),
                  ),
                );
              },
              title: Text("Social Connect", style: Theme.of(context).textTheme.headline3),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_socialconnect.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                Uri emailLaunchUri =
                    Uri(scheme: 'mailto', path: "thekonetapp@gmail.com", queryParameters: {'subject': null});
                launch(emailLaunchUri.toString());
              },
              title: Text("Contact us", style: Theme.of(context).textTheme.headline3),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_contactus.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              title: Text(
                "Notifications",
                style: Theme.of(context).textTheme.headline3,
              ),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_notification.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConetWebPage(),
                  ),
                );
              },
              title: Text(
                "Invite to KONET app",
                style: Theme.of(context).textTheme.headline3,
              ),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_invite.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                      backgroundColor: Colors.white,
                      title: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      content: Text(
                        "Are you sure you want to logout ?",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text("Yes",
                              style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            logoutFun();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              title: Text("Logout", style: Theme.of(context).textTheme.headline3),
              leading: SvgPicture.asset(
                "assets/icons/ic_settings_logout.svg",
                height: 40,
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "v.$version",
                style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            SvgPicture.asset(
              "assets/logo_orange.svg",
              height: 30,
            ),

            const SizedBox(height: 10),
            Text("$totalUsers users Worldwide",
                style: const TextStyle(
                  color: AppColor.secondaryColor,
                  fontFamily: 'Sfpro-Rounded-Medium',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text("With your $totalContact contacts, you have $totalConnection connections",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.accentColor,
                    fontFamily: 'Sfpro-Rounded-Semibold',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  logoutFun() async {
    bool hasInternet = await checkInternetConnection();
    if (hasInternet) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      await databaseHelper.trancateAllContacts();
      await databaseHelper.trancateRecentContacts();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        Utils.displaySnackBar(
          'Please check your internet connection',
          duration: const Duration(seconds: 1),
          backgroundColor: AppColor.redColor,
        ),
      );
    }
  }

  _checkPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      scanQrCode();
    } else {
      var reqStatus = await Permission.camera.request();
      if (reqStatus.isGranted) {
        scanQrCode();
      } else if (reqStatus.isDenied) {
        Utils.displayToast("Permission Denied");
      }
    }
  }

  scanQrCode() async {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => const QRScreen(),
    ))
        .then((value) {
      if (value != null) {
        _outputController!.clear();
        _outputController!.text = value!;
        if (_outputController!.text != '') {
          setState(() {
            _loader = true;
          });
          _sendQrApi();
        } else {
          Utils.displayToastBottomError("Invalid QR code");
        }
      }
    });
    // String? barcode = await scanner.scan();
    // setState(() {
    //   _outputController!.clear();
    //   _outputController!.text = barcode!;
    // });
    // if (_outputController!.text != '') {
    //   _sendQrApi();
    // }
  }

  _sendQrApi() async {
    var contactDetail;
    var requestBody = {"value": _outputController!.text, "qrcode": true};
    var response = await ContactBloc().sendQrValue(requestBody);
    if (response['status'] == true) {
      Utils.displayToast("Scanned successfully");
      try {
        var requestBody = {
          "phone": _outputController!.text,
        };
        var response = await ContactBloc().checkContactForAddNew(requestBody);
        if (response["user"] != null) {
          contactDetail = ContactDetail.fromJson(response["user"]);
          setState(() {
            _loader = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return AddContactUserProfilePage(
                  contactDetails: contactDetail,
                  conetUser: true,
                );
              },
            ),
          );
        } else {
          setState(() {
            _loader = false;
          });
          Fluttertoast.cancel();
          Utils.displayToastTopError(response["message"]);
        }
      } catch (e) {
        Utils.displayToastTopError("Something went wrong");
      }
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToast('Token is Expired');
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong');
    }
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            'Confirmation',
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            'Do you want to import contacts to konet?',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'No',
                style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes', style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor)),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == null) return;

      if (value) {
        print(value);
        SchedulerBinding.instance.addPostFrameCallback((_) => _checkContactPermission());
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('imported', true);
      }
    });
  }

  _checkContactPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      _importContacts();
    } else {
      var reqStatus = await Permission.contacts.request();
      if (reqStatus.isGranted) {
        _importContacts();
      } else if (reqStatus.isDenied) {
        Utils.displayToast("Permission Denied");
      } else if (reqStatus.isPermanentlyDenied) {
        Utils.displayToast("Permission Denied Permanently");
        openAppSettings();
      } else {
        Utils.displayToast("Something Went Wrong ");
      }
    }
  }

  _importContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);

    for (var item in contacts) {
      if (item.phones!.toList().isNotEmpty) {
        DeviceContactData data = DeviceContactData(item.displayName, item.phones!.toList()[0].value);
        _importportcontacts.add(data);
      }
    }
    callImportApi();
  }

  callImportApi() async {
    setState(() {
      _loader = true;
    });
    try {
      var response = await ContactBloc().importContacts(_importportcontacts);
      if (response['status'] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('imported', true);
        setState(() {
          _loader = false;
        });
        Utils.displayToast("Successfully imported");
      } else if (response['status'] == "Token is Expired") {
        tokenExpired(context);
        setState(() {
          _loader = false;
        });
      } else {
        setState(() {
          _loader = false;
        });
        Utils.displayToast("Something went wrong");
      }
    } catch (e) {
      print(e);
      setState(() {
        _loader = false;
      });
      Utils.displayToast("Something went wrong");
    }
  }

  Future<void> setValue() async {
    try {
      totalUsers = widget.totalcount[0]['totalUsers'];
      totalConnection = widget.totalcount[0]['totalConnection'];
      totalContact = widget.totalcount[0]['totalContact'];
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        setState(() {
          version = packageInfo.version;
        });
      });
    } catch (e) {}
  }
}
