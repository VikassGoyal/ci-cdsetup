import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/models/imageUploadModel.dart';
import 'package:conet/src/ui/contact/editProfile.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

import '../utils.dart';

class MyProfile extends StatefulWidget {
  String? phoneNumber;

  MyProfile(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _personalName = TextEditingController();
  final _personalNumber = TextEditingController();
  final _personalSecondaryNumber = TextEditingController();
  final _personalEmail = TextEditingController();
  final _personalDob = TextEditingController();
  final _personalAddress = TextEditingController();
  final _personalCity = TextEditingController();
  final _personalState = TextEditingController();
  final _personalCountry = TextEditingController();
  final _personalPincode = TextEditingController();
  final _personalKeyword = TextEditingController();
  final _personalLandline = TextEditingController();

  final _professionalOccupation = TextEditingController();
  final _professionalIndustry = TextEditingController();
  final _professionalCompany = TextEditingController();
  final _professionalCompanyWebsite = TextEditingController();
  final _professionalSchool = TextEditingController();
  final _professionalGrade = TextEditingController();
  final _professionalWorkNature = TextEditingController();
  final _professionalDesignation = TextEditingController();

  final _socialFacebook = TextEditingController();
  final _socialInstagram = TextEditingController();
  final _socialTwitter = TextEditingController();
  final _socialSkype = TextEditingController();
  final _socialGpay = TextEditingController();
  final _socialPaytm = TextEditingController();

  List<EntrepreneurData> entreprenerurList = [];
  List<ProfessionalList> entreprenerurListJson = [];

  ContactDetail? contactDetail;
  String? _occupationValue;
  DateTime? selectedDate;

  bool _loader = false;
  final bool _loaderoverflow = false;
  bool personalTab = true;
  bool _enterpreneurForms = false;
  bool _companyVisible = false;
  bool _companyWebsiteVisible = false;
  bool _companyWorkNatureVisible = false;
  bool _studentSchoolVisible = false;
  bool _studentGradeVisible = false;
  bool _designationVisible = false;
  String userImage = '';
  List<String> _values = [];
  List<NetworkImage> popupImages = <NetworkImage>[];
  // bool _showPreview = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      print(widget.phoneNumber);
      getProfileDetails(widget.phoneNumber!);
    });
    _socialInstagram.text = "";
  }

  @override
  Widget build(BuildContext context) {
    void displayImages() {
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          // barrierDismissible: false,
          builder: (BuildContext ctx) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.all(20),
                        child: const Icon(
                          Icons.close_rounded,
                          color: AppColor.blackColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300.0,
                    width: 350.0,
                    child: AnotherCarousel(
                      boxFit: BoxFit.cover,
                      images: popupImages,
                      autoplay: false,
                      indicatorBgPadding: 5.0,
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotPosition: DotPosition.bottomCenter,
                      dotColor: AppColor.primaryColor,
                      dotIncreasedColor: AppColor.primaryColor,
                      dotBgColor: Colors.grey.withOpacity(0.5),
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: const Duration(milliseconds: 2000),
                    ),
                  )
                ],
              ),
            );
          });
    }

    Widget buildChips() {
      List<Widget> chips = [];

      for (int i = 0; i < _values.length; i++) {
        InputChip actionChip = InputChip(
          selectedColor: AppColor.primaryColor,
          shadowColor: AppColor.primaryColor,
          backgroundColor: AppColor.primaryColor,
          label: Text(_values[i]),
          pressElevation: 5,
          onPressed: () {},
        );
        chips.add(actionChip);
      }

      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 6.0,
        runSpacing: 6.0,
        children: chips,
      );
    }

    Widget keywordbody() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 22.0, right: 22.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(232, 232, 232, 1),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Keywords",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2!.apply(color: const Color.fromRGBO(135, 139, 149, 1)),
            ),
            buildChips(),
          ],
        ),
      );
    }

    Widget selectButton() {
      return Row(
        children: [
          const SizedBox(width: 22),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(personalTab ? AppColor.accentColor : AppColor.whiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColor.accentColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  personalTab = true;
                });
              },
              child: Text(
                'Personal',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .apply(color: personalTab ? AppColor.whiteColor : AppColor.accentColor),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(personalTab ? AppColor.whiteColor : AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColor.secondaryColor,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    personalTab = false;
                  },
                );
              },
              child: Text(
                'Professional',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .apply(color: personalTab ? AppColor.secondaryColor : AppColor.whiteColor),
              ),
            ),
          ),
          const SizedBox(width: 22),
        ],
      );
    }

    Widget _buildMobileNumber() {
      return TextFormFieldContact(
        hintText: "Mobile number",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalNumber,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildSecondaryPhoneNumber() {
      return TextFormFieldContact(
        hintText: "Secondary Phone Number",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        enable: false,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalSecondaryNumber,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildEmailId() {
      return TextFormFieldContact(
        hintText: "Email",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalEmail,
        parametersValidate: "Please enter Email.",
      );
    }

    Widget _buildDob() {
      return TextFormFieldContact(
        hintText: "DOB",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalDob,
      );
    }

    Widget _buildAddress() {
      return TextFormFieldContact(
        hintText: "Address",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalAddress,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildCountry() {
      return TextFormFieldContact(
        hintText: "Country",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalCountry,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildState() {
      return TextFormFieldContact(
        hintText: "State",
        padding: 14.0,
        readonly: true,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalState,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildCity() {
      return TextFormFieldContact(
        hintText: "City",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalCity,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildPincode() {
      return TextFormFieldContact(
        hintText: "Pincode",
        padding: 14.0,
        readonly: true,
        margin: 22.0,
        textInputType: TextInputType.phone,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalPincode,
        parametersValidate: "Please enter Address.",
      );
    }

    // Widget _buildKeyword() {
    //   return Container(
    //     margin: EdgeInsets.only(left: 22.0, right: 22.0),
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: Color.fromRGBO(232, 232, 232, 1),
    //       ),
    //       borderRadius: BorderRadius.circular(7),
    //     ),
    //     child: TextFormField(
    //       style: Theme.of(context).textTheme.bodyText2!.apply(
    //             color: AppColor.secondaryColor,
    //           ),
    //       decoration: InputDecoration(
    //         labelText: "Keyword",
    //         filled: true,
    //         fillColor: AppColor.whiteColor,
    //         focusedBorder: InputBorder.none,
    //         hintStyle: Theme.of(context).textTheme.bodyText2!.apply(
    //               color: Color(0xFF878B95),
    //             ),
    //         labelStyle: Theme.of(context).textTheme.headline6!.apply(
    //               color: Color.fromRGBO(135, 139, 149, 1),
    //             ),
    //       ),
    //       readOnly: true,
    //       cursorColor: AppColor.secondaryColor,
    //       validator: (value) {
    //         return null;
    //       },
    //       controller: _personalKeyword,
    //       keyboardType: TextInputType.multiline,
    //       minLines: 2,
    //       maxLines: 5,
    //     ),
    //   );
    // }

    Widget _buildLandLine() {
      return TextFormFieldContact(
        hintText: "Landline Number",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.number,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalLandline,
        parametersValidate: "Please enter Landline Number.",
      );
    }

    Widget _buildPersonalUpdateButton() {
      return Container(
        margin: const EdgeInsets.only(left: 22, right: 22),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
          ),
          onPressed: () async {
            print("clicked");
            setState(
              () {
                personalTab = false;
              },
            );
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button!.apply(color: AppColor.whiteColor),
            ),
          ),
        ),
      );
    }

    //Professional
    Widget _buildOccupation() {
      return TextFormFieldContact(
        hintText: "Occupation",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _professionalOccupation,
        parametersValidate: "Please enter Occupation.",
      );
    }

    Widget _buildCompany() {
      return TextFormFieldContact(
        hintText: "Company",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _professionalCompany,
        parametersValidate: "Please enter Company.",
      );
    }

    Widget _buildCompanyWebsite() {
      return TextFormFieldContact(
        hintText: "Company Website",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _professionalCompanyWebsite,
        parametersValidate: "Please enter Company Website.",
      );
    }

    Widget _buildProfessionalSchool() {
      return TextFormFieldContact(
        hintText: "School / University",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _professionalSchool,
        parametersValidate: "Please enter School / University.",
      );
    }

    Widget _buildGrade() {
      return TextFormFieldContact(
        hintText: "Grade",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _professionalGrade,
        parametersValidate: "Please enter Grede.",
      );
    }

    Widget _buildworknature() {
      return TextFormFieldContact(
        hintText: "Work Nature",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _professionalWorkNature,
        parametersValidate: "Please enter Work Nature.",
      );
    }

    Widget _buildDesignation() {
      return TextFormFieldContact(
        hintText: "Designation",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _professionalDesignation,
        parametersValidate: "Please enter Designation.",
      );
    }

    Widget _buildworkFacebook() {
      return TextFormFieldContact(
        hintText: "Facebook",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialFacebook,
        parametersValidate: "Please enter Facebook.",
      );
    }

    Widget _buildworkInstagram() {
      return TextFormFieldContact(
        hintText: "Instagram",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialInstagram,
        parametersValidate: "Please enter Instagram.",
      );
    }

    Widget _buildworkTwitter() {
      return TextFormFieldContact(
        hintText: "Twitter",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialTwitter,
        parametersValidate: "Please enter Twitter.",
      );
    }

    Widget _buildworkSkype() {
      return TextFormFieldContact(
        hintText: "Skype",
        padding: 14.0,
        margin: 22.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialSkype,
        parametersValidate: "Please enter Skype.",
      );
    }

    entreprenerurItemNew(int i) {
      return Padding(
        // padding: EdgeInsets.all(16),
        padding: const EdgeInsets.only(left: 25.0, right: 20, top: 30, bottom: 16),
        child: Material(
          color: AppColor.whiteColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Company Profile ${i + 1}",
                    style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.bottomUnselectItemColor),
                  ),
                ],
              ),
              Container(
                height: 48,
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                margin: const EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(232, 232, 232, 1),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyText2!.apply(color: AppColor.secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                    labelText: "Company",
                    labelStyle: Theme.of(context).textTheme.headline6!.apply(
                          color: const Color.fromRGBO(135, 139, 149, 1),
                        ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: InputBorder.none,
                  ),
                  initialValue: entreprenerurList[i].company,
                  cursorColor: AppColor.secondaryColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      entreprenerurList[i].company = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 48,
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(232, 232, 232, 1),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyText2!.apply(color: AppColor.secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                    labelText: "Website",
                    labelStyle: Theme.of(context).textTheme.headline6!.apply(
                          color: const Color.fromRGBO(135, 139, 149, 1),
                        ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: AppColor.secondaryColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: entreprenerurList[i].website,
                  onChanged: (value) {
                    setState(() {
                      entreprenerurList[i].website = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 48,
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(232, 232, 232, 1),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2!.apply(color: AppColor.secondaryColor),
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                    labelText: 'Work Nature',
                    labelStyle: Theme.of(context).textTheme.headline6!.apply(
                          color: const Color.fromRGBO(135, 139, 149, 1),
                        ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: AppColor.secondaryColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: entreprenerurList[i].workNature,
                  onChanged: (value) {
                    setState(() {
                      entreprenerurList[i].workNature = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Visibility(
                    visible: entreprenerurList[i].images!.asMap().containsKey(0),
                    child: Flexible(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 114,
                            height: 102,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (entreprenerurList[i].images!.isNotEmpty
                                      ? entreprenerurList[i].images![0].isUploaded!
                                      : false)
                                  ? InkWell(
                                      onTap: () {
                                        List<NetworkImage> listOfImages = <NetworkImage>[];
                                        listOfImages = [];

                                        if (entreprenerurList[i].images!.isNotEmpty) {
                                          listOfImages.add(
                                            NetworkImage(
                                                AppConstant.imageBaseUrl + entreprenerurList[i].images![0].imageUrl!),
                                          );
                                        }

                                        if (entreprenerurList[i].images!.length >= 2) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![1].imageUrl!));
                                        }

                                        if (entreprenerurList[i].images!.length >= 3) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![2].imageUrl!));
                                        }

                                        popupImages = listOfImages;

                                        displayImages();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: entreprenerurList[i].images!.isNotEmpty
                                            ? AppConstant.imageBaseUrl + entreprenerurList[i].images![0].imageUrl!
                                            : "",
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => Image.asset(
                                          "assets/images/placeholderImage.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          "assets/images/placeholderImage.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : (entreprenerurList[i].images!.isNotEmpty
                                      ? AssetThumb(
                                          asset: entreprenerurList[i].images![0].imageAsset,
                                          width: 114,
                                          height: 102,
                                        )
                                      : const SizedBox(
                                          width: 114,
                                          height: 102,
                                        )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: entreprenerurList[i].images!.asMap().containsKey(1),
                    child: Flexible(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 114,
                            height: 102,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (entreprenerurList[i].images!.length >= 2
                                      ? entreprenerurList[i].images![1].isUploaded!
                                      : false)
                                  ? InkWell(
                                      onTap: () {
                                        List<NetworkImage> listOfImages = <NetworkImage>[];
                                        listOfImages = [];

                                        if (entreprenerurList[i].images!.isNotEmpty) {
                                          listOfImages.add(
                                            NetworkImage(
                                                AppConstant.imageBaseUrl + entreprenerurList[i].images![0].imageUrl!),
                                          );
                                        }

                                        if (entreprenerurList[i].images!.length >= 2) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![1].imageUrl!));
                                        }

                                        if (entreprenerurList[i].images!.length >= 3) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![2].imageUrl!));
                                        }

                                        popupImages = listOfImages;

                                        displayImages();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: entreprenerurList[i].images!.length >= 2
                                            ? AppConstant.imageBaseUrl + entreprenerurList[i].images![1].imageUrl!
                                            : "",
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => Image.asset(
                                          "assets/images/placeholderImage.jpg",
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    )
                                  : (entreprenerurList[i].images!.length >= 2
                                      ? AssetThumb(
                                          asset: entreprenerurList[i].images![1].imageAsset,
                                          width: 114,
                                          height: 102,
                                        )
                                      : const SizedBox(
                                          width: 114,
                                          height: 102,
                                        )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: entreprenerurList[i].images!.asMap().containsKey(2),
                    child: Flexible(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 114,
                            height: 102,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (entreprenerurList[i].images!.length == 3
                                      ? entreprenerurList[i].images![2].isUploaded!
                                      : false)
                                  ? InkWell(
                                      onTap: () {
                                        List<NetworkImage> listOfImages = <NetworkImage>[];
                                        listOfImages = [];

                                        if (entreprenerurList[i].images!.isNotEmpty) {
                                          listOfImages.add(
                                            NetworkImage(
                                                AppConstant.imageBaseUrl + entreprenerurList[i].images![0].imageUrl!),
                                          );
                                        }

                                        if (entreprenerurList[i].images!.length >= 2) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![1].imageUrl!));
                                        }

                                        if (entreprenerurList[i].images!.length >= 3) {
                                          listOfImages.add(NetworkImage(
                                              AppConstant.imageBaseUrl + entreprenerurList[i].images![2].imageUrl!));
                                        }

                                        popupImages = listOfImages;

                                        displayImages();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: entreprenerurList[i].images!.length == 3
                                            ? AppConstant.imageBaseUrl + entreprenerurList[i].images![2].imageUrl!
                                            : "",
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => Image.asset(
                                          "assets/images/placeholderImage.jpg",
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    )
                                  : (entreprenerurList[i].images!.length == 3
                                      ? AssetThumb(
                                          asset: entreprenerurList[i].images![2].imageAsset,
                                          width: 114,
                                          height: 102,
                                        )
                                      : const SizedBox(
                                          width: 114,
                                          height: 102,
                                        )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }

    Widget _buildformBody() {
      return Column(
        children: personalTab
            ? [
                const SizedBox(height: 26),
                _buildMobileNumber(),
                _personalSecondaryNumber.text != "" ? const SizedBox(height: 16) : Container(),
                _personalSecondaryNumber.text != "" ? _buildSecondaryPhoneNumber() : Container(),
                const SizedBox(height: 16),
                _buildEmailId(),
                const SizedBox(height: 16),
                _buildDob(),
                const SizedBox(height: 16),
                _buildAddress(),
                const SizedBox(height: 16),
                _buildCity(),
                const SizedBox(height: 16),
                _buildState(),
                const SizedBox(height: 16),
                _buildCountry(),
                const SizedBox(height: 16),
                _buildPincode(),
                // SizedBox(height: 16),
                // _buildKeyword(),
                const SizedBox(height: 16),
                _buildLandLine(),
                const SizedBox(height: 30),
                _buildPersonalUpdateButton(),
                const SizedBox(height: 30),
              ]
            : [
                const SizedBox(height: 26),
                _buildOccupation(),
                Visibility(
                  visible: _companyVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _companyVisible,
                  child: _buildCompany(),
                ),
                Visibility(
                  visible: _companyWebsiteVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _companyWebsiteVisible,
                  child: _buildCompanyWebsite(),
                ),
                Visibility(
                  visible: _studentSchoolVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _studentSchoolVisible,
                  child: _buildProfessionalSchool(),
                ),
                Visibility(
                  visible: _studentGradeVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _studentGradeVisible,
                  child: _buildGrade(),
                ),
                Visibility(
                  visible: _companyWorkNatureVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _companyWorkNatureVisible,
                  child: _buildworknature(),
                ),
                Visibility(
                  visible: _designationVisible,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: _designationVisible,
                  child: _buildDesignation(),
                ),
                const SizedBox(height: 16),
                _buildworkFacebook(),
                const SizedBox(height: 16),
                _buildworkInstagram(),
                const SizedBox(height: 16),
                _buildworkTwitter(),
                const SizedBox(height: 16),
                _buildworkSkype(),
                const SizedBox(height: 16),
                Visibility(
                  visible: _enterpreneurForms,
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemCount: entreprenerurList.length,
                      itemBuilder: (BuildContext ctxt, int i) => entreprenerurItemNew(i),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          const SizedBox(height: 80),
          Text(_personalName.text ?? "Unknown Number", style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 22),
          Visibility(
            visible: _values.isNotEmpty,
            child: keywordbody(),
          ),
          const SizedBox(height: 16),
          selectButton(),
          _buildformBody(),
        ],
      );
    }

    Widget stackContainer() {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 100.0,
                color: AppColor.primaryColor,
              ),
              bodyContent()
            ],
          ),
          Positioned(
            top: 50.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/profile.png",
                      image: userImage != null ? AppConstant.profileImageBaseUrl + userImage : "",
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/profile.png",
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

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
          "Contact",
          style: Theme.of(context).textTheme.headline4!.apply(color: AppColor.whiteColor),
        ),
        actions: [
          TextButton(
            // style: ButtonStyle(
            //   backgroundColor: MaterialStateProperty.all<Color>(AppColor.primaryColor,

            //   ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              );
            },
            child: Text(
              "Edit",
              style: Theme.of(context).textTheme.bodyText1!.apply(color: AppColor.whiteColor),
            ),
          ),
        ],
      ),
      body: _loader
          ? LoadingOverlay(
              isLoading: _loaderoverflow,
              opacity: 0.3,
              progressIndicator: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: stackContainer(),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
            ),
    );
  }

  getProfileDetails(String phoneNumber) async {
    try {
      var requestBody = {
        "phone": phoneNumber,
      };
      var response = await ContactBloc().getProfileDetails(requestBody);

      if (response['status'] == true) {
        contactDetail = ContactDetail.fromJson(response["user"]);
        _loader = true;

        //Personal
        _personalName.text = contactDetail?.name ?? "";
        _personalNumber.text = contactDetail?.personal?.number ?? "";
        userImage = contactDetail?.profileImage ?? "";
        _personalEmail.text = contactDetail?.personal?.email ?? "";
        _personalDob.text = contactDetail?.personal?.dOB ?? "";
        _personalAddress.text = contactDetail?.personal?.address1 ?? "";
        _personalLandline.text =
            contactDetail?.personal?.landline == null ? '' : contactDetail?.personal?.landline.toString() ?? "";

        _personalCity.text = contactDetail?.personal?.city ?? "";
        _personalState.text = contactDetail?.personal?.state ?? "";
        _personalCountry.text = contactDetail?.personal?.country ?? "";
        _personalPincode.text = contactDetail?.personal?.pincode ?? "";
        // _personalKeyword.text = contactDetail.personal.keyword;

        _values = contactDetail?.personal?.keyword != null ? contactDetail!.personal!.keyword!.split(',') : [];

        if (contactDetail?.professional != null) {
          _occupationValue = contactDetail?.professional?.occupation ?? "";
          _professionalOccupation.text = contactDetail?.professional?.occupation ?? "";
          _professionalCompany.text = contactDetail?.professional?.company ?? "";
          _professionalCompanyWebsite.text = contactDetail?.professional?.companyWebsite ?? "";
          _professionalSchool.text = contactDetail?.professional?.schoolUniversity ?? "";
          _professionalWorkNature.text = contactDetail?.professional?.workNature ?? "";
          _professionalDesignation.text = contactDetail?.professional?.designation ?? "";
          _professionalGrade.text = contactDetail?.professional?.grade ?? "";

          entreprenerurListJson = contactDetail?.professionalList ?? [];

          for (var data in entreprenerurListJson) {
            List<ImageUploadModel> imageData = [];
            for (var businessImagesdata in data.businessImages!) {
              ImageUploadModel imageUpload = ImageUploadModel();
              imageUpload.id = businessImagesdata.id;
              imageUpload.professionalId = businessImagesdata.professionalId;
              imageUpload.isUploaded = true;
              imageUpload.imageUrl = businessImagesdata.image;
              imageData.add(imageUpload);
            }

            setState(() {
              var entrepreneureData = EntrepreneurData();
              entrepreneureData.id = data.id;
              entrepreneureData.company = data.company;
              entrepreneureData.website = data.companyWebsite;
              entrepreneureData.workNature = data.workNature;
              entrepreneureData.images = imageData;
              entreprenerurList.add(entrepreneureData);
            });
          }
          print("entreprenerurListJson : $entreprenerurList ");
          checkOccupation();
        }

        if (contactDetail?.social != null) {
          _socialFacebook.text = contactDetail?.social?.facebook ?? "";
          _socialInstagram.text = contactDetail?.social?.instagram ?? "";
          _socialTwitter.text = contactDetail?.social?.twitter ?? "";
          _socialGpay.text = contactDetail?.social?.gpay ?? "";
          _socialSkype.text = contactDetail?.social?.skype ?? "";
          _socialPaytm.text = contactDetail?.social?.paytm ?? "";
        }

        dynamic dat = contactDetail?.personal?.dOB ?? "";
        dat == null ? _personalDob.text : _personalDob.text = dat;
        if (dat != null) {
          print(dat);
          setState(() {
            selectedDate = DateFormat('dd-mm-yyyy').parse(dat);
          });
        } else {
          setState(() {
            selectedDate = DateTime.now();
          });
        }
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  checkOccupation() {
    print(_occupationValue);
    if (_occupationValue == 'Entrepreneur') {
      _enterpreneurForms = true;
      _companyVisible = false;
      _companyWebsiteVisible = false;
      // _companyIndustryVisible = false;
      _companyWorkNatureVisible = false;
      _studentSchoolVisible = false;
      _studentGradeVisible = false;
      _designationVisible = false;
    } else if (_occupationValue == 'Employed') {
      _enterpreneurForms = false;
      _companyVisible = true;
      _companyWebsiteVisible = true;
      // _companyIndustryVisible = true;
      _companyWorkNatureVisible = true;
      _studentSchoolVisible = false;
      _studentGradeVisible = false;
      _designationVisible = true;
    } else if (_occupationValue == 'Home maker') {
      _enterpreneurForms = false;
      _companyVisible = false;
      _companyWebsiteVisible = false;
      // _companyIndustryVisible = false;
      _companyWorkNatureVisible = false;
      _studentSchoolVisible = false;
      _studentGradeVisible = false;
      _designationVisible = false;
    } else if (_occupationValue == 'Student') {
      _enterpreneurForms = false;
      _companyVisible = false;
      _companyWebsiteVisible = false;
      // _companyIndustryVisible = false;
      _companyWorkNatureVisible = false;
      _studentSchoolVisible = true;
      _studentGradeVisible = true;
      _designationVisible = false;
    }
  }
}
