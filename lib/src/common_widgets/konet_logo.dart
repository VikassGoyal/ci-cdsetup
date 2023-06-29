import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KonetLogo extends StatelessWidget {
  const KonetLogo({super.key, this.logoHeight = 42, this.fontSize = 35, this.spacing = 15, this.textPadding = 15});

  final double logoHeight;
  final double fontSize;
  final double spacing;
  final double textPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/logo.svg",
          color: Colors.white,
          height: logoHeight,
        ),
        SizedBox(width: spacing),
        Padding(
          padding: EdgeInsets.only(top: textPadding),
          child: Text(
            'KONET',
            style: TextStyle(
              fontFamily: 'Dreadnoughtus',
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
