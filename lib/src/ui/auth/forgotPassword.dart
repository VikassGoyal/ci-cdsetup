import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../utils.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _signupFormKey = GlobalKey<FormState>();
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
          border: Border.all(
              color: _emailError ? AppColor.whiteColor : Colors.transparent),
          borderRadius: BorderRadius.circular(7),
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
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                padding: const EdgeInsets.only(left: 21, right: 50),
                child: Center(
                  child: Text(
                    "Email",
                    style: Theme.of(context).textTheme.headline5?.apply(
                        color: const Color.fromRGBO(255, 255, 255, 0.75)),
                  ),
                ),
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
                  if (value!.isEmpty) {
                    setState(() {
                      _emailError = true;
                    });
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
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          print("clicked");
          var validate = _signupFormKey.currentState!.validate();
          if (validate) {
            Utils.hideKeyboard(context);
            setState(() {
              _loader = true;
            });
            var requestBody = {
              "email": _emailController.text,
            };

            try {
              // var response = await UserBloc().signup(requestBody);
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
          constraints: const BoxConstraints(
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            "Reset Password",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .button
                ?.apply(color: AppColor.whiteColor),
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
                      "Forgot",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    Text(
                      "Password?",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(right: 60),
                      child: Text(
                        "Enter your email address below and we'll send you an email with instruction how to change your password",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.apply(color: AppColor.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildEmail(),
                    const SizedBox(height: 20),
                    _buildResetPassword(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
