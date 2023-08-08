import 'dart:convert';

import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/gtm_constants.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gtm/gtm.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_models/addNewContact_request_model/addNewContact_request_body.dart';
import '../../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../utils.dart';

class AddContact extends StatefulWidget {
  final String? phoneNumber;
  const AddContact({super.key, this.phoneNumber});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _checkContactKey = GlobalKey<FormState>();
  bool professionalTab = true;

  bool _designationVisible = false;
  bool switchTypeStatus = true;
  bool? _conetUser;
  String userImage = '';

  ContactDetail contactDetail = ContactDetail();
  DateTime? selectedDate;
  String? _occupationValue;

  final _personalName = TextEditingController();
  final _personalNumber = TextEditingController();
  final _personalEmail = TextEditingController();
  final _personalDob = TextEditingController();
  final _personalAddress = TextEditingController();
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

  List<EntrepreneurData> entreprenerurList = [];
  List<ProfessionalList>? entreprenerurListJson = [];
  bool _loader = false;
  final gtm = Gtm.instance;
  @override
  void initState() {
    // TODO: implement initState
    gtm.push(GTMConstants.kScreenViewEvent, parameters: {GTMConstants.kpageName: GTMConstants.kAddContactScreen});

    super.initState();
    initcheckPermission();

    if (widget.phoneNumber != null) {
      _personalNumber.text = widget.phoneNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contactSearchButton() {
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

            if (_personalNumber.text.length == 0) {
              Utils.displayToastBottomError("Please Enter Valid Phone  Number", context);
              return;
            }
            if (_personalNumber.text.length >= 1 && !_personalNumber.text.isValidMobile()) {
              Utils.displayToastBottomError("Please Enter 10-digit Phone Number", context);
              return;
            }

            Utils.hideKeyboard(context);

            SharedPreferences preferences = await SharedPreferences.getInstance();
            var phone = preferences.getString("phone");

            if (getTrimedNumber(phone) != _personalNumber.text) {
              setState(() {
                _loader = true;
              });
              getProfileDetails();
            } else {
              Utils.displayToastBottomError("Please enter valid Mobile number.", context);
            }
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 50.h),
            alignment: Alignment.center,
            child: Text(
              "Search",
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

    Widget checkContactScreen() {
      return Container(
        child: Form(
          key: _checkContactKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormFieldContact(
                hintText: "Enter the Mobile Number",
                padding: 14.0,
                margin: 22.0,
                maxLength: 10,
                textInputType: TextInputType.number,
                actionKeyboard: TextInputAction.done,
                onChanged: (value) {},
                parametersValidate: "Please enter Mobile number.",
                controller: _personalNumber,
                regexexp: RegExp(r'[0-9]'),
              ),
              SizedBox(height: 20.h),
              contactSearchButton()
            ],
          ),
        ),
      );
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
        title: Text(
          "Add Contact",
          style: TextStyle(
            fontFamily: kSfproRoundedFontFamily,
            color: AppColor.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _loader,
        opacity: 0.3,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        ),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: checkContactScreen(),
          ),
        ),
      ),
    );
  }

  getProfileDetails() async {
    try {
      // var requestBody = {
      //   "phone": _personalNumber.text,
      // };
      var response =
          await ContactBloc().checkContactForAddNew(CheckContactForAddNewRequestBody(phone: _personalNumber.text));

      setState(() {
        _loader = false;
      });

      print(response);
      if (response['status'] == true) {
        _conetUser = response['conetuser'];

        displayProfileScreen(response);
      } else {
        Utils.displayToastTopError(response["message"], context);
      }
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: "Already exist in your contact list",
      );
      //Utils.displayToastTopError("Already exist in your contact list", context);
    }
  }

  void displayProfileScreen(response) {
    if (_conetUser!) {
      if (response["user"] != null) {
        contactDetail = ContactDetail.fromJson(response["user"]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddContactUserProfilePage(
                      contactDetails: contactDetail,
                      conetUser: true,
                    )));
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AddContactUserProfilePage(
                    contactNumber: _personalNumber.text,
                    conetUser: false,
                  )));
    }
  }

  addNewContact() async {
    setState(() {
      _loader = true;
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

    // var requestBody = {
    //   "per_name": _personalName.text,
    //   "per_num": _personalNumber.text,
    //   "per_email": _personalEmail.text,
    //   "per_dob": _personalDob.text,
    //   "per_add": _personalAddress.text,
    //   "per_lan": _personalLandline.text == '' ? null : int.parse(_personalLandline.text),
    //   "pro_occ": _professionalOccupation.text,
    //   "pro_ind": _professionalIndustry.text,
    //   "pro_com": _professionalCompany.text,
    //   "pro_com_website": _professionalCompanyWebsite.text,
    //   "pro_wn": _professionalWorkNature.text,
    //   "pro_des": _professionalDesignation.text,
    //   "pro_sch": _professionalSchool.text,
    //   "pro_gra": _professionalGrade.text,
    //   "fb": _socialFacebook.text,
    //   "in": _socialInstagram.text,
    //   "tt": _socialTwitter.text,
    //   "sk": _socialSkype.text,
    //   // "gp": _socialFacebook.text,
    //   // "pt": _socialFacebook.text,
    //   "entreprenerur_list": (entreprenerurList.map((e) => e.toJson()).toList()),
    // };

    // print(jsonEncode(requestBody));

    Utils.hideKeyboard(context);

    var response = await ContactBloc().addNewContact(AddNewContactRequestBody(
      personalName: _personalName.text,
      personalNumber: _personalNumber.text,
      personalEmail: _personalEmail.text,
      personalDob: _personalDob.text,
      personalAddress: _personalAddress.text,
      personalLandline: _personalLandline.text == '' ? null : int.parse(_personalLandline.text),
      professionalWorkNature: _professionalWorkNature.text,
      professionalDesignation: _professionalDesignation.text,
      professionalSchool: _professionalSchool.text,
      professionalGrade: _professionalGrade.text,
      socialFacebook: _socialFacebook.text,
      socialInstagram: _socialInstagram.text,
      socialTwitter: _socialTwitter.text,
      socialSkype: _socialSkype.text,
      entreprenerur_list: entreprenerurList.map((e) => e.toJson()).toList(),
      professionalCompany: _professionalCompany.text,
      professionalCompanyWebsite: _professionalCompanyWebsite.text,
      professionalOccupation: _professionalOccupation.text,
      professionalIndustry: _professionalIndustry.text,
    ));
    setState(() {
      _loader = false;
    });
    if (response['status'] == true) {
      await checkPermission();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToastBottomError('Token is Expired', context);
      tokenExpired(context);
    } else {
      Utils.displayToastBottomError('Something went wrong', context);
    }
  }

  checkPermission() async {
    try {
      PermissionStatus permission = await Permission.contacts.status;

      if (permission != PermissionStatus.granted) {
        await Permission.contacts.request();
        PermissionStatus permission = await Permission.contacts.status;

        if (permission == PermissionStatus.granted) {
          await addContactToLocal();
        } else {
          //_handleInvalidPermissions(context);
        }
      } else {
        await addContactToLocal();
      }
    } catch (e) {
      print(e);
    }
  }

  initcheckPermission() async {
    try {
      PermissionStatus permission = await Permission.contacts.status;

      if (permission != PermissionStatus.granted) {
        await Permission.contacts.request();
        PermissionStatus permission = await Permission.contacts.status;

        if (permission == PermissionStatus.granted) {
          // await addContactToLocal();
        } else {
          //_handleInvalidPermissions(context);
        }
      } else {
        // await addContactToLocal();
      }
    } catch (e) {
      print(e);
    }
  }

  addContactToLocal() async {
    Contact newContact = Contact();
    newContact.givenName = _personalName.text;
    newContact.emails = [Item(label: "work", value: _personalNumber.text)];
    newContact.phones = [Item(label: "mobile", value: _personalNumber.text)];
    await ContactsService.addContact(newContact);
  }
}
