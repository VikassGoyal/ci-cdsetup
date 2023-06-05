import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController? controller;
  final String? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final int? maxLength;
  final RegExp? regexexp;

  const TextFormFieldContact(
      {required this.hintText,
      this.focusNode,
      this.padding,
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
      this.maxLength,
      this.regexexp});

  @override
  _TextFormFieldContactState createState() => _TextFormFieldContactState();
}

class _TextFormFieldContactState extends State<TextFormFieldContact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.only(left: widget.padding!, right: widget.padding!),
      margin: EdgeInsets.only(
        left: widget.margin ?? 0,
        right: widget.margin ?? 0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextFormField(
        readOnly: widget.readonly!,
        // validator: (text) {
        //   if (text == null || text.isEmpty || !RegExp('[0-9]').hasMatch(text)) {
        //     return 'Text is empty or invalid';
        //   }
        //   return null;
        // },
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.apply(color: AppColor.secondaryColor),
        maxLength: widget.maxLength,
        inputFormatters: widget.regexexp != null
            ? [
                FilteringTextInputFormatter.allow(widget.regexexp!),
              ]
            : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
          labelText: widget.hintText,
          counterText: "",
          labelStyle: Theme.of(context).textTheme.headline6?.apply(
                color: const Color.fromRGBO(135, 139, 149, 1),
              ),
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

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
