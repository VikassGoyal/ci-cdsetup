import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldContact extends StatefulWidget {
  final TextInputType? textInputType;

  final String? hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final double? padding;
  final double? margin;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool? readonly;
  final bool? enable;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final String? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final int? maxLength;
  final RegExp? regexexp;
  final Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final Color textColor;
  final bool enableFormatters;

  const TextFormFieldContact({
    super.key,
    required this.hintText,
    this.focusNode,
    this.padding,
    this.onChanged,
    this.margin,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.readonly = false,
    this.enable,
    this.controller,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.prefixIcon,
    this.maxLength = 1000,
    this.textColor = AppColor.secondaryColor,
    this.regexexp,
    this.validator,
    this.enableFormatters = true,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<TextFormFieldContact> createState() => _TextFormFieldContactState();
}

class _TextFormFieldContactState extends State<TextFormFieldContact> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48.h,
          width: 331.w,
          padding: widget.padding != null ? EdgeInsets.only(left: widget.padding!.w, right: widget.padding!.w) : null,
          margin: EdgeInsets.only(left: widget.margin ?? 0, right: widget.margin ?? 0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
            },
            textCapitalization: widget.textCapitalization,
            readOnly: widget.readonly!,
            validator: widget.validator,
            style: TextStyle(
                fontSize: 15.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: widget.textColor),
            maxLength: widget.maxLength,
            inputFormatters: [
              if (widget.enableFormatters) ...[
                FilteringTextInputFormatter.allow(widget.regexexp == null ? RegExp('.*') : widget.regexexp!),
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ]
            ],
            // inputFormatters: widget.regexexp != null
            //     ? [
            //         FilteringTextInputFormatter.allow(widget.regexexp!),
            //       ]
            //     : [FilteringTextInputFormatter.allow(RegExp(r'^[^\s]+$')!)],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 6.0.h, bottom: 3.0.w),
              labelText: widget.hintText,
              counterText: "",
              hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: kSfproRoundedFontFamily,
                  fontWeight: FontWeight.w300,
                  color: AppColor.placeholder),
              labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: kSfproRoundedFontFamily,
                  fontWeight: FontWeight.w300,
                  color: AppColor.placeholder),
              filled: true,
              fillColor: AppColor.whiteColor,
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: InputBorder.none,
            ),
            enabled: widget.enable,
            cursorColor: AppColor.secondaryColor,
            keyboardType: widget.textInputType,
            textInputAction: widget.actionKeyboard,
            controller: widget.controller,
            obscureText: widget.obscureText,
          ),
        ),
        message.isNotEmpty ? Text('$message') : SizedBox()
      ],
    );
  }
}

commonValidation(String? value, String? messageError) {
  var required = requiredValidator(value, messageError);
  return required;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
