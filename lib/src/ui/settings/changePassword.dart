import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/utils/widget.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    Widget buildUpdateButton() {
      return raisedButton(
        context: context,
        text: "Update",
        bgColor: AppColor.primaryColor,
        onClick: () {
          var validate = _changeFormKey.currentState!.validate();
          if (validate) {
            Utils.hideKeyboard(context);
          }
          changePassword();
          print("clicked");
        },
      );
    }

    Widget buildOldPassword() {
      return TextFormFieldContact(
        hintText: "Old Password",
        obscureText: true,
        padding: 14.0,
        controller: _oldPasswordController,
        textInputType: TextInputType.visiblePassword,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        parametersValidate: "Please enter Old Password.",
        // functionValidate: commonValidation(_oldPasswordController.text, ""),
      );
    }

    Widget buildNewPassword() {
      return TextFormFieldContact(
        hintText: "New Password",
        obscureText: true,
        padding: 14.0,
        controller: _newPasswordController,
        textInputType: TextInputType.visiblePassword,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        parametersValidate: "Please enter New Password.",
      );
    }

    Widget buildConfirmPassword() {
      return TextFormFieldContact(
        hintText: "Confirm Password",
        obscureText: true,
        padding: 14.0,
        controller: _confirmPasswordController,
        textInputType: TextInputType.visiblePassword,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        parametersValidate: "Please enter Confirm Password.",
      );
    }

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_sharp,
                  color: AppColor.whiteColor,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "Back",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: AppColor.whiteColor),
                )
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            "Change Password",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .apply(color: AppColor.whiteColor),
          ),
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
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  buildOldPassword(),
                  const SizedBox(height: 16),
                  buildNewPassword(),
                  const SizedBox(height: 16),
                  buildConfirmPassword(),
                  const SizedBox(height: 16),
                  Expanded(child: Container()),
                  buildUpdateButton(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
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
    var requestBody = {
      "oldpassword": _oldPasswordController.text,
      "newpassword": _newPasswordController.text,
    };

    try {
      var response = await UserBloc().changePassword(requestBody);

      setState(() {
        _loader = false;
      });

      if (response['success'] == true) {
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
