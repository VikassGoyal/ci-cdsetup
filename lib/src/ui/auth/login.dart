import 'package:conet/blocs/userBloc.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/src/ui/auth/forgotPassword.dart';
import 'package:conet/src/ui/auth/signup.dart';
import 'package:conet/utils/textFormWidget.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/services.dart';

import '../../../networking/apiBaseHelper.dart';
import '../utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  final _mobileEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  //Focus
  final FocusNode _mobileEmailControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();
  bool _loader = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    initlocaldb();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMobile() {
      return TextFormFieldWidget(
        hintText: "Email / Mobile",
        padding: 0.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        functionValidate: commonValidation,
        controller: _mobileEmailController,
        focusNode: _mobileEmailControllerFocus,
        parametersValidate: "Please enter Email / Mobile.",
        onSubmitField: () {
          //FocusScope.of(context).requestFocus(_passwordControllerFocus);
        },
      );
    }

    Widget _buildPassword() {
      return TextFormField(
        controller: _passwordController,
        focusNode: _passwordControllerFocus,
        style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.whiteColor),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        decoration: InputDecoration(
          hintText: "Password",
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white54,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.headline5?.apply(color: Colors.white54),
        ),
        obscureText: !_showPassword,
        cursorColor: AppColor.whiteColor,
        enableSuggestions: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter password";
          }
          return null;
        },
      );
    }

    Widget _buildSignInButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
        onPressed: () async {
          print("clicked");
          var validate = _loginFormKey.currentState!.validate();

          if (validate) {
            Utils.hideKeyboard(context);

            setState(() {
              _loader = true;
            });
            var requestBody = {
              "email": _mobileEmailController.text,
              "password": _passwordController.text,
            };

            try {
              var response = await UserBloc().login(requestBody);

              setState(() {
                _loader = false;
              });

              if (response['message'] == 'success') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else {
                Utils.displayToast(response["message"]);
              }
            } catch (e) {
              bool hasInternet = await checkInternetConnection();
              Utils.displayToastBottomError(
                  hasInternet ? "Something went wrong" : "Please check your internet connection");
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
            "Sign in",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
          ),
        ),
      );
    }

    Widget _buildDontAccount() {
      return InkWell(
        onTap: () {
          print("signin");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ValidateMobileNumberVerified(),
          //   ),
          // );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?  ",
                style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.whiteColor.withOpacity(0.7)),
              ),
              Text(
                "Sign Up",
                style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.whiteColor),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: LoadingOverlay(
        isLoading: _loader,
        opacity: 0.2,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Container(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/logo.svg",
                      height: 50,
                    ),
                    const SizedBox(height: 50),
                    _buildMobile(),
                    const SizedBox(height: 20),
                    _buildPassword(),
                    const SizedBox(height: 9),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          "Forgot password?",
                          style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.whiteColor),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSignInButton(),
                    const SizedBox(height: 20),
                    _buildDontAccount()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  initlocaldb() async {
    await DatabaseHelper.instance.initialize();
  }
}

// LoadingOverlay(
//   child: ,
//   isLoading: _loader,
//   opacity: 0.5,
//   progressIndicator: CircularProgressIndicator(
//     valueColor: new AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
//   ),
// )
