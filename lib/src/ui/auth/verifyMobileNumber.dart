import 'dart:async';

import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/auth/phoneScreenArguments.dart';
import 'package:conet/src/ui/auth/signup.dart';
import 'package:conet/src/ui/auth/validateMobileNumberVerified.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyMobileNumber extends StatefulWidget {
  final String? username;
  final String? email;
  final String? phone;
  final String? password;

  const VerifyMobileNumber({this.username, this.email, this.phone, this.password});

  @override
  _VerifyMobileNumberState createState() => _VerifyMobileNumberState();
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
  int start = 60;

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
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          //print(otpNumber!.length);
          if (otpNumber!.length != 6) {
            Utils.displayToastBottomError("Please Enter Valid  OTP");
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
            Utils.displayToast("Invalid OTP");
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
          constraints: const BoxConstraints(
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            "Verify Now",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
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

    Widget _buildResend() {
      return InkWell(
        onTap: () {
          if (wait) {
            _verifyPhone();

            start = 60;
            startTimer();
          } else {}
        },
        child: Center(
          child: Text(
            "Re-Send code 00:$start",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Colors.white),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          centerTitle: false,
          leadingWidth: 150,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 3),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Back',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 83,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify OTP Received",
                      style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
                    ),
                    Text(
                      "in Your Email",
                      style: Theme.of(context).textTheme.headline1?.apply(color: AppColor.whiteColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "We have sent code to " + widget.email!,
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
              ),
              Text(
                "Enter the code below.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 60),
              Directionality(
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
              SizedBox(
                height: 40,
                width: 20,
              ),
              _buildVerifyMobileNumberButton(),
              SizedBox(
                height: 60,
                width: 20,
              ),
              _buildResend(),
            ],
          ),
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
          Utils.displayToast("Something went wrong");
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          print("codeSent");
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          print("codeAutoRetrievalTimeout");
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  signupFunction() async {
    var requestBody = {
      "username": widget.username,
      "email": widget.email,
      "phone": widget.phone,
      "password": widget.password
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

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          wait = true;
          timer.cancel();
        });
      } else {
        setState(() {
          wait = false;
          start--;
        });
      }
    });
  }
}
