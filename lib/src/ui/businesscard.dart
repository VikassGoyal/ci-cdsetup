import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BussinessCard extends StatefulWidget {
  @override
  _BussinessCardState createState() => _BussinessCardState();
}

class _BussinessCardState extends State<BussinessCard> {
  File? _image;
  final picker = ImagePicker();
  final ContactPageRepository _contactPageRepository = ContactPageRepository();

  List<Asset> businesslogo = <Asset>[];
  String _qrImage = "";
  String imageName = "";
  String uploadedImageLogo = '';
  bool _showQr = true;
  bool _loader = true;
  Color? currentColor;

  SharedPreferences? preferences;
  void changeColor(Color color) {
    setState(() => currentColor = color);
    preferences!.setString('businesscardcolor', color.toString());
  }

  @override
  void initState() {
    super.initState();

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
      return Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
        color: const Color(0x00000000),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 700,
          onFlipDone: (status) {
            print(status);
          },
          front: Container(
            padding: const EdgeInsets.only(right: 16, left: 16),
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Container(
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 2,
                      imageUrl: imageName != ""
                          ? AppConstant.businessimageBaseUrl + imageName
                          : "",
                      placeholder: (context, url) =>
                          SvgPicture.asset("assets/logo.svg"),
                      errorWidget: (context, url, error) =>
                          SvgPicture.asset("assets/logo.svg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Click here to flip back',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: AppColor.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          back: Container(
            padding: const EdgeInsets.only(right: 40, left: 40),
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 2,
                      imageUrl: imageName != ""
                          ? AppConstant.businessimageBaseUrl + imageName
                          : "",
                      placeholder: (context, url) =>
                          SvgPicture.asset("assets/logo.svg"),
                      errorWidget: (context, url, error) =>
                          SvgPicture.asset("assets/logo.svg"),
                      fit: BoxFit.contain,
                    )
                    // SvgPicture.asset("assets/logo.svg"),
                    ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      const EdgeInsets.only(left: 15.0, top: 25.0, right: 15.0),
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
                const SizedBox(height: 20),
                Text(
                  'Point your camera at the QR code, to fetch Business card details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: AppColor.whiteColor),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: imageName != null ? true : false,
                    child: SvgPicture.asset("assets/logo.svg"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 2,
              ),
              const Icon(
                Icons.arrow_back_sharp,
                color: AppColor.blackColor,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                "Back",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.apply(color: AppColor.blackColor),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Share Business Card",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.apply(color: AppColor.blackColor),
        ),
        actions: [
          PopupMenuButton(
            color: const Color(0xFFF0F0F0),
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Icon(
                Icons.more_horiz,
                color: AppColor.blackColor,
              ),
            ),
            onSelected: (value) {
              if (value == 1) {
                loadbusinesslogo();
              } else {
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
                          showLabel: true,
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: AppColor.blackColor),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Change color",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: AppColor.blackColor),
                ),
              )
            ],
          )
        ],
      ),
      body: _loader
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
    preferences = await SharedPreferences.getInstance();

    String? qrimage = preferences!.getString('image');

    if (preferences!.getString('businesscardcolor') != null) {
      String? colorString = preferences?.getString('businesscardcolor');
      String? valueString = colorString?.split('(0x')[1].split(')')[0];
      int? value = int.parse(valueString!, radix: 16);
      Color colorvalue = Color(value);

      currentColor = preferences?.getString('businesscardcolor') == null
          ? AppColor.primaryColor
          : colorvalue;
    } else {
      currentColor = AppColor.primaryColor;
    }

    setState(() {
      _qrImage = "http://conet.shadesix.in/$qrimage";
      _showQr = false;
    });
  }

  getProfileDetails() async {
    setState(() {
      _loader = true;
    });
    preferences = await SharedPreferences.getInstance();

    try {
      var requestBody = {
        "phone": preferences?.getString('phone'),
      };
      var response =
          await _contactPageRepository.getProfileDetails(requestBody);

      setState(() {
        _loader = false;
      });

      if (response['status'] == true) {
        ContactDetail contactDetail = ContactDetail.fromJson(response["user"]);

        setState(() {
          imageName = contactDetail.businesscardLogo ?? "";
        });
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadbusinesslogo() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: businesslogo,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#c92329",
          statusBarColor: "#c92329",
          actionBarTitle: "New Post Images",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#c92329",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    List<Asset> assets = resultList;
    int i = 0;
    for (Asset asset in assets) {
      var bytes = await asset.getByteData();
      var buffer = bytes.buffer;
      var base64data = base64.encode(Uint8List.view(buffer));
      i = i + 1;

      setState(() {
        if (i == 1) {
          uploadedImageLogo = base64data;
          uploadebusinesslogo();
        }
      });
    }
    if (!mounted) return;
  }

  void uploadebusinesslogo() async {
    var jsonData = {
      "base64data_logo": "data:image/png;base64,$uploadedImageLogo",
    };

    setState(() {
      _loader = true;
    });

    try {
      var response = await _contactPageRepository.updatebusinesslogo(jsonData);
      setState(() {
        _loader = false;
      });

      if (response['status'] == true) {
        Utils.displayToast(response['message']);
        getProfileDetails();
      } else {
        Utils.displayToast("Try Again!");
      }
    } catch (e) {
      print(e);
    }
  }
}
