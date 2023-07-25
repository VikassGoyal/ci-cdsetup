import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroVerify extends StatefulWidget {
  const IntroVerify({super.key});

  @override
  _IntroVerifyState createState() => _IntroVerifyState();
}

double _width = 430;

class _IntroVerifyState extends State<IntroVerify> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, //for status bar colors
      //since there is no appBar used here so to give proper colors to the status bar, we used the AnnotatedRegion
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Column(
          children: [
            const Spacer(flex: 2),
            Center(
              child: GestureDetector(
                child: Image.asset(
                  "assets/images/screen4.png",
                  fit: BoxFit.cover,
                  width: displayWidth(context) * 0.84,
                ),
              ),
            ),
            const Spacer(flex: 1),
            introverifyBody(context),
            const Spacer(flex: 1),
            verifyBtn(context),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
          ],
        ),
      ),
    );
  }
}

Widget verifyBtn(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: 50.0.h,
        ),
        alignment: Alignment.center,
        child: Text(
          "Verify Now",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.whiteColor,
            fontSize: _width < 430 ? 18.sp : 14.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ),
  );
}

Widget introverifyBody(context) {
  return Column(
    children: [
      Center(
        child: Text(
          "Welcome to the KONET App",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.whiteColor,
            fontSize: _width < 430 ? 20.sp : 15.sp,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      SizedBox(height: 14.h),
      Center(
        child: Text(
          "Connect with your contacts through\n our KONET WEB feature and conduct\n business like never before",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kSfproDisplayFontFamily,
            color: AppColor.whiteColor,
            fontSize: _width < 430 ? 18.sp : 14.sp,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      )
    ],
  );
}
