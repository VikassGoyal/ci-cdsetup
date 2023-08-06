import 'package:conet/api_models/changepassword_request_model/changepassword_request_body.dart';
import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gtm/gtm.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _changeFormKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loader = false;
  final gtm = Gtm.instance;
  @override
  Widget build(BuildContext context) {
    Widget buildUpdateButton() {
      return Container(
        constraints: BoxConstraints(minWidth: 331.0.w, minHeight: 48.h),
        child: ElevatedButton(
          child: Text(
            "Update",
            style: TextStyle(fontSize: 18.sp, fontFamily: kSfproRoundedFontFamily, fontWeight: FontWeight.w500),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              )),
          onPressed: () {
            var validate = _changeFormKey.currentState!.validate();
            if (_oldPasswordController.text.length < 8) {
              Utils.displayToastTopError("Old Password Must be more than 8 characters");
              return;
            }
            if (_confirmPasswordController.text.length < 8) {
              Utils.displayToastTopError("New Password Must be more than 8 characters");
              return;
            }

            if (_newPasswordController.text.length < 8) {
              Utils.displayToastTopError("Confirm Password Must be more than 8 characters");
              return;
            }
            if (validate) {
              Utils.hideKeyboard(context);
            }
            changePassword();
            print("clicked");
          },
        ),
      );
    }

    Widget buildOldPassword() {
      return TextFormFieldContact(
        hintText: "Old Password",
        obscureText: true,
        padding: 14.0,
        controller: _oldPasswordController,
        maxLength: 16,
        textInputType: TextInputType.visiblePassword,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {
          return null;
        },
        parametersValidate: "Please enter Old Password.",
        functionValidate: commonValidation(_oldPasswordController.text, ""),
      );
    }

    Widget buildNewPassword() {
      return TextFormFieldContact(
        hintText: "New Password",
        obscureText: true,
        padding: 14.0,
        controller: _newPasswordController,
        textInputType: TextInputType.visiblePassword,
        maxLength: 16,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {
          return null;
        },
        parametersValidate: "Please enter New Password.",
      );
    }

    Widget buildConfirmPassword() {
      return TextFormFieldContact(
        hintText: "Confirm New Password",
        obscureText: true,
        padding: 12.0.w,
        controller: _confirmPasswordController,
        textInputType: TextInputType.visiblePassword,
        maxLength: 16,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {
          return null;
        },
        parametersValidate: "Please enter Confirm Password.",
      );
    }

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
          leadingWidth: 80.w,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
          centerTitle: true,
          title: Text("Change Password",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: kSfproRoundedFontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
        ),
        body: LoadingOverlay(
            isLoading: _loader,
            opacity: 0.5,
            progressIndicator: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
            ),
            child: Form(
              key: _changeFormKey,
              child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    buildOldPassword(),
                    SizedBox(height: 16.h),
                    buildNewPassword(),
                    SizedBox(height: 16.h),
                    buildConfirmPassword(),
                    SizedBox(height: 16.h),
                    Expanded(child: Container()),
                    buildUpdateButton(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            )));
  }

  Future<void> changePassword() async {
    if (_oldPasswordController.text.isEmpty) {
      Utils.displayToastTopError("Please enter Old Password.");
      return;
    } else if (_newPasswordController.text.isEmpty) {
      Utils.displayToastTopError("Please enter New Password.");
      return;
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      Utils.displayToastTopError("Password is Mismatch.");
      return;
    } else if (_oldPasswordController.text == _confirmPasswordController.text) {
      Utils.displayToastTopError("Enter different Password");
      return;
    }

    setState(() {
      _loader = true;
    });
    // var requestBody = {
    //   "oldpassword": _oldPasswordController.text,
    //   "newpassword": _newPasswordController.text,
    // };

    try {
      var response = await UserBloc().changePassword(ChangePasswordRequestBody(
          oldpassword: _oldPasswordController.text, newpassword: _newPasswordController.text));

      setState(() {
        _loader = false;
      });

      if (response['success'] == true) {
        gtm.push("password_change", parameters: {"status": "done"});
        Utils.displayToast(response["message"]);
        Navigator.pop(context);
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      Utils.displayToast("Something went wrong!");
      print(e);
    }
  }
}
