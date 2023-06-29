import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroVerify extends StatefulWidget {
  const IntroVerify({super.key});

  @override
  _IntroVerifyState createState() => _IntroVerifyState();
}

class _IntroVerifyState extends State<IntroVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fontSize: 18.sp,
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
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      SizedBox(height: 14.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Text(
          "Connect with your contacts through our KONET WEB feature and conduct business like never before",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      )
    ],
  );
}
