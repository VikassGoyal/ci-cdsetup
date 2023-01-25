import 'dart:ui';

import 'package:flutter/material.dart';

class Imagepreview extends StatefulWidget {
  const Imagepreview({Key? key}) : super(key: key);

  @override
  _ImagepreviewState createState() => _ImagepreviewState();
}

class _ImagepreviewState extends State<Imagepreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          )
        ],
      ),
    );
  }
}
