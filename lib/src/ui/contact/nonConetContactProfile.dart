import 'dart:io';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/src/ui/contactsPage.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/gtm_constants.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/gtm.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api_models/deleteContact__request_model/deleteContact.dart';
import '../../../api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import '../../../blocs/contactBloc.dart';
import '../utils.dart';

class NonConetContactProfile extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final int? id;

  const NonConetContactProfile(this.name, this.phoneNumber, this.email, this.id, {super.key});

  @override
  State<NonConetContactProfile> createState() => _NonConetContactProfileState();
}

class _NonConetContactProfileState extends State<NonConetContactProfile> {
  final _personalNumber = TextEditingController();
  final _personalEmail = TextEditingController();
  final _personalName = TextEditingController();
  bool _updatepage = false;

  ContactDetail? contactDetail;

  final bool _loader = false;
  final bool _loaderoverflow = false;
  bool personalTab = true;
  final gtm = Gtm.instance;
  @override
  void initState() {
    super.initState();
    _personalName.text = widget.name!;
    _personalNumber.text = widget.phoneNumber!;
    _personalEmail.text = widget.email!;
    _updatepage = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMobileNumber() {
      return TextFormFieldContact(
        hintText: "Mobile number",
        padding: 14.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalNumber,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildEmailId() {
      return TextFormFieldContact(
        hintText: "Email",
        padding: 14.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalEmail,
        parametersValidate: "Please enter Email.",
      );
    }

    Widget _buildformBody() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Visibility(
              visible: _personalNumber.text == '' ? false : true,
              child: _buildMobileNumber(),
            ),
            SizedBox(height: 10.h),
            Visibility(
              visible: _personalEmail.text == '' ? false : true,
              child: _buildEmailId(),
            ),
            SizedBox(height: _personalEmail.text == '' ? 0 : 50.h),
            SizedBox(height: MediaQuery.of(context).size.height / 2.9),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
              ),
              onPressed: () async {
                print("clicked");

                Share.share(
                    'Hey\n\nKonet is a fast, simple and secure app that i use to message and call the people.\n\nGet it for free at https://play.google.com/store/apps/details?id=com.shade6.agratrade',
                    subject: 'Look what I made!');
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 50.h),
                alignment: Alignment.center,
                child: Text(
                  "Invite to KONET",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: kSfproRoundedFontFamily,
                    color: AppColor.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 36.h),
          ],
        ),
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          SizedBox(height: 110.h),
          Text(
            _personalName.text ?? "Unknown Number",
            style: TextStyle(
              fontFamily: kSfproRoundedFontFamily,
              color: AppColor.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber == null) {
                        return;
                      }
                      callChatMessenger(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_message.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber.text == '') {
                        return;
                      }
                      gtm.push(GTMConstants.kCallEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                      _callNumber(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_call.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      var whatsappnumber = _personalNumber.text;
                      whatsappnumber = whatsappnumber.replaceAll("-", "");
                      whatsappnumber = whatsappnumber.replaceAll(" ", "");

                      if (whatsappnumber.length == 10) {
                        whatsappnumber = "+91$whatsappnumber";
                      }

                      openwhatsapp(whatsappnumber);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_whatsapp.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalEmail.text == "") {
                        Utils.displayToastBottomError("Mail id not found", context);
                        return;
                      }

                      Uri emailLaunchUri =
                          Uri(scheme: 'mailto', path: _personalEmail.text, queryParameters: {'subject': null});
                      launch(emailLaunchUri.toString());
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_mail.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _buildformBody(),
        ],
      );
    }

    Widget stackContainer() {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 60.h,
                color: AppColor.primaryColor,
              ),
              bodyContent()
            ],
          ),
          Positioned(
            top: 10.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 110.w,
                  height: 110.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          leadingWidth: 80.w,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(_updatepage);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Back',
                  style: TextStyle(
                    fontFamily: kSfproRoundedFontFamily,
                    color: AppColor.whiteColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            "Contact",
            style: TextStyle(
              fontFamily: kSfproRoundedFontFamily,
              color: AppColor.whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          actions: [
            PopupMenuButton(
              color: const Color(0xFFF0F0F0),
              elevation: 10,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Center(child: Icon(Icons.more_horiz, color: AppColor.whiteColor)),
              ),
              onSelected: (value) async {
                print(value);
                if (value == 2) {
                  String contactName = _personalName.text;
                  String phoneNumber = _personalNumber.text;
                  String message = 'Name: $contactName\nPhone: $phoneNumber';
                  Share.share(message);
                  gtm.push(GTMConstants.kContactShareEvent,
                      parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                }
                if (value == 1) {
                  //   Add the delete contact  api call functionality . i have created updatepage bool by default value false . if contact delete successfully make it true else false
                  try {
                    var response = await ContactBloc().deleteContact(widget.id ?? 0);
                    if (response['success'] == true) {
                      gtm.push(GTMConstants.kcontactDeleteEvent,
                          parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Success',
                        text: response['message'].toString(),
                      );
                      _updatepage = true;
                      Navigator.of(context).pop(_updatepage);

                      // );
                      return;
                    } else {
                      Utils.displayToastBottomError(response["message"], context);
                      return;
                    }
                  } catch (e) {
                    print(e);
                    return;
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontFamily: kSfproDisplayFontFamily,
                      color: AppColor.blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Share",
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
        // bottomNavigationBar: BottomAppBar(
        //   elevation: 0,
        //   height: 86.h,
        //   child: Container(
        //     color: AppColor.whiteColor,
        //     padding: EdgeInsets.only(bottom: 36.h, left: 21.w, right: 21.w),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
        //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
        //       ),
        //       onPressed: () async {
        //         print("clicked");
        //         Share.share(
        //             'Hey\n\nKonet is a fast, simple and secure app that i use to message and call the people.\n\nGet it for free at https://play.google.com/store/apps/details?id=com.shade6.agratrade',
        //             subject: 'Look what I made!');
        //       },
        //       child: Container(
        //         constraints: BoxConstraints(
        //           minHeight: 50.h,
        //         ),
        //         alignment: Alignment.center,
        //         child: Text(
        //           "Invite to KONET",
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        body: LoadingOverlay(
          isLoading: _loaderoverflow,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
          ),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: stackContainer(),
            ),
          ),
        ));
  }

  _callNumber(String phone) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phone);
    } catch (e) {
      print(e);
    }
  }

  callChatMessenger(phoneNumber) async {
    var uri = 'sms:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      var uri = 'sms:$phoneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  openwhatsapp(whatsapp) async {
    // var whatsapp = "+919566664128";
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp;
    var whatappURLIos = "https://wa.me/$whatsapp";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        Utils.displayToastBottomError("whatsapp no installed", context);
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        Utils.displayToastBottomError("whatsapp no installed", context);
      }
    }
  }
}
