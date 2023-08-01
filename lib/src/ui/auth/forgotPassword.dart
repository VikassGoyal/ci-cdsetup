import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../api_models/forgotpassword__request_model/forgotpassword_request_body.dart';
import '../../../blocs/userBloc.dart';
import '../utils.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  bool _loader = false;
  bool _emailError = false;

  //Controller
  final _emailController = TextEditingController();
  //Focus
  final FocusNode _emailControllerFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget _buildEmail() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: _emailError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(5),
          color: AppColor.whiteColor.withOpacity(0.25),
        ),
        height: 58,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _emailControllerFocus.requestFocus();
              },
              child: Container(
                height: 58,
                // decoration: BoxDecoration(
                //   color: Color.fromRGBO(255, 255, 255, 0.15),
                // ),
                padding: EdgeInsets.only(left: 15.w, right: 35.w),
                child: Center(
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: AppColor.whiteColor.withOpacity(0.75),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: kSfCompactDisplayFontFamily,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                focusNode: _emailControllerFocus,
                controller: _emailController,
                style: TextStyle(
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: AppColor.whiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
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
                ),
                cursorColor: AppColor.whiteColor,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (!value!.isValidEmail()) {
                    setState(() {
                      _emailError = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      Utils.displaySnackBar(
                        'Enter a Valid Email',
                        duration: const Duration(seconds: 1),
                        backgroundColor: AppColor.redColor,
                      ),
                    );
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

    Widget _buildResetPassword() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          print("clicked");
          var validate = _forgotPasswordFormKey.currentState!.validate();
          if (validate) {
            Utils.hideKeyboard(context);
            setState(() {
              _loader = true;
            });
            // var requestBody = {
            //   "email": _emailController.text,
            // };

            try {
              var response = await UserBloc().forgotPassword(ForgotpasswordRequestBody(email: _emailController.text));
              if (response['status'] == true) {
                Utils.displayToastBottomError(response["message"], context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              } else {
                Utils.displayToastBottomError(response["message"], context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              }
              // var res = response["status"];
              // print("response : $res");
              // setState(() {
              //   _loader = false;
              // });

              // if (response['status'] == 'validation') {
              //   if (response['message']['phone'] != null) {
              //     Utils.displayToast(response['message']['phone'][0]);
              //   } else if (response['message']['email'] != null) {
              //     Utils.displayToast(response['message']['email'][0]);
              //   } else if (response['message']['username'] != null) {
              //     Utils.displayToast(response['message']['username'][0]);
              //   }
              // } else if (response['status'] == false) {
              //   Utils.displayToast(response["message"]);
              // } else {
              //   Utils.displayToast(response["message"]);

              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Login(),
              //     ),
              //   );
              // }
            } catch (e) {
              Navigator.of(context).pop();
              print(e);
            }
          }
        },
        child: Container(
          constraints: BoxConstraints(
            minHeight: 50.h,
          ),
          alignment: Alignment.center,
          child: Text(
            "Reset Password",
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
                key: _forgotPasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text("Forgot",
                        style: TextStyle(
                            fontFamily: kSfproRoundedFontFamily,
                            color: AppColor.whiteColor,
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal)),
                    Text("Password?",
                        style: TextStyle(
                            fontFamily: kSfproRoundedFontFamily,
                            color: AppColor.whiteColor,
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal)),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Text(
                        "Enter your email address below and we'll send you an email with instruction how to change your password",
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
                    SizedBox(height: 43.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEmail(),
                          SizedBox(height: 23.h),
                          _buildResetPassword(),
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
