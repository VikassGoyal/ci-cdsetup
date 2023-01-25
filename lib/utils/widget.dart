import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';

ButtonTheme raisedButton(
    {VoidCallback? onClick,
    String? text,
    Color? bgColor,
    double? padding,
    context}) {
  return ButtonTheme(
    child: Container(
      height: 48,
      padding: EdgeInsets.only(
          left: padding ?? 16,
          right: padding ?? 16),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(bgColor!)),
        onPressed: () {
          return onClick!();
        },
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .button
              ?.apply(color: AppColor.whiteColor),
        ),
      ),
    ),
  );
  // return ButtonTheme(
  //   child: RaisedButton(
  //     color: bgColor,
  //     onPressed: () {
  //       return onClick();
  //     },
  //     child: Container(
  //       height: 50,
  //       alignment: Alignment.center,
  //       child: Text(
  //         text ?? '',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 18,
  //           fontFamily: "Sf-Medium",
  //           letterSpacing: 0.9,
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}

ButtonTheme blueButton({
  VoidCallback? onClick,
  String? text,
  Color? bgColor,
}) {
  return ButtonTheme(
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor!)),
      onPressed: () {
        return onClick!();
      },
      child: Container(
        width: 300,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Sfpro-Rounded-Medium',
            inherit: true,
            color: AppColor.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.9,
          ),
        ),
      ),
    ),
  );
}
