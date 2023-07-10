import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String _qrImage = "";
  bool _showQr = true;

  @override
  void initState() {
    super.initState();
    getQRImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leadingWidth: 80.w,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              SizedBox(width: 6.w),
              Text(
                'Back',
                style: TextStyle(
                  fontFamily: kSfproRoundedFontFamily,
                  color: AppColor.whiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text("QR Scanner",
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontFamily: kSfproRoundedFontFamily,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Scan QR Code",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontFamily: kSfproRoundedFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Place qr code inside the frame to scan please avoid shake to get results quickly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontFamily: kSfproRoundedFontFamily,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0.w, top: 25.0.h, right: 15.0.h),
              padding: const EdgeInsets.all(15.0),
              child: _showQr
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                    )
                  : _qrImage == ''
                      ? const Center(
                          child: Text(
                            'NO QR CODE',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/images/qrscannerbg.svg",
                              height: 200.h,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 25.h,
                              child: SvgPicture.network(
                                _qrImage,
                                width: 150.w,
                                height: 150.h,
                              ),
                            )
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  getQRImage() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? qrimage = preferences.getString('image');
    setState(() {
      _qrImage = "http://conet.shade6.in/$qrimage";
      _showQr = false;
    });
  }
}
