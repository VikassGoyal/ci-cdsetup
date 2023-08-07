import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conet/api_models/uploadbusinesslogo_request_%20model/uploadebusinesslogo_request_body.dart';
import 'package:conet/config/app_config.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/get_it.dart';
import 'package:conet/utils/theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/gtm.dart';
import 'package:image_picker/image_picker.dart';

import '../../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';

class BussinessCard extends StatefulWidget {
  @override
  _BussinessCardState createState() => _BussinessCardState();
}

class _BussinessCardState extends State<BussinessCard> {
  File? _image;
  final picker = ImagePicker();
  final ContactPageRepository _contactPageRepository = ContactPageRepository();

  // List<Asset> businesslogo = <Asset>[];
  String _qrImage = "";
  String imageName = "";
  String uploadedImageLogo = '';
  bool _showQr = true;
  bool _loader = true;
  Color? currentColor;
  ContactDetail? contactDetail;
  final gtm = Gtm.instance;
  void changeColor(Color color) {
    setState(() => currentColor = color);
    locator<StorageService>().setPrefs<String>('businesscardcolor', color.toString());
  }

  @override
  void initState() {
    super.initState();
    gtm.push("screen_view", parameters: {"pageName": "Business Card Screen"});
    getQRImage();
    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    _renderBg() {
      return Container(
        decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
      );
    }

    _renderContent(context) {
      //   return Card(
      //     elevation: 18.h,
      //     margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
      //     color: const Color(0x00000000),
      //     child: FlipCard(
      //       direction: FlipDirection.HORIZONTAL,
      //       speed: 700,
      //       onFlipDone: (status) {
      //         print(status);
      //       },
      //       front: Container(
      //         padding: const EdgeInsets.only(right: 16, left: 16),
      //         decoration: BoxDecoration(
      //           color: currentColor,
      //           borderRadius: const BorderRadius.all(Radius.circular(18.0)),
      //         ),
      //         child: Column(
      //           children: <Widget>[
      //             Expanded(
      //               flex: 8,
      //               child: Container(
      //                 child: CachedNetworkImage(
      //                   width: MediaQuery.of(context).size.width / 2,
      //                   imageUrl: imageName != "" ? AppConstant.businessimageBaseUrl + imageName : "",
      //                   placeholder: (context, url) => SvgPicture.asset("assets/logo.svg"),
      //                   errorWidget: (context, url, error) => Center(
      //                     child: KonetLogo(
      //                       logoHeight: 24,
      //                       fontSize: 19,
      //                       textPadding: 9,
      //                       spacing: 9,
      //                     ),
      //                   ),
      //                   fit: BoxFit.contain,
      //                 ),
      //               ),
      //             ),

      //           ],
      //         ),
      //       ),
      //       back: Container(
      //         padding: const EdgeInsets.only(right: 40, left: 40),
      //         decoration: BoxDecoration(
      //           color: currentColor,
      //           borderRadius: const BorderRadius.all(Radius.circular(18.0)),
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             Expanded(
      //                 flex: 1,
      //                 child: CachedNetworkImage(
      //                   width: MediaQuery.of(context).size.width / 2,
      //                   imageUrl: imageName != "" ? AppConstant.businessimageBaseUrl + imageName : "",
      //                   placeholder: (context, url) => SvgPicture.asset("assets/logo.svg"),
      //                   errorWidget: (context, url, error) => Center(
      //                     child: KonetLogo(
      //                       logoHeight: 24,
      //                       fontSize: 19,
      //                       textPadding: 9,
      //                       spacing: 9,
      //                     ),
      //                   ),
      //                   fit: BoxFit.contain,
      //                 )
      //                 // SvgPicture.asset("assets/logo.svg"),
      //                 ),
      //             Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 //color: Colors.white,
      //               ),
      //               margin: const EdgeInsets.only(left: 15.0, top: 25.0, right: 15.0),
      //               padding: const EdgeInsets.all(10),
      //               child: _showQr
      //                   ? const CircularProgressIndicator(
      //                       valueColor: AlwaysStoppedAnimation<Color>(
      //                         AppColor.primaryColor,
      //                       ),
      //                     )
      //                   : _qrImage == ''
      //                       ? const Center(
      //                           child: Text(
      //                             'NO QR CODE',
      //                             style: TextStyle(
      //                               color: AppColor.primaryColor,
      //                             ),
      //                           ),
      //                         )
      //                       : SvgPicture.network(
      //                           "https://www.svgrepo.com/show/76016/qr-code.svg",
      //                           width: 150,
      //                           height: 150,
      //                         ),
      //             ),
      //             const SizedBox(height: 20),
      //             Text(
      //               'Point your camera at the QR code, to fetch Business card details',
      //               textAlign: TextAlign.center,
      //               style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
      //             ),
      //             Expanded(
      //               flex: 1,
      //               child: Container(),
      //             ),
      //             Expanded(
      //               flex: 1,
      //               child: Visibility(
      //                 visible: imageName != null ? true : false,
      //                 child: const KonetLogo(
      //                   logoHeight: 24,
      //                   fontSize: 19,
      //                   textPadding: 9,
      //                   spacing: 9,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
      return Card(
        elevation: 18.h,
        margin: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 20.0.h, bottom: 0.0.h),
        color: const Color(0x00000000),
        child: Container(
          padding: EdgeInsets.only(right: 40.w, left: 40.w),
          decoration: BoxDecoration(
            color: currentColor,
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 34.h,
              ),
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 2,
                    imageUrl: imageName != "" ? AppConstant.businessimageBaseUrl + imageName : "",
                    placeholder: (context, url) => SvgPicture.asset("assets/logo.svg"),
                    errorWidget: (context, url, error) => Center(
                      child: KonetLogo(
                        logoHeight: 24,
                        fontSize: 19,
                        textPadding: 9,
                        spacing: 9,
                      ),
                    ),
                    fit: BoxFit.contain,
                  )
                  // SvgPicture.asset("assets/logo.svg"),
                  ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white,
                ),
                margin: EdgeInsets.only(left: 15.0.w, top: 25.0.h, right: 15.0.w),
                padding: const EdgeInsets.all(10),
                child: _showQr
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.primaryColor,
                        ),
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
                        : SvgPicture.network(
                            _qrImage,
                            width: 150,
                            height: 150,
                          ),
              ),
              SizedBox(height: 34.h),
              Text('Point your camera at the QR code, to fetch Business card details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColor.whiteColor,
                      fontFamily: kSfproRoundedFontFamily,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300)),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: imageName != null ? true : false,
                  child: const KonetLogo(
                    logoHeight: 24,
                    fontSize: 19,
                    textPadding: 9,
                    spacing: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleWhite,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leadingWidth: 80.w,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: const Icon(Icons.arrow_back, color: AppColor.blackColor),
              ),
              // SizedBox(width: 6.w),
              // Text(
              //   'Back',
              //   style: TextStyle(
              //     fontFamily: kSfproRoundedFontFamily,
              //     color: AppColor.blackColor,
              //     fontSize: 15.sp,
              //     fontWeight: FontWeight.w300,
              //     fontStyle: FontStyle.normal,
              //   ),
              // ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Share Business Card",
          style: TextStyle(
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.black3,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: const Color(0xFFF0F0F0),
            elevation: 10,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Icon(Icons.more_horiz, color: AppColor.black3)),
            onSelected: (value) {
              print(value);
              if (value == 3) {
                print("val");
                if (contactDetail!.id != null) removeBusinessCard(contactDetail!.id!.toString());
              }

              if (value == 1) {
                loadbusinesslogo();
              } else if (value == 2) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentColor!,
                          onColorChanged: changeColor,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Upload Image",
                  style: TextStyle(
                    fontFamily: kSfproDisplayFontFamily,
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Change color",
                  style: TextStyle(
                    fontFamily: kSfproDisplayFontFamily,
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  "Remove Image",
                  style: TextStyle(
                    fontFamily: kSfproDisplayFontFamily,
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: _loader
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
                  ),
                ],
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _renderBg(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 6,
                      child: _renderContent(context),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  getQRImage() async {
    String? qrimage = locator<StorageService>().getPrefs('image');

    if (locator<StorageService>().getPrefs('businesscardcolor') != null) {
      String? colorString = locator<StorageService>().getPrefs('businesscardcolor');
      String? valueString = colorString?.split('(0x')[1].split(')')[0];
      int? value = int.parse(valueString!, radix: 16);
      Color colorvalue = Color(value);

      currentColor =
          locator<StorageService>().getPrefs('businesscardcolor') == null ? AppColor.primaryColor : colorvalue;
    } else {
      currentColor = AppColor.primaryColor;
    }

    setState(() {
      _qrImage = "${locator<AppConfig>().baseApiUrl}$qrimage";
      _showQr = false;
    });
  }

  getProfileDetails() async {
    setState(() {
      _loader = true;
    });

    try {
      // var requestBody = {
      //   "phone": locator<StorageService>().getPrefs('phone'),
      // };
      var response = await _contactPageRepository
          .getProfileDetails(GetProfileDetailsRequestBody(phone: locator<StorageService>().getPrefs('phone')));

      setState(() {
        _loader = false;
      });

      if (response['status'] == true) {
        contactDetail = ContactDetail.fromJson(response["user"]);

        setState(() {
          imageName = contactDetail!.businesscardLogo ?? "";
        });
      } else {
        Utils.displayToastBottomError(response["message"], context);
      }
    } catch (e) {
      print(e);
    }
  }

  File? image;
  String imagePath = "";
  Uint8List? imageBytes;

  removeBusinessCard(String id) async {
    try {
      Map<String, dynamic> response = await _contactPageRepository.removeBusinessCard(id);

      if (response['status']) {
        gtm.push("business_card_logo_delete", parameters: {"status": "done"});
        Utils.displayToast("Logo Removed", context);
        setState(() {
          imageName = "";
        });
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadbusinesslogo() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imagePath = image.path;
      imageBytes = await image.readAsBytes();

      setState(() {
        this.image = imageTemporary;
        var buffer = imageBytes!.buffer;
        var base64data = base64.encode(Uint8List.view(buffer));
        uploadedImageLogo = base64data;
        uploadebusinesslogo();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      Utils.displayToastBottomError("Failed to pick image: $e", context);
    }
  }

  void uploadebusinesslogo() async {
    // var jsonData = {
    //   "base64data_logo": "data:image/png;base64,$uploadedImageLogo",
    // };

    setState(() {
      _loader = true;
    });

    try {
      var response = await _contactPageRepository.updatebusinesslogo(
          UploadbusinesslogoRequestBody(base64data_logo: "data:image/png;base64,$uploadedImageLogo"));
      setState(() {
        _loader = false;
      });

      if (response['status'] == true) {
        gtm.push("business_card_logo_delete", parameters: {"status": "done"});
        Utils.displayToast(response['message'], context);
        getProfileDetails();
      } else {
        Utils.displayToastBottomError("Try Again!", context);
      }
    } catch (e) {
      print(e);
    }
  }
}
