import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final bool? value;

  const AnimatedToggle({
    super.key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.value,
  });
  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool? initialPosition;

  @override
  void initState() {
    super.initState();
    initialPosition = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width * 0.6,
      width: 170.w,
      // margin: const EdgeInsets.all(20),
      margin: EdgeInsets.all(8.w),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition!;
              var index = 1;
              if (!initialPosition!) {
                index = 0;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 170.w,
              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: initialPosition! ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              // width: Get.width * 0.33,
              width: 90.w,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition! ? widget.values[1] : widget.values[0],
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: kSfproRoundedFontFamily,
                  fontWeight: FontWeight.w400,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
