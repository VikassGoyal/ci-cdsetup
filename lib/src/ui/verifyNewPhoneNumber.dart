import 'dart:async';

import 'package:conet/blocs/contacts_operations/contacts_operations_bloc.dart';
import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/auth/phoneScreenArguments.dart';
import 'package:conet/src/ui/auth/signup.dart';
import 'package:conet/src/ui/auth/validateMobileNumberVerified.dart';
import 'package:conet/src/ui/changePhoneNumber.dart';
import 'package:conet/src/ui/settings/myprofile.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bottomNavigation/bottomNavigationBloc.dart';
import '../../api_models/updateProfileDetails_request_model/updateProfileDetails_request_body.dart';

import '../../models/contactDetails.dart';
import '../../models/entrepreneureData.dart';
import '../../services/storage_service.dart';
import '../../utils/constant.dart';
import '../../utils/get_it.dart';

class VerifyNewPhoneNumber extends StatefulWidget {
  ContactDetail? contactdetaill;
  final String? PhoneNumber;
  List<EntrepreneurData> entreprenerurList;

  VerifyNewPhoneNumber(this.contactdetaill, this.PhoneNumber, this.entreprenerurList, {super.key});

  @override
  State<VerifyNewPhoneNumber> createState() => _VerifyNewPhoneNumberState();
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

class _VerifyNewPhoneNumberState extends State<VerifyNewPhoneNumber> {
  final _otpVerifyFormKey = GlobalKey<FormState>();
  int start = 120;
  final prefs = locator<StorageService>();
  ContactDetail? contactDetail;

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
  late final ContactsOperationsBloc contactsOperationsBloc;

  @override
  void initState() {
    super.initState();
    contactsOperationsBloc = BlocProvider.of<ContactsOperationsBloc>(context);
    _verifyPhone();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _pinPutFocusNode.dispose();
    _pinPutController.dispose();
    _code1Controller.dispose();
    _code2Controller.dispose();
    _code3Controller.dispose();
    _code4Controller.dispose();
    SMSCodeController.dispose();
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
            onTap: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              String phonenum = preferences.getString("phone") ?? "";
              Navigator.of(context).pop();
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
                    "We have sent code to ${widget.PhoneNumber ?? ''}",
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
        phoneNumber: '+91${widget.PhoneNumber}',
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
    String phone = widget.PhoneNumber!;

    try {
      print(widget.contactdetaill!.name ?? "");
      print(widget.contactdetaill!.personal!.email ?? "");
      print(widget.contactdetaill!.personal!.dOB ?? "");
      print(widget.contactdetaill!.personal!.address1 ?? "");
      print(widget.contactdetaill!.personal!.address2 ?? "");
      print(widget.contactdetaill!.personal!.address3 ?? "");
      print(widget.contactdetaill!.personal!.state ?? "");
      print(widget.contactdetaill!.personal!.country ?? "");
      print(widget.contactdetaill!.personal!.pincode ?? "");
      print(widget.contactdetaill!.personal!.landline ?? "");
      print(widget.contactdetaill!.personal!.keyword ?? "");
      print(widget.contactdetaill!.professional!.occupation ?? "");
      print(widget.contactdetaill!.professional!.company ?? "");
      print(widget.contactdetaill!.professional!.companyWebsite ?? "");
      print(widget.contactdetaill!.professional!.workNature ?? "");
      print(widget.contactdetaill!.professional!.designation ?? "");
      print(widget.contactdetaill!.professional!.grade ?? "");
      print(widget.contactdetaill!.professionalList!.map((v) => v.toJson()).toList().runtimeType ?? []);

      var response = await contactsOperationsBloc.updateProfileDetails(UpdateProfileDetailsRequestBody(
          fb: widget.contactdetaill!.social!.facebook ?? "",
          entreprenerur_list: (widget.entreprenerurList.map((e) => e.toJson()).toList()),
          per_add: widget.contactdetaill!.personal!.address1 ?? "",
          per_name: widget.contactdetaill!.name ?? "",
          tt: widget.contactdetaill!.social!.twitter ?? "",
          pro_com_website: widget.contactdetaill!.professional!.companyWebsite ?? "",
          per_state: widget.contactdetaill!.personal!.state ?? "",
          per_city: widget.contactdetaill!.personal!.address2 ?? "",
          inn: widget.contactdetaill!.social!.instagram ?? "",
          per_country: widget.contactdetaill!.personal!.country ?? "",
          per_dob: widget.contactdetaill!.personal!.dOB ?? "",
          per_email: widget.contactdetaill!.personal!.email ?? "",
          per_keyword: widget.contactdetaill!.personal!.keyword ?? "",
          per_lan: widget.contactdetaill!.personal!.landline != null
              ? widget.contactdetaill!.personal!.landline.toString()
              : "",
          per_num:
              widget.PhoneNumber != null ? widget.PhoneNumber ?? "" : widget.contactdetaill!.personal!.number ?? "",
          per_pincode: widget.contactdetaill!.personal!.pincode ?? "",
          pro_com: widget.contactdetaill!.professional!.company ?? "",
          per_secondary_num: widget.contactdetaill!.personal!.secondaryPhone ?? "",
          pro_des: widget.contactdetaill!.professional!.designation ?? "",
          pro_gra: widget.contactdetaill!.professional!.grade ?? "",
          pro_ind: widget.contactdetaill!.professional!.industry ?? "",
          pro_occ: widget.contactdetaill!.professional!.occupation ?? "",
          pro_sch: widget.contactdetaill!.professional!.schoolUniversity ?? "",
          pro_wn: widget.contactdetaill!.professional!.workNature ?? "",
          sk: widget.contactdetaill!.social!.skype ?? ""));
      print(response["status"]);
      setState(() {
        // _loaderoverflow = false;
      });

      if (response['status'] == true) {
        prefs.setPrefs<String>('phone', widget.PhoneNumber.toString());
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: response['message'].toString(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MyProfile(widget.PhoneNumber),
          ),
        );
      } else if (response['status'] == "Token is Expired") {
        tokenExpired(context);
      } else {
        Utils.displayToastBottomError('Something went wrong', context);
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
      print("errror");
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
