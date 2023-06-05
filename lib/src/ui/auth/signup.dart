import 'dart:async';
import 'package:conet/utils/constant.dart';
import 'package:flutter/services.dart';

import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/auth/privacyPolicy.dart';
import 'package:conet/src/ui/auth/termsofuse.dart';
import 'package:conet/src/ui/auth/validateMobileNumberVerified.dart';
import 'package:conet/src/ui/auth/verifyMobileNumber.dart';
import 'package:conet/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../utils.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signupFormKey = GlobalKey<FormState>();
  bool _loader = false;
  bool _nameError = false;
  bool _emailError = false;
  bool _mobileError = false;
  bool _passwordError = false;
  bool _showPassword = false;
  bool redirected = true;

  //Controller
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  //Focus
  final FocusNode _nameControllerFocus = FocusNode();
  final FocusNode _emailControllerFocus = FocusNode();
  final FocusNode _mobileControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget _buildName() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _nameError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _nameControllerFocus.requestFocus();
              },
              child: Container(
                height: 58,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                padding: const EdgeInsets.only(left: 21, right: 0),
                child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Name",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]))),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _nameController,
                focusNode: _nameControllerFocus,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
                  errorStyle: const TextStyle(color: Colors.white, height: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(color: Colors.white54),
                ),
                cursorColor: AppColor.whiteColor,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _nameError = true;
                    });
                    return '';
                  } else {
                    setState(() {
                      _nameError = false;
                    });
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      );
    }

    Widget _buildEmail() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _emailError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _emailControllerFocus.requestFocus();
              },
              child: Container(
                height: 58,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                padding: const EdgeInsets.only(left: 21, right: 0),
                child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Email",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]))),
              ),
            ),
            Expanded(
              child: TextFormField(
                focusNode: _emailControllerFocus,
                controller: _emailController,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
                  errorStyle: const TextStyle(color: Colors.white, height: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(color: Colors.white54),
                ),
                cursorColor: AppColor.whiteColor,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  // if (value!.isEmpty) {
                  //   setState(() {
                  //     _emailError = true;
                  //   });
                  //   return '';
                  // } else
                  if (!value!.isValidEmail()) {
                    setState(() {
                      _emailError = true;
                    });
                    // return 'Invalid Email';
                    return '';
                  } else {
                    setState(() {
                      _emailError = false;
                    });
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      );
    }

    Widget _buildMobile() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _mobileError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _mobileControllerFocus.requestFocus();
              },
              child: Container(
                height: 58,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                padding: const EdgeInsets.only(left: 21, right: 0),
                child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Mobile",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]))),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _mobileController,
                focusNode: _mobileControllerFocus,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
                  errorStyle: const TextStyle(color: Colors.white, height: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(color: Colors.white54),
                ),
                cursorColor: AppColor.whiteColor,
                enableSuggestions: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _mobileError = true;
                    });
                    return '';
                  } else if (!value.isValidMobile()) {
                    setState(() {
                      _mobileError = true;
                    });
                    // return 'Must have exactly 10 digits';
                    return '';
                  } else {
                    setState(() {
                      _mobileError = false;
                    });
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      );
    }

    Widget _buildPassword() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _passwordError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(7),
        ),
        height: 58,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _passwordControllerFocus.requestFocus();
              },
              child: Container(
                height: 58,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                padding: const EdgeInsets.only(left: 21, right: 0),
                child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Password",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]))),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _passwordController,
                focusNode: _passwordControllerFocus,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
                  errorStyle: const TextStyle(color: Colors.white, height: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(color: Colors.white54),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 2, right: 10),
                      child: Text(
                        "Show",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.apply(color: AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ),
                obscureText: !_showPassword,
                cursorColor: AppColor.whiteColor,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _passwordError = true;
                    });
                    return '';
                  } else {
                    setState(() {
                      _passwordError = false;
                    });
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      );
    }

    Widget buildSignUpButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          print("clicked");
          print(_nameController.text);
          print(_emailController.text);
          print(_mobileController.text);
          print(_passwordController.text);
          var validate = _signupFormKey.currentState!.validate();
          if (validate) {
            Utils.hideKeyboard(context);
            setState(() {
              _loader = true;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyMobileNumber(
                  username: _nameController.text,
                  email: _emailController.text,
                  phone: _mobileController.text,
                  password: _passwordController.text,
                ),
              ),
            );
          }
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            "Sign up",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .button
                ?.apply(color: AppColor.whiteColor),
          ),
        ),
      );
    }

    Widget _buildAlreadAccount() {
      return InkWell(
        onTap: () {
          print("signin");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor.withOpacity(0.7)),
              ),
              Text(
                "Sign In",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: AppColor.whiteColor),
              ),
            ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsOfUse()),
                    );
                  },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy.',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Privacy Policy"');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                    );
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
          leadingWidth: 150,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left:20,right:3),
                  child: Icon(Icons.arrow_back,color:Colors.white),


                ),

                Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:Colors.white
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(right: 36),
                      child: Text(
                        "Create an account so you can order your favorite food even faster",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.apply(color: AppColor.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildName(),
                    const SizedBox(height: 20),
                    _buildEmail(),
                    const SizedBox(height: 20),
                    _buildMobile(),
                    const SizedBox(height: 20),
                    _buildPassword(),
                    const SizedBox(height: 50),
                    buildSignUpButton(),
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
                    const SizedBox(height: 30),
                    _buildAlreadAccount(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<String> phoneVerification(String phoneNumber, BuildContext context) {
    final completer = Completer<String>();

    phoneNumber = '+91$phoneNumber';
    print(phoneNumber);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyMobileNumber(
          username: _mobileController.text,
          email: _emailController.text,
          phone: _mobileController.text,
          password: _passwordController.text,
        ),
      ),
    );

    // auth.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   timeout: const Duration(seconds: 120),
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     await auth.signInWithCredential(credential);
    //     print("verificationCompleted");

    //     if (redirected) {
    //       setState(() {
    //         redirected = !redirected;
    //       });
    //       signupFunction();
    //     }
    //     completer.complete("signedUp");
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     String error = e.code == 'invalid-phone-number'
    //         ? "Invalid number. Enter again."
    //         : "Can Not Login Now. Please try again.";
    //     print(e);
    //     setState(() {
    //       _loader = false;
    //     });
    //     completer.complete(error);
    //   },
    //   codeSent: (String verificationId, int forceResendingToken) {
    //     print("verificationId : $verificationId");

    //     if (redirected) {
    //       setState(() {
    //         redirected = !redirected;
    //       });

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VerifyMobileNumber(
    //       username: _mobileController.text,
    //       email: _emailController.text,
    //       phone: _mobileController.text,
    //       password: _passwordController.text,
    //     ),
    //   ),
    // );
    //     }

    //     completer.complete("verified");
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     completer.complete("timeout");
    //     setState(() {
    //       _loader = false;
    //     });
    //   },
    // );

    return completer.future;
  }

  signupFunction() async {
    var requestBody = {
      "username": _nameController.text,
      "email": _emailController.text,
      "phone": _mobileController.text,
      "password": _passwordController.text
    };

    try {
      var response = await UserBloc().signup(requestBody);
      var res = response["status"];
      print("response : $res");
      setState(() {
        _loader = false;
      });

      if (response['status'] == 'validation') {
        if (response['message']['phone'] != null) {
          Utils.displayToast(response['message']['phone'][0]);
        } else if (response['message']['email'] != null) {
          Utils.displayToast(response['message']['email'][0]);
        } else if (response['message']['username'] != null) {
          Utils.displayToast(response['message']['username'][0]);
        }
      } else if (response['status'] == false) {
        Utils.displayToast(response["message"]);
      } else {
        Utils.displayToast(response["message"]);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ValidateMobileNumberVerified(),
          ),
        );
      }
    } catch (e) {
      // Navigator.of(context).pop();
      Utils.displayToast("Something went wrong!");
      setState(() {
        _loader = false;
      });
      print(e);
    }
  }
}
// keytool -list -v -keystore ~/.android/debug.keystore
