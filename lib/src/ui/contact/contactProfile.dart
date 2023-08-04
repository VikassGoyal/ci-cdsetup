import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:conet/api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/models/imageUploadModel.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/switchContactToggle.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api_models/getMutualsContacts__request_model/getMutualsContact_request_body.dart';
import '../../../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import '../utils.dart';

class ContactProfile extends StatefulWidget {
  final String? phoneNumber;
  final int? contactmetaid;
  final String? contactMetaType;
  final String? fromContactMetaType;
  final int? userid;

  const ContactProfile(
      this.phoneNumber, this.contactmetaid, this.contactMetaType, this.fromContactMetaType, this.userid,
      {super.key});

  @override
  State<ContactProfile> createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  @override
  initstate() {
    _updatepage = false;
  }

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
  List<ProfessionalList>? entreprenerurListJson = [];

  ContactDetail? contactDetail;
  String? _occupationValue;
  DateTime? selectedDate;
  bool _updatepage = false;
  var _mutualcontact = 0;

  bool _loader = false;
  bool _loaderoverflow = false;
  bool personalTab = true;
  bool? switchTypeStatus;
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfileDetails(widget.phoneNumber!);
      getMutualContacts(widget.userid);

      // getProfileDetails("9566664128");
    });

    // if (widget.personalAccess == 1) {
    //   personalTab = false;
    // }

    if (widget.contactMetaType == "professional") {
      switchTypeStatus = true;
    } else {
      switchTypeStatus = false;
    }

    print("switch $switchTypeStatus");

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
              "Keyword",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.apply(color: const Color.fromRGBO(135, 139, 149, 1)),
            ),
            buildChips(),
          ],
        ),
      );
    }

    Widget selectButton() {
      return Row(
        children: [
          SizedBox(width: 22.w),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(personalTab ? AppColor.accentColor : AppColor.whiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.accentColor, width: 1),
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
                style: TextStyle(
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: personalTab ? AppColor.whiteColor : AppColor.accentColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(personalTab ? AppColor.whiteColor : AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  side: const BorderSide(color: AppColor.secondaryColor, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                )),
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
                style: TextStyle(
                  fontFamily: kSfCompactDisplayFontFamily,
                  color: personalTab ? AppColor.secondaryColor : AppColor.whiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          SizedBox(width: 22.w),
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
    //       style: Theme.of(context)
    //           .textTheme
    //           .bodyText2
    //           ?.apply(color: AppColor.secondaryColor),
    //       decoration: InputDecoration(
    //         labelText: "Keyword",
    //         filled: true,
    //         fillColor: AppColor.whiteColor,
    //         focusedBorder: InputBorder.none,
    //         hintStyle: Theme.of(context).textTheme.bodyText2?.apply(
    //               color: Color(0xFF878B95),
    //             ),
    //         labelStyle: Theme.of(context).textTheme.headline6?.apply(
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
        margin: EdgeInsets.only(left: 22.w, right: 22.w),
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
            constraints: BoxConstraints(minHeight: 50.h),
            alignment: Alignment.center,
            child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kSfproRoundedFontFamily,
                color: AppColor.whiteColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
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
        padding: EdgeInsets.only(left: 25.w, right: 20.w, top: 30.h, bottom: 16.h),
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
                    style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.bottomUnselectItemColor),
                  ),
                ],
              ),
              Container(
                height: 48.h,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(232, 232, 232, 1)),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.h, bottom: 3.h),
                    labelText: "Company",
                    labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColor.placeholder),
                    filled: true,
                    enabled: false,
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
              SizedBox(height: 8.h),
              Container(
                height: 48.h,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(232, 232, 232, 1)),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                    labelText: "Website",
                    labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColor.placeholder),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: InputBorder.none,
                    enabled: false,
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
              SizedBox(height: 8.h),
              Container(
                height: 48.h,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(232, 232, 232, 1)),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.h, bottom: 3.h),
                    labelText: 'Work Nature',
                    labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColor.placeholder),
                    filled: true,
                    enabled: false,
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
              SizedBox(height: 8.h),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 2),
              //     child: Text(
              //       "Images",
              //       style: TextStyle(
              //         color: AppColor.secondaryColor,
              //         fontFamily: 'Segoe-Ui',
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Visibility(
                    visible: entreprenerurList[i].images!.asMap().containsKey(0),
                    child: Flexible(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 114.w,
                            height: 102.h,
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
                                          ))),
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
                                          ))),
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

    Widget _relationShip() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.circular(7),
        ),
        // height: 48,
        padding: const EdgeInsets.all(0),
        margin: EdgeInsets.only(left: 22.w, right: 22.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  labelText: "Relationship",
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.placeholder,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.placeholder,
                  ),
                ),
                readOnly: true,
                initialValue: "Switch",
                cursorColor: AppColor.secondaryColor,
                validator: (value) {
                  return null;
                },
              ),
            ),
            AnimatedToggle(
              values: const ['Personal', 'Professional'],
              onToggleCallback: (value) {
                print(value);

                setState(
                  () {
                    print(switchTypeStatus);
                    switchTypeStatus = !switchTypeStatus!;
                    _loaderoverflow = true;
                  },
                );
                updateTypeStatus();
              },
              buttonColor: AppColor.accentColor,
              backgroundColor: AppColor.placeholder,
              textColor: AppColor.whiteColor,
              value: switchTypeStatus,
            ),
          ],
        ),
      );
    }

    Widget _addressContainer() {
      return Column(children: [
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
      ]);
    }

    Widget _buildformBody() {
      return Column(
        children: personalTab
            ? [
                SizedBox(height: 26.h),
                _buildMobileNumber(),
                _personalSecondaryNumber.text != "" ? SizedBox(height: 16.h) : Container(),
                _personalSecondaryNumber.text != "" ? _buildSecondaryPhoneNumber() : Container(),
                SizedBox(height: 16.h),
                _buildEmailId(),
                _personalDob.text != "" ? SizedBox(height: 16.h) : Container(),
                _personalDob.text != "" ? _buildDob() : Container(),
                widget.fromContactMetaType == "personal" ? _addressContainer() : Container(),
                _personalLandline.text != "" ? SizedBox(height: 16.h) : Container(),
                _personalLandline.text != "" ? _buildLandLine() : Container(),
                widget.contactmetaid != null ? SizedBox(height: 16.h) : Container(),
                widget.contactmetaid != null ? _relationShip() : Container(),
                SizedBox(height: 30.h),
                _buildPersonalUpdateButton(),
                SizedBox(height: 30.h),
              ]
            : [
                SizedBox(height: 26.h),
                _buildOccupation(),
                Visibility(
                  visible: _companyVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _companyVisible,
                  child: _buildCompany(),
                ),
                Visibility(
                  visible: _companyWebsiteVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _companyWebsiteVisible,
                  child: _buildCompanyWebsite(),
                ),
                Visibility(
                  visible: _studentSchoolVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _studentSchoolVisible,
                  child: _buildProfessionalSchool(),
                ),
                Visibility(
                  visible: _studentGradeVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _studentGradeVisible,
                  child: _buildGrade(),
                ),
                Visibility(
                  visible: _companyWorkNatureVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _companyWorkNatureVisible,
                  child: _buildworknature(),
                ),
                Visibility(
                  visible: _designationVisible,
                  child: SizedBox(height: 16.h),
                ),
                Visibility(
                  visible: _designationVisible,
                  child: _buildDesignation(),
                ),
                SizedBox(height: 16.h),
                _buildworkFacebook(),
                SizedBox(height: 16.h),
                _buildworkInstagram(),
                SizedBox(height: 16.h),
                _buildworkTwitter(),
                SizedBox(height: 16.h),
                _buildworkSkype(),
                SizedBox(height: 16.h),
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
                SizedBox(height: 30.h),
              ],
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          SizedBox(height: 60.h),
          Text(_personalName.text ?? "Unknown Number",
              style: TextStyle(
                fontFamily: kSfproRoundedFontFamily,
                color: AppColor.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              )),
          SizedBox(
            height: 5.h,
          ),
          Text("$_mutualcontact Mutual Contacts" ?? "",
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 10.h),
          Visibility(
            visible: _values.isNotEmpty,
            child: keywordbody(),
          ),
          SizedBox(height: 15.h),
          selectButton(),
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber == null) {
                        return;
                      }
                      callChatMessenger(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_message.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber.text == '') {
                        return;
                      }
                      _callNumber(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_call.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      var whatsappnumber = _personalNumber.text;
                      whatsappnumber = whatsappnumber.replaceAll("-", "");
                      whatsappnumber = whatsappnumber.replaceAll(" ", "");

                      if (whatsappnumber.length == 10) {
                        whatsappnumber = "+91$whatsappnumber";
                      }

                      openwhatsapp(whatsappnumber);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_whatsapp.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalEmail.text == '') {
                        Utils.displayToast("Mail id not found");
                        return;
                      }

                      Uri emailLaunchUri =
                          Uri(scheme: 'mailto', path: _personalEmail.text, queryParameters: {'subject': null});
                      launch(emailLaunchUri.toString());
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_mail.svg",
                      height: 56.h,
                      width: 80.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _buildformBody(),
        ],
      );
    }

    Widget stackContainer() {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 100.h,
              color: AppColor.primaryColor,
            ),
            bodyContent()
          ],
        ),
        Positioned(
          top: 50.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/profile.png",
                    image: userImage != null
                        ? AppConstant.profileImageBaseUrl + userImage
                        : "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      print("error");
                      print(error);
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
      ]);
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        leadingWidth: 80.w,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(_updatepage);
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
        title: Text(
          "Contact",
          style: TextStyle(
            fontFamily: kSfproDisplayFontFamily,
            color: AppColor.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
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

  _callNumber(String phone) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phone);
    } catch (e) {
      print(e);
    }
  }

  callChatMessenger(phoneNumber) async {
    var uri = 'sms:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      var uri = 'sms:$phoneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  getMutualContacts(int? userid) async {
    if (userid == null) return;
    print("contactmetaid");
    print(userid);
    try {
      var response = await ContactBloc().getMutualContacts(GetMutualsContactRequestBody(to_id: widget.userid));
      if (response["status"]) {
        print("response");
        // _mutualcontact = response['data'].length;
        print(response["data"].length);

        setState(() {
          _mutualcontact = response["data"].length;
          print(_mutualcontact);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getProfileDetails(String phoneNumber) async {
    try {
      // var requestBody = {
      //   "phone": phoneNumber,
      // };
      var response = await ContactBloc().getProfileDetails(GetProfileDetailsRequestBody(phone: phoneNumber));

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
        _personalKeyword.text = contactDetail?.personal?.keyword ?? "";

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

          entreprenerurListJson = contactDetail?.professionalList;

          for (var data in entreprenerurListJson!) {
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
          // _socialInstagram.text = contactDetail?.social?.instagram ?? "";
          _socialTwitter.text = contactDetail?.social?.twitter ?? "";
          // _socialInstagram.text = contactDetail?.social?.instagram ?? "";
          _socialGpay.text = contactDetail?.social?.gpay ?? "";
          _socialSkype.text = contactDetail?.social?.skype ?? "";
          _socialPaytm.text = contactDetail?.social?.paytm ?? "";
        }

        dynamic dat = contactDetail?.personal?.dOB;
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

  updateTypeStatus() async {
    var typeStatus = switchTypeStatus! ? "professional" : "personal";
    print(typeStatus);

    try {
      // var requestBody = {
      //   "id": widget.contactmetaid,
      //   "type": typeStatus,
      // };

      var response =
          await ContactBloc().updateTypeStatus(UpdateTypeStatusRequestBody(id: widget.contactmetaid, type: typeStatus));

      setState(() {
        _loaderoverflow = false;
      });
      Utils.displayToast(response["message"]);
      // if (response['status'] == true) {}
    } catch (e) {
      print(e);
    }
  }

  openwhatsapp(whatsapp) async {
    // var whatsapp = "+919566664128";
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp;
    var whatappURLIos = "https://wa.me/$whatsapp";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        Utils.displayToast("whatsapp no installed");
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        Utils.displayToast("whatsapp no installed");
      }
    }
  }
}
