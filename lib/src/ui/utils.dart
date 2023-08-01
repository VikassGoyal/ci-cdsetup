import 'dart:async';

import 'package:conet/constants/enums.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';

class Utils {
  static displayToast(String message, BuildContext context) {
    bool check = false;
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: message,
      onConfirmBtnTap: () {
        return;
      },
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static displayToastBottomError(String message, BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
      onConfirmBtnTap: () {
        return;
      },
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static displayToastTopError(String message, BuildContext context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
      autoCloseDuration: const Duration(seconds: 4),
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

  WorkNatureType? toWorkNature() {
    try {
      return WorkNatureType.values.firstWhere((e) => e.name.toLowerCase() == toLowerCase());
    } catch (err) {
      return null;
    }
  }

  IndustryType? toIndustry() {
    try {
      return IndustryType.values.firstWhere((e) => e.name.toLowerCase() == toLowerCase());
    } catch (err) {
      return null;
    }
  }
}
