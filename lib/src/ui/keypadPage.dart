import 'package:conet/repositories/recentPageRepository.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
import 'package:conet/utils/gtm_constants.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/gtm.dart';

import 'dailpad.dart';

class KeypadPage extends StatefulWidget {
  var contactsData;

  KeypadPage({super.key, this.contactsData});

  @override
  State<KeypadPage> createState() => _KeypadPageState();
}

class _KeypadPageState extends State<KeypadPage> {
  RecentPageRepository recentPageRepository = RecentPageRepository();
  final gtm = Gtm.instance;
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
        centerTitle: false,
        backgroundColor: AppColor.primaryColor,
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        leadingWidth: 80.w,
        title: KonetLogo(
          logoHeight: 24.h,
          fontSize: 19.sp,
          textPadding: 9,
          spacing: 9,
        ),
        elevation: 0.0,
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: DialPadCustom(
          enableDtmf: false,
          backspaceButtonIconColor: AppColor.primaryColor,
          buttonTextColor: AppColor.primaryColor,
          buttonColor: AppColor.whiteColor,
          dialButtonColor: AppColor.primaryColor,
          dialButtonIconColor: AppColor.primaryColor,
          contactList: widget.contactsData,
          makeCall: (number) {
            if (number == "") {
              return;
            }

            recentPageRepository.insertDailedCall(number);
            gtm.push(GTMConstants.kCallEvent, parameters: {"status": "done"});
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
