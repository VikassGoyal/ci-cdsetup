import 'dart:convert';
import 'dart:typed_data';
import 'package:conet/src/ui/settings/myprofile.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/models/entrepreneureRequest.dart';
import 'package:conet/models/imageUploadModel.dart';
import 'package:conet/models/imageUploadRequest.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/custom_fonts.dart';
import '../settings/myprofile.dart';
import '../utils.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool professionalTab = true;

  bool _enterpreneurForms = false;
  bool _companyVisible = false;
  bool _companyWebsiteVisible = false;
  // bool _companyIndustryVisible = false;
  bool _companyWorkNatureVisible = false;
  bool _studentSchoolVisible = false;
  bool _studentGradeVisible = false;
  bool _designationVisible = false;

  ContactDetail? contactDetail;
  DateTime? selectedDate;
  String? _occupationValue;
  bool _loaderoverflow = true;
  bool _valuesChanged = false;
  bool _loader = true;

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
  List<EntrepreneurDataRequest> entreprenerurListResquest = [];
  List<ProfessionalList>? entreprenerurListJson = [];

  List<Asset> profileImage = <Asset>[];
  String uploadedProfileImage = '';
  String userImage = '';

  //Address
  Position? _currentPosition;
  final Geolocator geolocator = Geolocator();

  final TextEditingController _textEditingController = TextEditingController();
  List<String>? _values = [];
  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();

    Future.delayed(Duration.zero, () {
      getProfileDetails();
    });
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

  @override
  Widget build(BuildContext context) {
    Widget selectButton() {
      return Row(
        children: [
          SizedBox(width: 22.w),
          Container(
            height: 37.h,
            width: 158.w,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(professionalTab ? AppColor.accentColor : AppColor.whiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: professionalTab ? AppColor.accentColor : AppColor.secondaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  professionalTab = true;
                });
              },
              child: Text(
                'Personal',
                style: TextStyle(
                    color: professionalTab ? AppColor.whiteColor : AppColor.secondaryColor,
                    fontSize: 15.sp,
                    fontFamily: kSfCompactDisplayFontFamily,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            height: 37.h,
            width: 158.w,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(professionalTab ? AppColor.whiteColor : AppColor.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
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
                    professionalTab = false;
                  },
                );
              },
              child: Text(
                'Professional',
                style: TextStyle(
                    color: professionalTab ? AppColor.secondaryColor : AppColor.whiteColor,
                    fontSize: 15.sp,
                    fontFamily: kSfCompactDisplayFontFamily,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 22.w),
        ],
      );
    }

    Widget _buildName() {
      return TextFormFieldContact(
        hintText: "Name",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalName,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildPhoneNumber() {
      return TextFormFieldContact(
        hintText: "Phone number",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalNumber,
        readonly: true,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildSecondaryPhoneNumber() {
      return TextFormFieldContact(
        hintText: "Secondary Phone Number",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        enable: true,
        readonly: false,
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
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalEmail,
        readonly: true,
        parametersValidate: "Please enter Email.",
      );
    }

    Widget _buildDob() {
      return Container(
        height: 48.h,
        width: 331.w,
        margin: EdgeInsets.only(left: 22.0.w, right: 22.0.w),
        padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              _valuesChanged = true;
            });
          },
          style: TextStyle(
              fontSize: 15.sp,
              fontFamily: kSfproRoundedFontFamily,
              fontWeight: FontWeight.w300,
              color: AppColor.secondaryColor),
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 6.0, bottom: 3.0),
            labelText: "DOB",
            hintStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
            labelStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
            filled: true,
            fillColor: AppColor.whiteColor,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _selectDate(context);
                _valuesChanged = true;
              },
              child: Icon(
                Icons.date_range,
                color: Color(0xFF878B95),
              ),
            ),
            focusedBorder: InputBorder.none,
          ),
          cursorColor: AppColor.secondaryColor,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: _personalDob,
        ),
      );
    }

    Widget _buildAddress() {
      return Container(
        height: 48.h,
        width: 331.w,
        padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
        margin: EdgeInsets.only(
          left: 22.0.w,
          right: 22.0.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFE8E8E8),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              _valuesChanged = true;
            });
          },
          style: TextStyle(
              fontSize: 15.sp,
              fontFamily: kSfproRoundedFontFamily,
              fontWeight: FontWeight.w300,
              color: AppColor.secondaryColor),
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Address",
            contentPadding: EdgeInsets.only(top: 6.0.h, bottom: 3.0.h),
            hintStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
            labelStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
            filled: true,
            fillColor: AppColor.whiteColor,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                getCurrentLocation();
                setState(() {
                  _valuesChanged = true;
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GoogleMapForLocation(),
                //   ),
                // );
              },
              child: Image.asset(
                "assets/icons/googlemap.png",
                height: 16,
                width: 16,
              ),
            ),
          ),
          cursorColor: AppColor.secondaryColor,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          controller: _personalAddress,
          validator: (value) {
            return null;
          },
        ),
      );
    }

    Widget _buildCountry() {
      return TextFormFieldContact(
        hintText: "Country",
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        controller: _personalCountry,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildState() {
      return TextFormFieldContact(
        hintText: "State",
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        controller: _personalState,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildCity() {
      return TextFormFieldContact(
        hintText: "City",
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        controller: _personalCity,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildPincode() {
      return TextFormFieldContact(
        hintText: "Pincode",
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.phone,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        controller: _personalPincode,
        parametersValidate: "Please enter Address.",
      );
    }

    Widget _buildKeyword() {
      return Container(
        margin: EdgeInsets.only(left: 22.0.w, right: 22.0.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextFormField(
          style: TextStyle(
              fontSize: 15.sp,
              fontFamily: kSfproRoundedFontFamily,
              fontWeight: FontWeight.w300,
              color: AppColor.secondaryColor),
          decoration: InputDecoration(
            labelText: "Keyword",
            filled: true,
            fillColor: AppColor.whiteColor,
            focusedBorder: InputBorder.none,
            hintStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
            labelStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w300,
                color: AppColor.placeholder),
          ),
          cursorColor: AppColor.secondaryColor,
          validator: (value) {
            return null;
          },
          controller: _personalKeyword,
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 5,
        ),
      );
    }

    Widget _buildLandLine() {
      return TextFormFieldContact(
        hintText: "Landline Number",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        textInputType: TextInputType.number,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalLandline,
        parametersValidate: "Please enter Landline Number.",
      );
    }

    Widget _buildPersonalUpdateButton() {
      return Container(
        margin: EdgeInsets.only(left: 22, right: 22),
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
                professionalTab = false;
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 50.0.h,
            ),
            alignment: Alignment.center,
            child: Text("Next",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
    }

    //Professional
    Widget _buildProfessionlUpdateButton() {
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
            updateProfile();
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 50.0.h,
            ),
            alignment: Alignment.center,
            child: Text("Update",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
    }

    Widget _buildOccupation() {
      return Container(
        height: 48.h,
        width: 331.w,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: EdgeInsets.only(left: 22.w, right: 22.w),
        child: DropdownButtonFormField(
          style: TextStyle(color: AppColor.secondaryColor, fontSize: 13.sp),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF878B95),
          ),
          dropdownColor: AppColor.whiteColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(18, 0, 0, 0),
            filled: true,
            fillColor: AppColor.whiteColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1),
            ),
          ),
          value: _occupationValue,
          items: [
            DropdownMenuItem<String>(
              value: 'Entrepreneur',
              child: Text('Entrepreneur'),
            ),
            DropdownMenuItem<String>(
              value: 'Employed',
              child: Text('Employed'),
            ),
            DropdownMenuItem<String>(
              value: 'Home maker',
              child: Text('Home maker'),
            ),
            DropdownMenuItem<String>(
              value: 'Student',
              child: Text('Student'),
            ),
          ],
          hint: Text(
            'Select Occupation',
            style: TextStyle(
              fontSize: 13,
              color: Color(
                0xFF878B95,
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              // _valuesChanged = true;
              _occupationValue = value as String?;
              _professionalOccupation.text = value.toString();

              print(_occupationValue);
              if (value == 'Entrepreneur') {
                _enterpreneurForms = true;
                _companyVisible = false;
                _companyWebsiteVisible = false;
                // _companyIndustryVisible = false;
                _companyWorkNatureVisible = false;
                _studentSchoolVisible = false;
                _studentGradeVisible = false;
                _designationVisible = false;
              } else if (value == 'Employed') {
                _enterpreneurForms = false;
                _companyVisible = true;
                _companyWebsiteVisible = true;
                // _companyIndustryVisible = true;
                _companyWorkNatureVisible = true;
                _studentSchoolVisible = false;
                _studentGradeVisible = false;
                _designationVisible = true;
              } else if (value == 'Home maker') {
                _enterpreneurForms = false;
                _companyVisible = false;
                _companyWebsiteVisible = false;
                // _companyIndustryVisible = false;
                _companyWorkNatureVisible = false;
                _studentSchoolVisible = false;
                _studentGradeVisible = false;
                _designationVisible = false;
              } else if (value == 'Student') {
                _enterpreneurForms = false;
                _companyVisible = false;
                _companyWebsiteVisible = false;
                // _companyIndustryVisible = false;
                _companyWorkNatureVisible = false;
                _studentSchoolVisible = true;
                _studentGradeVisible = true;
                _designationVisible = false;
              }
            });
          },
        ),
      );
    }

    Widget _buildCompany() {
      return TextFormFieldContact(
        hintText: "Company",
        padding: 14.0,
        margin: 22.0,
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
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
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
        maxLength: 100,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _professionalSchool,
        regexexp: RegExp(r'^[a-zA-Z0-9\s.,]+$'),
        parametersValidate: "Please enter School / University.",
      );
    }

    Widget _buildGrade() {
      return TextFormFieldContact(
        hintText: "Grade",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
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
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
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
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _professionalDesignation,
        parametersValidate: "Please enter Designation.",
      );
    }

    Widget _buildworkFacebook() {
      return TextFormFieldContact(
        hintText: "Facebook account",
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        padding: 14.0,
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialFacebook,
        parametersValidate: "Please enter Facebook.",
      );
    }

    Widget _buildworkInstagram() {
      return TextFormFieldContact(
        hintText: "Instagram account",
        padding: 14.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        margin: 22.0,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialInstagram,
        parametersValidate: "Please enter Instagram.",
      );
    }

    Widget _buildworkTwitter() {
      return TextFormFieldContact(
        hintText: "Twitter account",
        padding: 14.0,
        margin: 22.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialTwitter,
        parametersValidate: "Please enter Twitter.",
      );
    }

    Widget _buildworkSkype() {
      return TextFormFieldContact(
        hintText: "Skype account",
        padding: 14.0,
        margin: 22.0,
        onChanged: (value) {
          setState(() {
            _valuesChanged = true;
          });
        },
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        controller: _socialSkype,
        parametersValidate: "Please enter Skype.",
      );
    }

    Widget buildChips() {
      List<Widget> chips = [];

      for (int i = 0; i < _values!.length; i++) {
        InputChip actionChip = InputChip(
          selectedColor: AppColor.primaryColor,
          shadowColor: AppColor.primaryColor,
          backgroundColor: AppColor.primaryColor,
          label: Text(_values![i]),
          pressElevation: 5,
          onPressed: () {
            // setState(() {
            //   _selected[i] = !_selected[i];
            // });
          },
          onDeleted: () {
            // _selected.removeAt(i);
            setState(() {
              _values!.removeAt(i);
              _values = _values;
              _selected = _selected;
            });
          },
        );
        chips.add(actionChip);
      }

      return Padding(
        padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 10.h),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 7.0,
          runSpacing: 6.0,
          children: chips,
        ),
      );
    }

    Widget _buildformBody() {
      return Column(
        children: professionalTab
            ? [
                SizedBox(height: 10.h),
                _buildName(),
                SizedBox(height: 16.h),
                _buildPhoneNumber(),
                SizedBox(height: 16.h),
                _buildSecondaryPhoneNumber(),
                SizedBox(height: 16.h),
                _buildEmailId(),
                SizedBox(height: 16.h),
                _buildDob(),
                SizedBox(height: 16.h),
                _buildAddress(),
                SizedBox(height: 16.h),
                _buildCity(),
                SizedBox(height: 16.h),
                _buildState(),
                SizedBox(height: 16.h),
                _buildCountry(),
                SizedBox(height: 16.h),
                _buildPincode(),
                SizedBox(height: 16.h),
                _buildLandLine(),
                SizedBox(height: 30.h),
                _buildPersonalUpdateButton(),
                SizedBox(height: 30.h),
              ]
            : [
                SizedBox(height: 10.h),
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
                //SizedBox(height: 16.h),
                //_buildKeyword(),
                //SizedBox(height: 16.h),
                SingleChildScrollView(child: buildChips()),
                Container(
                  height: 48.h,
                  width: 331.w,
                  padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w, top: 14.h),
                  margin: EdgeInsets.only(top: 20.h, left: 22.0.w, right: 22.0.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(232, 232, 232, 1),
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    maxLength: 10,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColor.secondaryColor),
                    controller: _textEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 6.0.w, bottom: 3.0.w),
                      hintText: "Keyword",
                      hintStyle: TextStyle(
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
                      suffixIcon: IconButton(
                        iconSize: 50.w,
                        icon: Image.asset(
                          "assets/icons/rightarrow.png",
                          height: 40.w,
                          width: 40.w,
                        ),
                        onPressed: () {
                          if (_textEditingController.text.isEmpty) {
                            Utils.displayToastBottomError("Keyword cannot be empty");
                            return;
                          }

                          if (_values.toString().toLowerCase().contains(_textEditingController.text.toLowerCase())) {
                            Utils.displayToastBottomError("Keyword already added");
                            _textEditingController.clear();
                            return;
                          }
                          if (_values!.length <= 10) {
                            _values!.add(_textEditingController.text);
                            _selected.add(true);
                            _textEditingController.clear();

                            setState(() {
                              _values = _values;
                              _selected = _selected;
                            });
                          } else {
                            Utils.displayToast("You are limited to 10 keywords");
                          }
                        },
                      ),
                    ),
                    cursorColor: AppColor.secondaryColor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        _valuesChanged = true;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40.h),
                Visibility(
                  visible: _enterpreneurForms,
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Company Details",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: kSfproRoundedFontFamily,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300)),
                        Container(
                          width: 32.w,
                          height: 32.h,
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            backgroundColor: AppColor.secondaryColor,
                            onPressed: onAddForm,
                            child: Icon(
                              Icons.add,
                              size: 18.h,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _enterpreneurForms,
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemCount: entreprenerurList.length,
                      // itemCount: 1 ,
                      itemBuilder: (BuildContext ctxt, int i) => entreprenerurItemNew(i),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _buildProfessionlUpdateButton(),
                SizedBox(height: 30.h),
              ],
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          SizedBox(height: 80.h),
          selectButton(),
          SizedBox(
            height: 20.h,
          ),
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
                height: 56.h,
                color: AppColor.primaryColor,
              ),
              bodyContent()
            ],
          ),
          Positioned(
            top: -4.0,
            child: GestureDetector(
              onTap: loadProfileImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/profile.png",
                        image: userImage != "" ? AppConstant.profileImageBaseUrl + userImage : "",
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/profile.png",
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 19.w,
                      width: 19.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondaryColor,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 12.w,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        leadingWidth: 80.w,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            if (_valuesChanged) {
              showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0.w))),
                      backgroundColor: Colors.white,
                      title: Center(
                        child: Text(
                          "Changes not saved",
                          style: TextStyle(
                              color: Color(0xff3F3D56),
                              fontFamily: kSfproDisplayFontFamily,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      content: Text("Are you sure  want to Exit without Saving ?",
                          style: TextStyle(
                              color: Color(0xff878B95),
                              fontFamily: kSfproRoundedFontFamily,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300)),
                      actions: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(minWidth: 110.w, minHeight: 42.h),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      )),
                                  child: Text("Yes",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: kSfproRoundedFontFamily,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () {
                                    setState(() {
                                      _valuesChanged = false;
                                    });
                                    Navigator.of(dialogContext, rootNavigator: true).pop('dialog');
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: 110.w, minHeight: 42.h),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                      )),
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: kSfproRoundedFontFamily,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () {
                                    Navigator.of(dialogContext, rootNavigator: true).pop('dialog');
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  });
            } else {
              Navigator.pop(context);
            }
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
        title: Text("Edit Profile",
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: AppColor.whiteColor)),
      ),
      body: _loader
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
            )
          : LoadingOverlay(
              isLoading: _loaderoverflow,
              opacity: 0.3,
              progressIndicator: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: stackContainer(),
                ),
              ),
            ),
    );
  }

  getProfileDetails() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var phone = preferences.getString("phone");
      var requestBody = {
        "phone": phone,
      };
      var response = await ContactBloc().getProfileDetails(requestBody);

      setState(() {
        _loader = false;
        _loaderoverflow = false;
      });

      if (response['status'] == true) {
        contactDetail = ContactDetail.fromJson(response["user"]);
        print(contactDetail?.profileImage);

        //Personal

        _personalName.text = contactDetail?.name ?? "";
        _personalNumber.text = contactDetail?.personal?.number ?? "";
        _personalEmail.text = contactDetail?.personal?.email ?? "";
        userImage = contactDetail?.profileImage ?? "";
        // userImage = "https://wallpapercave.com/wp/wp5576997.jpg" ?? "";
        _personalDob.text = contactDetail?.personal?.dOB ?? "";
        _personalAddress.text = contactDetail?.personal?.address1 ?? "";

        _personalCity.text = contactDetail?.personal?.city ?? "";
        _personalState.text = contactDetail?.personal?.state ?? "";
        _personalCountry.text = contactDetail?.personal?.country ?? "";
        _personalPincode.text = contactDetail?.personal?.pincode ?? "";

        // _personalKeyword.text = contactDetail?.personal?.keyword ?? "";
        _values = contactDetail?.personal?.keyword?.split(',') ?? [];
        // _selected = contactDetail?.personal?.keyword.split(',') ?? "";

        _personalLandline.text =
            contactDetail?.personal?.landline == null ? '' : contactDetail?.personal?.landline.toString() ?? "";

        if (contactDetail?.professional != null) {
          print(contactDetail?.professional?.occupation);
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
            print("data");
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

          print("entreprenerurList : ${entreprenerurList.length}");
          checkOccupation();
        }

        if (contactDetail!.social != null) {
          _socialFacebook.text = contactDetail!.social!.facebook ?? "";
          _socialInstagram.text = contactDetail!.social!.instagram ?? "";
          _socialSkype.text = contactDetail!.social!.skype ?? "";
          _socialTwitter.text = contactDetail!.social!.twitter ?? "";
          _socialGpay.text = contactDetail!.social!.gpay ?? "";
          _socialPaytm.text = contactDetail!.social!.paytm ?? "";
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

  entreprenerurItemNew(int i) {
    return Padding(
      // padding: EdgeInsets.all(16),
      padding: EdgeInsets.only(left: 25.0.w, right: 20.w, top: 30.h, bottom: 16),
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
                Text("Company Profile ${i + 1}",
                    style: TextStyle(
                        color: AppColor.Companyprofilenumber,
                        fontSize: 15.sp,
                        fontFamily: kSfCompactDisplayFontFamily,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600)),
                Container(
                  width: 32.w,
                  height: 32.w,
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    heroTag: null,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    backgroundColor: AppColor.removeIconColor,
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColor.whiteColor,
                    ),
                    onPressed: () {
                      removeCompanyProfile(i);
                    },
                  ),
                )
              ],
            ),
            Container(
              height: 48.h,
              width: 331.w,
              padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
              margin: EdgeInsets.only(top: 20.h, left: 5.0.w, right: 5.0.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 6.0.h, bottom: 3.0.h),
                  labelText: "Company",
                  hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.placeholder),
                  labelStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.placeholder),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: OutlineInputBorder(
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
            SizedBox(height: 10.h),
            Container(
              height: 48.h,
              width: 331.w,
              padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
              margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 6.0, bottom: 3.0),
                  labelText: "Website",
                  labelStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.placeholder),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: OutlineInputBorder(
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
            SizedBox(height: 10.h),
            Container(
              height: 48.h,
              width: 331.w,
              padding: EdgeInsets.only(left: 14.0.w, right: 14.w),
              margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 6.0, bottom: 3.0),
                  labelText: 'Work Nature',
                  labelStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.placeholder),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: OutlineInputBorder(
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
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(
                  "Add Images",
                  style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 14.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Visibility(
                  visible: !entreprenerurList[i].images!.asMap().containsKey(2),
                  child: InkWell(
                    onTap: () {
                      loadImages(i);
                    },
                    child: Container(
                      height: 88.h,
                      width: 100.w,
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.secondaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/icons/upload_image.svg",
                        height: 24.h,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: entreprenerurList[i].images!.asMap().containsKey(0),
                  child: Flexible(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: 114.w,
                          height: 102.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: (entreprenerurList[i].images!.isNotEmpty
                                    ? entreprenerurList[i].images![0].isUploaded!
                                    : false)
                                ? CachedNetworkImage(
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
                                  )
                                : (entreprenerurList[i].images!.isNotEmpty
                                    ? AssetThumb(
                                        asset: entreprenerurList[i].images![0].imageAsset,
                                        width: 114,
                                        height: 102,
                                      )
                                    : SizedBox(
                                        width: 114.w,
                                        height: 102.h,
                                      )),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              removeImageFromCompanyProfile(i, 0);
                            },
                            child: Container(
                              height: 18.w,
                              width: 18.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColor.removeIconColor,
                              ),
                              //child: IconButton(
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15.w,
                                ),
                              ),
                              // onPressed: () {
                              //   removeImageFromCompanyProfile(i, 0);
                              // },
                              // ),
                            ),
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
                          padding: EdgeInsets.all(8),
                          width: 114.w,
                          height: 102.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (entreprenerurList[i].images!.length >= 2
                                      ? entreprenerurList[i].images![1].isUploaded!
                                      : false)
                                  ? CachedNetworkImage(
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
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                  : (entreprenerurList[i].images!.length >= 2
                                      ? AssetThumb(
                                          asset: entreprenerurList[i].images![1].imageAsset,
                                          width: 114,
                                          height: 102,
                                        )
                                      : SizedBox(
                                          width: 114.w,
                                          height: 102.h,
                                        ))),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              removeImageFromCompanyProfile(i, 1);
                            },
                            child: Container(
                              height: 18.w,
                              width: 18.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColor.removeIconColor,
                              ),
                              //child: IconButton(
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15.w,
                                ),
                              ),
                              // onPressed: () {
                              //   removeImageFromCompanyProfile(i, 0);
                              // },
                              // ),
                            ),
                          ),
                        )
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
                          padding: EdgeInsets.all(8),
                          width: 114.w,
                          height: 102.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (entreprenerurList[i].images!.length == 3
                                      ? entreprenerurList[i].images![2].isUploaded!
                                      : false)
                                  ? CachedNetworkImage(
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
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                  : (entreprenerurList[i].images!.length == 3
                                      ? AssetThumb(
                                          asset: entreprenerurList[i].images![2].imageAsset,
                                          width: 114,
                                          height: 102,
                                        )
                                      : SizedBox(
                                          width: 114.w,
                                          height: 102.h,
                                        ))),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              removeImageFromCompanyProfile(i, 2);
                            },
                            child: Container(
                              height: 18.w,
                              width: 18.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColor.removeIconColor,
                              ),
                              //child: IconButton(
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15.w,
                                ),
                              ),
                              // onPressed: () {
                              //   removeImageFromCompanyProfile(i, 0);
                              // },
                              // ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  entreprenerurItem(int i) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        color: AppColor.whiteColor,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  removeCompanyProfile(i);
                },
                icon: Icon(Icons.close),
                color: AppColor.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                    hintText: "Company",
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    hintStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: kSfproRoundedFontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColor.placeholder)),
                cursorColor: AppColor.secondaryColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                initialValue: entreprenerurList[i].company,
                onChanged: (value) {
                  setState(() {
                    entreprenerurList[i].company = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  hintText: "Website",
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: kSfproRoundedFontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColor.placeholder),
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
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontWeight: FontWeight.w300,
                    color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  hintText: 'Work Nature',
                  filled: true,
                  fillColor: Color(0xFFF6F6F6),
                  hintStyle: Theme.of(context).textTheme.bodyText2?.apply(color: Color(0xFF878B95)),
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
            Container(
              margin: EdgeInsets.only(right: 16.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black45),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColor.accentColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        loadImages(i);
                      },
                      child: Text(
                        "Add pictures",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                          fontFamily: kSfproRoundedFontFamily,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      entreprenerurList[i].images!.isEmpty
                          ? ''
                          : '(Added Image ${entreprenerurList[i].images!.length})',
                      style: TextStyle(
                        color: AppColor.gray30Color,
                        fontSize: 10.sp,
                        fontFamily: kSfproDisplayFontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  ///on form user deleted
  void removeCompanyProfile(int i) {
    setState(() {
      entreprenerurList.removeAt(i);
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var entrepreneureData = EntrepreneurData();
      entrepreneureData.company = "";
      entrepreneureData.website = "";
      entrepreneureData.workNature = "";
      entrepreneureData.images = [];
      entreprenerurList.insert(entreprenerurList.length, entrepreneureData);
    });
  }

  ///on form user deleted
  void removeImageFromCompanyProfile(int entreprenerurItem, int imageItem) {
    setState(() {
      entreprenerurList[entreprenerurItem].images!.removeAt(imageItem);
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: AppColor.primaryColor,
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.primaryColor)),
          child: child!,
        );
      },
    );
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dynamic d = formatDate(selectedDate!, [dd, '-', mm, '-', yyyy]);
        _personalDob.text = d.toString();
      });
    }
  }

  updateProfile() async {
    setState(() {
      if (_occupationValue == 'Entrepreneur') {
        _professionalCompany.clear();
        _professionalCompanyWebsite.clear();
        _professionalWorkNature.clear();
        _professionalSchool.clear();
        _professionalGrade.clear();
        _professionalDesignation.clear();
      } else if (_occupationValue == 'Employed') {
        entreprenerurList = [];
        _professionalSchool.clear();
        _professionalGrade.clear();
        _designationVisible = true;
      } else if (_occupationValue == 'Home maker') {
        entreprenerurList = [];
        _professionalCompany.clear();
        _professionalCompanyWebsite.clear();
        _professionalWorkNature.clear();
        _professionalSchool.clear();
        _professionalGrade.clear();
        _professionalDesignation.clear();
      } else if (_occupationValue == 'Student') {
        entreprenerurList = [];
        _professionalCompany.clear();
        _professionalCompanyWebsite.clear();
        _professionalWorkNature.clear();
        _professionalDesignation.clear();
      }
    });

    entreprenerurListResquest = [];

    for (var val in entreprenerurList) {
      EntrepreneurDataRequest entreprenerurResquest = EntrepreneurDataRequest();

      entreprenerurResquest.id = val.id;
      entreprenerurResquest.company = val.company;
      entreprenerurResquest.website = val.website;
      entreprenerurResquest.workNature = val.workNature;
      entreprenerurResquest.images = [];

      for (var element in val.images!) {
        ImageUploadRequest imageUpload = ImageUploadRequest();
        imageUpload.isUploaded = element.isUploaded;
        imageUpload.base64data = element.base64data != null ? "data:image/jpeg;base64,${element.base64data}" : null;
        imageUpload.imageUrl = element.imageUrl;
        entreprenerurResquest.images!.add(imageUpload);
      }
      entreprenerurListResquest.add(entreprenerurResquest);
    }

    var requestBody = {
      "per_name": _personalName.text,
      "per_num": _personalNumber.text,
      "per_email": _personalEmail.text,
      "per_dob": _personalDob.text,
      "per_add": _personalAddress.text,
      "per_city": _personalCity.text,
      "per_state": _personalState.text,
      "per_country": _personalCountry.text,
      "per_pincode": _personalPincode.text,
      "per_lan": _personalLandline.text == null ? '' : _personalLandline.text,
      "per_keyword": _values!.join(', '),
      "pro_occ": _professionalOccupation.text,
      "pro_ind": _professionalIndustry.text,
      "pro_com": _professionalCompany.text,
      "pro_com_website": _professionalCompanyWebsite.text,
      "pro_wn": _professionalWorkNature.text,
      "pro_des": _professionalDesignation.text,
      "pro_sch": _professionalSchool.text,
      "pro_gra": _professionalGrade.text,
      "fb": _socialFacebook.text,
      "in": _socialInstagram.text,
      "tt": _socialTwitter.text,
      "sk": _socialSkype.text,
      // "gp": _socialFacebook.text,
      // "pt": _socialFacebook.text,
      "entreprenerur_list": (entreprenerurListResquest.map((e) => e.toJson()).toList()),
    };

    setState(() {
      _loaderoverflow = true;
    });
    var response = await ContactBloc().updateProfileDetails(requestBody);

    setState(() {
      _loaderoverflow = false;
    });
    print("response");
    print(response);
    if (response['status'] == true) {
      Utils.displayToast(response['message'].toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyProfile(requestBody['per_num'] as String?),
        ),
      );
    } else if (response['status'] == "Token is Expired") {
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong');
    }
  }

  Future<void> loadImages(int index) async {
    List<Asset> images = <Asset>[];
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#FF931E",
          statusBarColor: "#FF931E",
          actionBarTitle: "Company Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#0087FB",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    List<Asset> assets = resultList;
    // entreprenerurList[index].images = [];

    for (Asset asset in assets) {
      var bytes = await asset.getByteData();
      var buffer = bytes.buffer;
      var base64data = base64.encode(Uint8List.view(buffer));

      setState(() {
        ImageUploadModel imageUpload = ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.imageAsset = asset;
        imageUpload.base64data = "data:image/jpeg;base64,$base64data";
        entreprenerurList[index].images!.add(imageUpload);
      });
    }
  }

  Future<void> loadProfileImage() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: profileImage,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FF931E",
          statusBarColor: "#FF931E",
          actionBarTitle: "Profile Image",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#FF931E",
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
      if (i == 1) {
        uploadedProfileImage = base64data;
        uploadeProfileImage();
      }
      setState(() {});
    }
    if (!mounted) return;
  }

  void uploadeProfileImage() async {
    var jsonData = {
      "base64data_profile": "data:image/png;base64,$uploadedProfileImage",
    };

    setState(() {
      _loaderoverflow = true;
    });

    var response = await ContactBloc().updateProfileImage(jsonData);
    print(response);
    setState(() {
      _loaderoverflow = false;
    });

    if (response['status'] == true) {
      Utils.displayToast(response['message']);
      getProfileDetails();
    } else {
      Utils.displayToast("Try Again!");
    }
  }

  getCurrentLocation() async {
    setState(() {
      _loaderoverflow = true;
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      setState(() {
        _loaderoverflow = false;
      });
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      Placemark? place = p[0];
      setState(() {
        _personalAddress.text = "${place.street},${place.thoroughfare}";
        _personalCity.text = place.locality!;
        _personalState.text = place.administrativeArea!;
        _personalCountry.text = place.country!;
        _personalPincode.text = place.postalCode!;
      });
      setState(() {
        _loaderoverflow = false;
      });
    } catch (e) {
      setState(() {
        _loaderoverflow = false;
      });
      print(e);
    }
  }
}
