import 'package:conet/config/app_config.dart';
import 'package:conet/utils/get_it.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
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
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_sharp,
                color: AppColor.whiteColor,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                "Back",
                style: Theme.of(context).textTheme.bodyText2!.apply(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "QR Scanner",
          style: Theme.of(context).textTheme.headline4!.apply(color: AppColor.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Scan QR Code",
                style: Theme.of(context).textTheme.headline4!.apply(color: AppColor.whiteColor),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Place qr code inside the frame to scan please avoid shake to get results quickly",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15.0, top: 25.0, right: 15.0),
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
                              height: 200,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 25,
                              child: SvgPicture.network(
                                _qrImage,
                                width: 150,
                                height: 150,
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
      _qrImage = "${locator<AppConfig>().baseApiUrl}/$qrimage";
      _showQr = false;
    });
  }
}
