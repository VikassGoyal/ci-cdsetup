import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:flutter/material.dart';

class IntroVerify extends StatefulWidget {
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
          const SizedBox(height: 130),
          Center(
            child: GestureDetector(
              child: Image.asset(
                "assets/images/screen4.png",
                fit: BoxFit.cover,
                width: displayWidth(context) * 0.84,
              ),
            ),
          ),
          Expanded(child: Container()),
          introverifyBody(context),
          const SizedBox(height: 50),
          verifyBtn(context),
          const SizedBox(height: 40)
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
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColor.secondaryColor),
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
        constraints: const BoxConstraints(
          minHeight: 50.0,
        ),
        alignment: Alignment.center,
        child: Text(
          "Continue",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .button
              !.apply(color: AppColor.whiteColor),
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
          "Welcome to the CONET App",
          style: Theme.of(context)
              .textTheme
              .headline2
              !.apply(color: AppColor.whiteColor),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: displayWidth(context) * 0.8,
        child: Text(
          "Connect with your contacts through our CONET WEB feature and conduct business like never before",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: AppColor.whiteColor
          )
        ),
      )
    ],
  );
}
