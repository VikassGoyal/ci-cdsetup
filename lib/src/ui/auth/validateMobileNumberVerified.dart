import 'package:conet/src/homeScreen.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';

class ValidateMobileNumberVerified extends StatefulWidget {
  @override
  _ValidateMobileNumberVerifiedState createState() =>
      _ValidateMobileNumberVerifiedState();
}

class _ValidateMobileNumberVerifiedState
    extends State<ValidateMobileNumberVerified> {
  final _signupFormKey = GlobalKey<FormState>();
  final bool _loader = false;

  @override
  Widget build(BuildContext context) {
    Widget verifiedButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            "Verified",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .button
                ?.apply(color: AppColor.whiteColor),
          ),
        ),
      );
    }

    Widget termAndCondition() {
      TextStyle defaultStyle = const TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontFamily: "Sf-Regular",
        letterSpacing: 0.2,
      );
      TextStyle linkStyle = const TextStyle(
        color: AppColor.secondaryColor,
        fontSize: 15.0,
        fontFamily: "Sf-Bold",
        letterSpacing: 0.2,
      );
      return Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
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
                  },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy.',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Privacy Policy"');
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
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: AppColor.whiteColor,
            ),
          ),
          title: Text(
            "Back",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: AppColor.whiteColor),
          ),
        ),
        body: LoadingOverlay(
          isLoading: _loader,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Validate your",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    Text(
                      "Mobile Number",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We will verify your phone number via missed call;",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    Text(
                      "click the button to begin the verification process.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Lottie.asset(
                        'assets/json/lottie_tick.json',
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.fill,
                        repeat: false,
                      ),
                    ),
                    // Center(
                    //   child: Lottie.asset(
                    //     'assets/json/introscreen.json',
                    //     width: MediaQuery.of(context).size.width * 0.6,
                    //     height: MediaQuery.of(context).size.width * 0.6,
                    //     fit: BoxFit.fill,
                    //     repeat: false,
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    verifiedButton(),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "By signing up, you're agree to our  ",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.apply(color: AppColor.whiteColor),
                      ),
                    ),
                    termAndCondition(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
