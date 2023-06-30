// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../networking/apiBaseHelper.dart';
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
  String _errorMsg = '';

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
    Widget buildSignUpButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
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
            bool hasInternet = await checkInternetConnection();
            if (hasInternet) {
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
            } else {
              setState(() {
                _loader = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                Utils.displaySnackBar(
                  'Please check your internet connection',
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColor.redColor,
                ),
              );
            }
          } else {
            //if there is any error in validations then show some common Error msg
            ScaffoldMessenger.of(context).showSnackBar(
              Utils.displaySnackBar(
                _errorMsg,
                duration: const Duration(seconds: 2),
                backgroundColor: AppColor.redColor,
              ),
            );
          }
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 50.h),
          alignment: Alignment.center,
          child: Text(
            "Sign up",
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
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style: TextStyle(
                  fontFamily: kSfproDisplayFontFamily,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "Sign In",
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
          leadingWidth: 150.w,
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
                key: _signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: kSfproRoundedFontFamily,
                        color: AppColor.whiteColor,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Text(
                        "Sign up for an account so you can do business like you never have before",
                        style: TextStyle(
                          fontFamily: kSfproRoundedFontFamily,
                          color: AppColor.whiteColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 39.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormFieldBox(
                            formFieldType: FormFieldType.name,
                            focusNode: _nameControllerFocus,
                            label: 'Name',
                            textEditingController: _nameController,
                            isError: _nameError,
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  _nameError = true;
                                  _errorMsg = 'Name cannot be empty';
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
                          SizedBox(height: 9.h),
                          CustomTextFormFieldBox(
                            formFieldType: FormFieldType.email,
                            focusNode: _emailControllerFocus,
                            label: 'Email',
                            textEditingController: _emailController,
                            isError: _emailError,
                            validator: (value) {
                              if (!value!.isValidEmail()) {
                                setState(() {
                                  _emailError = true;
                                  _errorMsg = "Please enter a valid email ";
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
                          SizedBox(height: 9.h),
                          CustomTextFormFieldBox(
                            formFieldType: FormFieldType.mobile,
                            focusNode: _mobileControllerFocus,
                            label: 'Mobile',
                            textEditingController: _mobileController,
                            isError: _mobileError,
                            validator: (value) {
                              if (!value!.isValidMobile()) {
                                setState(() {
                                  _mobileError = true;
                                  _errorMsg = "Please enter a valid mobile number ";
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
                          SizedBox(height: 9.h),
                          CustomTextFormFieldBox(
                            formFieldType: FormFieldType.password,
                            focusNode: _passwordControllerFocus,
                            label: 'Password',
                            textEditingController: _passwordController,
                            isError: _passwordError,
                            validator: (value) {
                              if (!value!.isValidPassword()) {
                                setState(() {
                                  _passwordError = true;
                                  _errorMsg = "Please enter a valid password";
                                });
                                // return 'Must have exactly 10 digits';
                                return '';
                              } else {
                                setState(() {
                                  _passwordError = false;
                                });
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 13.h),
                          Text(
                            "Your password must be 8 to 16 characters long & contains mix of upper & lower case letters, numbers & symbols.",
                            style: TextStyle(
                              fontFamily: kSfproRoundedFontFamily,
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 49.h),
                          buildSignUpButton(),
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
                          SizedBox(height: 33.h),
                          _buildAlreadAccount(),
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

enum FormFieldType { name, email, mobile, password }

class CustomTextFormFieldBox extends StatefulWidget {
  final FormFieldType formFieldType;
  final bool isError;
  final FocusNode focusNode;
  final String label;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  const CustomTextFormFieldBox({
    super.key,
    required this.formFieldType,
    required this.focusNode,
    required this.label,
    required this.textEditingController,
    required this.isError,
    required this.validator,
  });

  @override
  State<CustomTextFormFieldBox> createState() => _CustomTextFormFieldBoxState();
}

class _CustomTextFormFieldBoxState extends State<CustomTextFormFieldBox> {
  late bool _showPassword;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: widget.isError ? AppColor.whiteColor : Colors.transparent),
        borderRadius: BorderRadius.circular(5),
        color: AppColor.whiteColor.withOpacity(0.25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              widget.focusNode.requestFocus();
            },
            child: Container(
              height: 58,
              padding: EdgeInsets.only(
                left: 15.w,
                right: widget.formFieldType == FormFieldType.email
                    ? 35.w
                    : widget.formFieldType == FormFieldType.mobile
                        ? 27.w
                        : widget.formFieldType == FormFieldType.password
                            ? 9.w
                            : 33.w,
              ),
              child: Center(
                child: RichText(
                    text: TextSpan(
                        text: widget.label,
                        style: TextStyle(
                          color: AppColor.whiteColor.withOpacity(0.75),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: kSfproRoundedFontFamily,
                        ),
                        children: const [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ])),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.textEditingController,
              focusNode: widget.focusNode,
              style: TextStyle(
                fontFamily: kSfproRoundedFontFamily,
                color: AppColor.whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              ),
              decoration: InputDecoration(
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
                hintStyle: TextStyle(
                  fontFamily: kSfproRoundedFontFamily,
                  color: Colors.white54,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                suffixIcon: widget.formFieldType == FormFieldType.password
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 2, right: 10),
                          child: Text(
                            "Show",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: kSfproRoundedFontFamily,
                              color: AppColor.secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
              cursorColor: AppColor.whiteColor,
              enableSuggestions: false,
              obscureText: widget.formFieldType == FormFieldType.password ? !_showPassword : false,
              keyboardType: widget.formFieldType == FormFieldType.email
                  ? TextInputType.emailAddress
                  : widget.formFieldType == FormFieldType.mobile
                      ? TextInputType.number
                      : widget.formFieldType == FormFieldType.password
                          ? TextInputType.visiblePassword
                          : TextInputType.text,
              inputFormatters: widget.formFieldType == FormFieldType.mobile
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                  : null,
              textInputAction:
                  widget.formFieldType == FormFieldType.password ? TextInputAction.done : TextInputAction.next,
              validator: widget.validator,
            ),
          )
        ],
      ),
    );
  }
}
