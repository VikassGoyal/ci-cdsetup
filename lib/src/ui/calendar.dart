import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            todayHighlightColor: AppColor.secondaryColor,
            yearCellStyle: DateRangePickerYearCellStyle(
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfCompactDisplayFontFamily,
                    color: AppColor.blackColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600)),
            monthCellStyle: DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: AppColor.blackColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
              textStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: AppColor.blackColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: AppColor.blackColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            rangeSelectionColor: AppColor.primaryColor,
            rangeTextStyle: TextStyle(
                fontSize: 15.sp,
                fontFamily: kSfCompactDisplayFontFamily,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600),
            selectionTextStyle: TextStyle(
                fontSize: 15.sp,
                fontFamily: kSfCompactDisplayFontFamily,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600),
            startRangeSelectionColor: AppColor.primaryColor,
            endRangeSelectionColor: AppColor.primaryColor,
          ),
          SizedBox(
            height: 130.h,
          ),
          Text(
            "You can sort the phone calls",
            style: TextStyle(
                color: AppColor.placeholder,
                fontSize: 15.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),
          ),
          Text(
            "according to any date range.",
            style: TextStyle(
                color: AppColor.placeholder,
                fontSize: 15.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
            height: 50.h,
            width: 331.w,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: AppColor.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 15.sp,
                    fontFamily: kSfCompactDisplayFontFamily,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
