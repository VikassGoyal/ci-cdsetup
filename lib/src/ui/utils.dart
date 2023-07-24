import 'package:conet/constants/enums.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Future<bool?> displayToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.accentColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static Future<bool?> displayToastBottomError(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.redColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static Future<bool?> displayToastTopError(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColor.redColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static showLoader(context, primarycolor) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primarycolor ? AppColor.primaryColor : AppColor.whiteColor),
              ),
            ],
          ),
        );
      },
    );
  }

  static SnackBar displaySnackBar(String message,
      {String? actionMessage, VoidCallback? onClick, Color? backgroundColor, Duration? duration}) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      action: (actionMessage != null)
          ? SnackBarAction(
              textColor: Colors.white,
              label: actionMessage,
              onPressed: () {
                return onClick!();
              },
            )
          : null,
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: backgroundColor ?? AppColor.accentColor,
    );
  }

  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

extension EnumParser on String {
  OccupationType? toOccupation() {
    try {
      return OccupationType.values.firstWhere((e) => e.name.toLowerCase() == toLowerCase());
    } catch (err) {
      return null;
    }
  }
}
