// ignore_for_file: file_names

import 'package:conet/src/ui/auth/privacyPolicy.dart';
import 'package:conet/src/ui/auth/termsofuse.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/auth/validateMobileNumberVerified.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'login.dart';

class ValidateMobileNumber extends StatefulWidget {
  const ValidateMobileNumber({super.key});

  @override
  _ValidateMobileNumberState createState() => _ValidateMobileNumberState();
}

class _ValidateMobileNumberState extends State<ValidateMobileNumber> {
  final _validateMobileFormKey = GlobalKey<FormState>();
  final bool _loader = false;

  @override
  Widget build(BuildContext context) {
    Widget _buildMissedCall() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          print("clicked");
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 50.h),
          alignment: Alignment.center,
          child: Text(
            "Give  Missed Call",
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
      );
    }

    Widget _buildGenerateOTP() {
      return InkWell(
        onTap: () {
          print("signin");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ValidateMobileNumberVerified()),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Use SMS to generate OTP  ",
                style: TextStyle(
                  fontFamily: kSfproDisplayFontFamily,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "Click here",
                style: TextStyle(
                  fontFamily: kSfproDisplayFontFamily,
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget termAndCondition() {
      TextStyle defaultStyle = TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
        fontFamily: kSfproRoundedFontFamily,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.2,
      );
      TextStyle linkStyle = TextStyle(
        color: AppColor.secondaryColor,
        fontSize: 15.sp,
        fontFamily: kSfproRoundedFontFamily,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.2,
      );
      return Center(
        child: RichText(
          text: TextSpan(
            style: defaultStyle,
            children: <TextSpan>[
              TextSpan(
                text: 'Terms of Use',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms of Service"');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsOfUse()));
                  },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy.',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Privacy Policy"');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                  },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          leadingWidth: 80.w,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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
        ),
        body: LoadingOverlay(
          isLoading: _loader,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _validateMobileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "Validate your",
                      style: TextStyle(
                        fontFamily: kSfproRoundedFontFamily,
                        color: AppColor.whiteColor,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                        fontFamily: kSfproRoundedFontFamily,
                        color: AppColor.whiteColor,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "We will verify your phone number via missed call;",
                      style: TextStyle(
                        fontFamily: kSfproRoundedFontFamily,
                        color: AppColor.whiteColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      "click the button to begin the verification process.",
                      style: TextStyle(
                        fontFamily: kSfproRoundedFontFamily,
                        color: AppColor.whiteColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Center(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/images/validateMobileNumber.png",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMissedCall(),
                          SizedBox(height: 16.h),
                          Center(
                            child: Text(
                              "By signing up, you're agree to our",
                              style: TextStyle(
                                fontFamily: kSfproRoundedFontFamily,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          termAndCondition(),
                          SizedBox(height: 42.h),
                          _buildGenerateOTP(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
