import 'dart:async';

import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/auth/phoneScreenArguments.dart';
import 'package:conet/src/ui/auth/signup.dart';
import 'package:conet/src/ui/auth/validateMobileNumberVerified.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../bottomNavigation/bottomNavigationBloc.dart';

class VerifyMobileNumber extends StatefulWidget {
  final String? username;
  final String? email;
  final String? phone;
  final String? password;

  const VerifyMobileNumber({super.key, this.username, this.email, this.phone, this.password});

  @override
  State<VerifyMobileNumber> createState() => _VerifyMobileNumberState();
}

// decoration: InputDecoration(
//   focusedErrorBorder: OutlineInputBorder(
//   borderSide: BorderSide(
//     color: Colors.transparent,
//   ),
// ),
//   counterText: '',
// ),
// textInputAction: TextInputAction.next,
// style: Theme.of(context)
//     .textTheme
//     .headline1
//     ?.apply(color: AppColor.whiteColor),

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final _otpVerifyFormKey = GlobalKey<FormState>();
  int start = 120;

  String? _verificationCode;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: Colors.white,
    //borderRadius: BorderRadius.circular(4.0),
    border: Border(
      bottom: BorderSide(width: 3.0, color: Colors.white),
    ),
  );
  final BoxDecoration selectdpinPutDecoration = BoxDecoration(
    // color: Colors.white,
    //borderRadius: BorderRadius.circular(4.0),
    border: Border(
      bottom: BorderSide(width: 3.0, color: Colors.white),
    ),
  );

  //Controller
  final _code1Controller = TextEditingController();
  final _code2Controller = TextEditingController();
  final _code3Controller = TextEditingController();
  final _code4Controller = TextEditingController();
  bool _loader = false;

  //Firebase
  final SMSCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String? otpNumber = "1";
  bool wait = false;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as PhoneScreenArguments;

    Widget _buildVerifyMobileNumberButton() {
      return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
          ),
          onPressed: () async {
            if (_loader) return;

            //print(otpNumber!.length);
            if (otpNumber!.length != 6) {
              Utils.displayToastBottomError("Please Enter Valid  OTP", context);
              return;
            }
            setState(() {
              _loader = true;
            });

            try {
              print("calling");
              await FirebaseAuth.instance
                  .signInWithCredential(
                      PhoneAuthProvider.credential(verificationId: _verificationCode!, smsCode: otpNumber!))
                  .then((value) async {
                print(value.user!);
                if (value.user != null) {
                  print("value");
                  signupFunction();
                  print("verifynow : Sign up successfully...!");
                }
              });
            } catch (e) {
              print(e);
              Utils.displayToastBottomError("Invalid OTP", context);
              setState(() {
                _loader = false;
              });
            }

            // try {
            //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
            //       verificationId: widget.verificationId,
            //       smsCode: SMSCodeController.text);

            //   print("credential : $credential");

            //   await auth.signInWithCredential(credential);
            //   auth.signInWithCredential(credential).then((result) {
            //     print("signInWithCredential success : $result");
            //   }).catchError((e) {
            //     print("signInWithCredential error : $e");
            //     print(e);
            //   });
            // } catch (e) {
            //   print("PhoneAuthCredential error : $e");
            //   print(e);
            // }
            // var validate = _otpVerifyFormKey.currentState.validate();
            // if (validate) {
            //   Utils.hideKeyboard(context);
            //   setState(() {
            //     _loader = true;
            //   });
            //   var requestBody = {
            //     "password": _code1Controller.text +
            //         _code2Controller.text +
            //         _code3Controller.text +
            //         _code4Controller.text,
            //     "email": widget.inputvalue
            //   };

            //   try {
            //     var response = await UserBloc().otpVerification(requestBody);
            //     setState(() {
            //       _loader = false;
            //     });

            //     print("response - $response");
            //     if (response['message'] == 'success') {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => HomeScreen()),
            //       );
            //     } else {
            //       Utils.displayToast(response["message"]);
            //     }
            //   } catch (e) {
            //     Utils.displayToast(
            //         "Oops, something went wrong.Please try again later.");
            //     print(e);
            //   }
            // }
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 50.h),
            alignment: Alignment.center,
            child: _loader
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
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

    Widget _code1() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: TextFormField(
          controller: _code1Controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            counterText: '',
            errorStyle: TextStyle(color: Colors.white),
          ),
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
          onChanged: (text) {
            print("onchange : $text");
            if (text != "") {
              FocusScope.of(context).nextFocus();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
        ),
      );
    }

    Widget _code2() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: TextFormField(
          controller: _code2Controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            counterText: '',
          ),
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
          onChanged: (text) {
            print("onchange : $text");
            if (text != "") {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
        ),
      );
    }

    Widget _code3() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: TextFormField(
          controller: _code3Controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            counterText: '',
          ),
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
          onChanged: (text) {
            print("onchange : $text");
            if (text != "") {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
        ),
      );
    }

    Widget _code4() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: TextFormField(
          controller: _code4Controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            counterText: '',
          ),
          textInputAction: TextInputAction.done,
          style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
          onChanged: (text) {
            print("onchange : $text");
            if (text != "") {
              FocusScope.of(context).requestFocus(FocusNode());
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
        ),
      );
    }

    Widget _boxBuilder() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _code1(),
          _code2(),
          _code3(),
          _code4(),
        ],
      );
    }

    String formatTime(int seconds) {
      print(seconds);
      String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');
      return '$minutesStr:$secondsStr';
    }

    Widget _buildResend() {
      return InkWell(
        onTap: () {
          if (wait) {
            _verifyPhone();

            start = 120;
            startTimer();
          } else {}
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: wait ? AppColor.secondaryColor : AppColor.secondaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Re-Send Code ',
                style: TextStyle(
                  fontFamily: kSfproDisplayFontFamily,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                formatTime(start),
                style: TextStyle(
                  fontFamily: kSfproDisplayFontFamily,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 55.h,
      textStyle: TextStyle(
        fontFamily: kSfproRoundedFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 35.sp,
        fontStyle: FontStyle.normal,
        color: AppColor.whiteColor,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 4.h, color: Colors.white),
        ),
      ),
    );

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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    "Verify OTP Received",
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      color: AppColor.whiteColor,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    "in your SMS",
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      color: AppColor.whiteColor,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "We have sent code to ${widget.phone ?? ''}",
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
                    "Enter the code below.",
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      color: AppColor.whiteColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 58.h),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 36.w, right: 34.w),
                  child: Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      pinAnimationType: PinAnimationType.fade,
                      defaultPinTheme: defaultPinTheme,
                      submittedPinTheme: defaultPinTheme.copyWith(decoration: pinPutDecoration),
                      focusedPinTheme: defaultPinTheme.copyWith(decoration: selectdpinPutDecoration),
                      onChanged: (pin) {
                        debugPrint('onCompleted: $pin');
                        setState(() {
                          otpNumber = pin;
                        });
                      },
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                        setState(() {
                          otpNumber = pin;
                        });
                        Utils.hideKeyboard(context);
                        print(otpNumber!.length);

                        try {
                          _buildVerifyMobileNumberButton();
                          print("pin : $pin");
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          // _scaffoldkey.currentState.showSnackBar(
                          //     SnackBar(content: Text('invalid OTP')));
                        }
                      },
                      // fieldsCount: 6,
                      // submittedFieldDecoration: pinPutDecoration,
                      // selectedFieldDecoration: selectdpinPutDecoration,
                      // followingFieldDecoration: pinPutDecoration,
                      // eachFieldWidth: 40.0,
                      // eachFieldHeight: 55.0,
                      // onSubmit: (pin) async {
                      //   setState(() {
                      //     otpNumber = pin;
                      //   });
                      //   Utils.hideKeyboard(context);
                      //   print(otpNumber.length);

                      //   try {
                      //     print("pin : $pin");
                      //   } catch (e) {
                      //     FocusScope.of(context).unfocus();
                      //     // _scaffoldkey.currentState.showSnackBar(
                      //     //     SnackBar(content: Text('invalid OTP')));
                      //   }
                      // },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: 20.w,
                ),
                _buildVerifyMobileNumberButton(),
                SizedBox(
                  height: 44.5.h,
                  width: 20.w,
                ),
                _buildResend(),
              ],
            )
          ],
        ));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verificationCompleted");
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              signupFunction();
              print("verificationCompleted : Sign up successfully...!");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("verificationFailed");
          Utils.displayToastBottomError("Something went wrong", context);
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          print("codeSent");
          if (mounted) {
            setState(() {
              _verificationCode = verficationID;
            });
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          print("codeAutoRetrievalTimeout");
          if (mounted) {
            setState(() {
              _verificationCode = verificationID;
            });
          }
        },
        timeout: const Duration(seconds: 120));
  }

  signupFunction() async {
    String username = widget.username!;
    String email = widget.email!;
    String phone = widget.phone!;
    String password = widget.password!;

    try {
      var response = await UserBloc().signup(username: username, email: email, phone: phone, password: password);
      var res = response["status"];
      print("response : $res");
      setState(() {
        _loader = false;
      });

      if (response['status'] == 'validation') {
        if (response['message']['phone'] != null) {
          Utils.displayToastBottomError(response['message']['phone'][0], context);
        } else if (response['message']['email'] != null) {
          Utils.displayToastBottomError(response['message']['email'][0], context);
        } else if (response['message']['username'] != null) {
          Utils.displayToastBottomError(response['message']['username'][0], context);
        }
      } else if (response['status'] == false) {
        Utils.displayToastBottomError(response["message"], context);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: response["message"],
          // autoCloseDuration: const Duration(seconds: 3),
        );
        //Utils.displayToast(response["message"], context);
        context.read<BottomNavigationBloc>().currentIndex = 0;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ValidateMobileNumberVerified(),
          ),
        );
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?['email'][0] ??
          e.response?.data?['message']?['phone'][0] ??
          'Something went wrong.';
      Utils.displayToastBottomError(msg, context);
      setState(() {
        _loader = false;
      });
      print(e);
    } catch (e) {
      Utils.displayToast("Something went wrong.", context);
      setState(() {
        _loader = false;
      });
      print(e);
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            wait = true;
            timer.cancel();
          });
        }
      } else {
        if (mounted) {
          setState(() {
            wait = false;
            start--;
          });
        }
      }
    });
  }
}
