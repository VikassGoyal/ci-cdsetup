import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

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
  final RegExp? regexp;

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
      this.prefixIcon,
      this.regexp});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.padding!, right: widget.padding!),
      child: TextFormField(
        style: TextStyle(
          fontFamily: kSfCompactDisplayFontFamily,
          color: AppColor.whiteColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(widget.regexp == null ? RegExp('.*') : widget.regexp!),
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        onTap: () {
          // FocusScope.of(context).requestFocus(widget.focusNode);
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          border: InputBorder.none,
          fillColor: AppColor.whiteColor.withOpacity(0.15),
          //errorStyle: const TextStyle(color: Colors.red,fontSize: 15.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),

          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(
            fontFamily: kSfCompactDisplayFontFamily,
            color: AppColor.whiteColor.withOpacity(0.75),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        cursorColor: AppColor.whiteColor,
        keyboardType: widget.textInputType,
        textInputAction: widget.actionKeyboard,
        controller: widget.controller,
        validator: (value) {
          String? resultValidate = widget.functionValidate!(value, widget.parametersValidate);
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
  } else if (RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(value) ||
      RegExp(r"^[0-9]{10}$").hasMatch(value)) {
    return null;
  }
  return "Please Enter Valid Email/Mobile.";
}

// void changeFocus(BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
//   currentFocus?.unfocus();
//   FocusScope.of(context).requestFocus(nextFocus);
// }
