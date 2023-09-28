import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/src/common_widgets/remove_scroll_glow.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/src/ui/conetWebPage.dart';
import 'package:conet/src/ui/deleteAccount.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/settings/changePassword.dart';
import 'package:conet/src/ui/settings/myprofile.dart';
import 'package:conet/src/ui/settings/socialContact.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/check_internet_connection.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gtm/gtm.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../../../api_models/getTotalCount_response_model/totalCount_response_body.dart';
import '../../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../../bottomNavigation/bottomNavigationBloc.dart';
import '../../../utils/gtm_constants.dart';

class Settings extends StatefulWidget {
  List<TotalCountResponseData> totalcount;

  Settings({super.key, required this.totalcount});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  TextEditingController? _outputController;
  final List<DeviceContactData> _importportcontacts = [];
  final gtm = Gtm.instance;
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
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: const Color(0xFFF0F0F0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Icon(Icons.more_vert, color: AppColor.whiteColor)),
            onSelected: (value) {
              print(value);

              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteAccount()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    fontFamily: kSfproDisplayFontFamily,
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: double.infinity,
        child: ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 21.w),
              child: Column(
                children: [
                  Container(
                    height: 75.h,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, top: 10.h),
                      onTap: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        gtm.push(GTMConstants.kprofileviewEvent,
                            parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyProfile(preferences.getString("phone")),
                          ),
                        );
                      },
                      title: Text("My Profile",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontWeight: FontWeight.w400)),
                      subtitle: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Business, ",
                                style: TextStyle(
                                    color: AppColor.accentColor,
                                    fontSize: 13.sp,
                                    fontFamily: kSfproRoundedFontFamily,
                                    fontWeight: FontWeight.w300)),
                            TextSpan(
                              text: "Personal",
                              style: TextStyle(
                                  color: AppColor.SettingprofileIconColor,
                                  fontSize: 13.sp,
                                  fontFamily: kSfproRoundedFontFamily,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_profile.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePassword(),
                          ),
                        );
                      },
                      title: Text("Change Password",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_changepsw.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        _checkContactPermission();
                      },
                      title: Text("Import Contacts",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_contactlist.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        _checkPermission();
                      },
                      title: Text("QR Code Scanner",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_qrscan.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1.h, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialContact(),
                          ),
                        );
                      },
                      title: Text("Social Connect",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_socialconnect.svg",
                          height: 24.h,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Uri emailLaunchUri =
                            Uri(scheme: 'mailto', path: "thekonetapp@gmail.com", queryParameters: {'subject': null});
                        launch(emailLaunchUri.toString());
                      },
                      title: Text("Contact us",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_contactus.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1.h, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      title: Text("Notifications",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_notification.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1.h, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Share.share(
                            'Hey\n\nKonet is a fast, simple and secure app that i use to message and call the people.\n\nGet it for free at https://play.google.com/store/apps/details?id=com.shade6.agratrade',
                            subject: 'Look what I made!');
                      },
                      title: Text("Invite to KONET App",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_invite.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Divider(height: 1.h, color: Colors.grey.shade200),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape:
                                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                              backgroundColor: Colors.white,
                              title: Center(
                                child: Text("Logout",
                                    style: TextStyle(
                                        color: AppColor.logoutcolor,
                                        fontFamily: kSfproDisplayFontFamily,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                              content: Text(
                                "Are you sure you want to logout ?",
                                style: TextStyle(
                                    color: AppColor.logoutheadingcolor,
                                    fontFamily: kSfproRoundedFontFamily,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(minWidth: 100.0.w),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                            )),
                                        child: Text("Yes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: kSfproRoundedFontFamily,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          logoutFun();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                      constraints: BoxConstraints(minWidth: 100.0.w),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.w)),
                                            )),
                                        child: Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: kSfproRoundedFontFamily,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      },
                      title: Text("Logout",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontFamily: kSfproDisplayFontFamily,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400)),
                      leading: Container(
                        height: 34.w,
                        width: 34.w,
                        child: SvgPicture.asset(
                          "assets/icons/ic_settings_logout.svg",
                          height: 24.w,
                          width: 24.w,
                        ),
                      )),
                  Center(
                    child: Text(
                      "v.$version",
                      style:
                          TextStyle(fontSize: 11.sp, fontFamily: kSfproRoundedFontFamily, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SvgPicture.asset(height: 22.h, "assets/logo_orange.svg"),
                  SizedBox(height: 10.h),
                  Text("$totalUsers+ users Worldwide",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        fontStyle: FontStyle.normal,
                      )),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.only(left: 33.w, right: 33.w),
                    child: Text("With your $totalContact contacts, you have $totalConnection connections",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.accentColor,
                          fontFamily: kSfproRoundedFontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  SizedBox(height: 34.h),
                ],
              ),
            ),
          ),
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
      BlocProvider.of<BottomNavigationBloc>(context).getRemoveContactData();
      gtm.push(GTMConstants.kLogoutEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      Utils.displayToastNoAutoClose('Please check your internet connection', context);
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
        Utils.displayToastBottomError("Permission Denied", context);
      } else if (reqStatus.isPermanentlyDenied) {
        Utils.displayToastBottomError(
            "App does not have permission to access the camera. Please go the device settings and allow this app camera permissions",
            context);
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
          Utils.displayToastBottomError("Invalid QR code", context);
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
    var Qrresponse = await ContactBloc().sendQrValue(QrValueRequestBody(
      value: _outputController?.text,
      qrcode: true,
    ));
    if (Qrresponse['status'] == true) {
      Utils.displayToast("Scanned successfully", context);
      try {
        // var requestBody = {
        //   "phone": _outputController!.text,
        // };
        var response = await ContactBloc()
            .checkContactForAddNew(CheckContactForAddNewRequestBody(phone: Qrresponse["contact"]["phone"]));
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
          Utils.displayToastTopError(response["message"], context);
        }
      } catch (e) {
        print(e);
      }
    } else if (Qrresponse['status'] == "Token is Expired") {
      Utils.displayToastBottomError('Token is Expired', context);
      tokenExpired(context);
    } else {
      Utils.displayToastBottomError('Something went wrong', context);
    }
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.w), // Set the desired border radius
          ),
          title: Center(
            child: Text(
              'Confirmation',
              style: TextStyle(
                  color: Color(0xff3F3D56),
                  fontFamily: kSfproDisplayFontFamily,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: Text(
            'Do you want to import contacts to konet? \n This app requires contacts access to sync contacts with user account on cloud so that user can view & manage it from anywhere.',
            style: TextStyle(
                color: Color(0xff878B95),
                fontFamily: kSfproRoundedFontFamily,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100.0.w),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.w)),
                        )),
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Yes',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: kSfproRoundedFontFamily,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 100.0.w),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.w)),
                        )),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kSfproRoundedFontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )
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

  // _checkContactPermission() async {
  //   var status = await Permission.contacts.status;
  //   if (status.isGranted) {
  //     gtm.push(GTMConstants.kimportContactsEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
  //     _importContacts();
  //   } else {
  //     var reqStatus = await Permission.contacts.request();
  //     if (reqStatus.isGranted) {
  //       _importContacts();
  //     } else if (reqStatus.isDenied) {
  //       Utils.displayToastBottomError("Permission Denied", context);
  //     } else if (reqStatus.isPermanentlyDenied) {
  //       Utils.displayToastBottomError("Permission Denied Permanently", context);
  //       openAppSettings();
  //     } else {
  //       Utils.displayToastBottomError("Something Went Wrong ", context);
  //     }
  //   }
  // }

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
      if (response != null && response['status'] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('imported', true);
        setState(() {
          _loader = false;
        });
        Utils.displayToast("Successfully imported", context);
      } else if (response != null && response['status'] == "Token is Expired") {
        tokenExpired(context);
        setState(() {
          _loader = false;
        });
      } else if (response == null) {
        setState(() {
          _loader = false;
        });
        Utils.displayToastBottomError("Connection Time Out\n Try Again", context);
      } else {
        setState(() {
          _loader = false;
        });
        Utils.displayToastBottomError("Something went wrong", context);
      }
    } catch (e) {
      print(e);
      setState(() {
        _loader = false;
      });
      Utils.displayToastBottomError("Something went wrong", context);
    }
  }

  _checkContactPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      gtm.push(GTMConstants.kimportContactsEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
      _importContacts();
    } else {
      var reqStatus = await Permission.contacts.request();
      print(" reqstatus $reqStatus");
      if (reqStatus.isGranted) {
        _importContacts();
      } else if (reqStatus.isDenied || reqStatus.isPermanentlyDenied) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          width: 300,
          title: reqStatus.isDenied ? "Permission Denied" : "Permission Denied Permanently",
          text:
              "This app requires contacts access to sync contacts with user account on cloud so that user can view & manage it from anywhere.'",

          confirmBtnText: "Settings",
          cancelBtnText: "Back",

          onConfirmBtnTap: () => openAppSettings(),

          //autoCloseDuration: const Duration(seconds: 3),
        );

        // openAppSettings();
      } else {
        Utils.displayToastBottomError("Something Went Wrong in Contact Permissions", context);
      }
    }
  }

  Future<void> setValue() async {
    try {
      totalUsers = widget.totalcount[0].totalUsers ?? 0;
      totalConnection = widget.totalcount[0].totalConnection ?? 0;
      totalContact = widget.totalcount[0].totalContact ?? 0;
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        setState(() {
          version = packageInfo.version;
        });
      });
    } catch (e) {}
  }
}
