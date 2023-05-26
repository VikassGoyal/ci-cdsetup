import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final double? padding;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;

  const TextFormFieldWidget(
      {required this.hintText,
      this.focusNode,
      this.padding,
      this.textInputType,
      this.defaultText,
      this.obscureText = false,
      this.controller,
      this.functionValidate,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.onSubmitField,
      this.onFieldTap,
      this.prefixIcon});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.padding!, right: widget.padding!),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.apply(color: AppColor.whiteColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 0.15),
          errorStyle: const TextStyle(color: Colors.red,fontSize: 15.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.20)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
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
        keyboardType: widget.textInputType,
        textInputAction: widget.actionKeyboard,
        controller: widget.controller,
        validator: (value) {
          String? resultValidate =
              widget.functionValidate!(value, widget.parametersValidate);
          return resultValidate;
        },
      ),
    );
  }
}

String? commonValidation(String? value, String? messageError) {
  var required = requiredValidator(value, messageError);
  return required;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

// void changeFocus(BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
//   print("awsesds");
//   currentFocus?.unfocus();
//   FocusScope.of(context).requestFocus(nextFocus);
// }
