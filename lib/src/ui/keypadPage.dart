import 'package:conet/repositories/recentPageRepository.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dailpad.dart';

class KeypadPage extends StatefulWidget {
  var contactsData;

  KeypadPage({this.contactsData}) : super();

  @override
  _KeypadPageState createState() => _KeypadPageState();
}

class _KeypadPageState extends State<KeypadPage> {
  RecentPageRepository recentPageRepository = RecentPageRepository();

  @override
  void initState() {
    super.initState();
    print(widget.contactsData);
    print("_____________");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: SvgPicture.asset(
          "assets/logo.svg",
          height: 24,
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: DialPadCustom(
          enableDtmf: false,
          backspaceButtonIconColor: AppColor.primaryColor,
          buttonTextColor: AppColor.whiteColor,
          buttonColor: AppColor.primaryColor,
          dialButtonColor: AppColor.primaryColor,
          dialButtonIconColor: AppColor.primaryColor,
          contactList: widget.contactsData,
          makeCall: (number) {
            if (number == "") {
              return;
            }
            recentPageRepository.insertDailedCall(number);
            _callNumber(number);
          },
        ),
      ),
    );
  }

  _callNumber(String phone) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phone);
    } catch (e) {
      print(e);
    }
  }
}