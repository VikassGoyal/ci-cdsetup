import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quickalert/quickalert.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElevatedButton(
            onPressed: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Transaction Completed Successfully!',
              );
            },
            child: Text("click")));
  }
}
