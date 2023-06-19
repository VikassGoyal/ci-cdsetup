import 'dart:io';

import 'package:conet/models/contactDetails.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils.dart';

class NonConetContactProfile extends StatefulWidget {
  String? name;
  String? phoneNumber;
  String? email;

  NonConetContactProfile(this.name, this.phoneNumber, this.email);

  @override
  _NonConetContactProfileState createState() => _NonConetContactProfileState();
}

class _NonConetContactProfileState extends State<NonConetContactProfile> {
  final _personalNumber = TextEditingController();
  final _personalEmail = TextEditingController();
  final _personalName = TextEditingController();

  ContactDetail? contactDetail;

  final bool _loader = false;
  final bool _loaderoverflow = false;
  bool personalTab = true;

  @override
  void initState() {
    super.initState();
    _personalName.text = widget.name!;
    _personalNumber.text = widget.phoneNumber!;
    _personalEmail.text = widget.email!;
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
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Visibility(
              visible: _personalNumber.text == '' ? false : true,
              child: _buildMobileNumber(),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _personalEmail.text == '' ? false : true,
              child: _buildEmailId(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 2.5),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
              ),
              onPressed: () async {
                print("clicked");
                Share.share(
                    'Hey\n\nConet is a fast, simple and secure app that i use to message and call the people.\n\nGet it for free at https://play.google.com/store/apps/details?id=com.shade6.agratrade',
                    subject: 'Look what I made!');
              },
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Invite to CONET",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          const SizedBox(height: 110),
          Text(_personalName.text ?? "Unknown Number", style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
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
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber.text == '') {
                        return;
                      }
                      _callNumber(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_call.svg",
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
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
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalEmail.text == '') {
                        Utils.displayToast("Mail id not found");
                        return;
                      }

                      Uri emailLaunchUri =
                          Uri(scheme: 'mailto', path: _personalEmail.text, queryParameters: {'subject': null});
                      launch(emailLaunchUri.toString());
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_mail.svg",
                      height: 56,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildformBody(),
          // Positioned.fill(
          //   child:
          // ),
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
                height: 60.0,
                color: AppColor.primaryColor,
              ),
              bodyContent()
            ],
          ),
          Positioned(
            top: 10.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
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
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_sharp,
                  color: AppColor.whiteColor,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "Back",
                  style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.whiteColor),
                )
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            "Contact",
            style: Theme.of(context).textTheme.headline4?.apply(color: AppColor.whiteColor),
          ),
          actions: [
            PopupMenuButton(
              color: const Color(0xFFF0F0F0),
              elevation: 10,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Icon(
                  Icons.more_horiz,
                  color: AppColor.whiteColor,
                ),
              ),
              onSelected: (value) {
                print(value);
                if (value == 2) {
                  String contactName = _personalName.text;
                  String phoneNumber = _personalNumber.text;
                  String message = 'Name: $contactName\nPhone: $phoneNumber';
                  Share.share(message);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Delete",
                    style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.blackColor),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Share",
                    style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.blackColor),
                  ),
                ),
              ],
            )
          ],
        ),
        body: LoadingOverlay(
          isLoading: _loaderoverflow,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
          ),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
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
        Utils.displayToast("whatsapp no installed");
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        Utils.displayToast("whatsapp no installed");
      }
    }
  }
}
