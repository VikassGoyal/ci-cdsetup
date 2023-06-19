import 'dart:convert';

import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class AddContact extends StatefulWidget {
  String? phoneNumber;
  AddContact({this.phoneNumber});

  @override
  _AddContactState createState() => _AddContactState();
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
  @override
  void initState() {
    // TODO: implement initState
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

            if (_personalNumber.text.length == 0) {
              Utils.displayToastBottomError("Please Enter Valid Phone  Number");
              return;
            }
            if (_personalNumber.text.length >= 1 && !_personalNumber.text.isValidMobile()) {
              Utils.displayToastBottomError("Please Enter 10-digit Phone Number");
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
              Utils.displayToast("Please enter valid Mobile number.");
            }
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Text(
              "Search",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
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
                  regexexp: RegExp(r'[0-9]')),
              const SizedBox(height: 20),
              contactSearchButton()
            ],
          ),
        ),
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
                style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add Contact",
          style: Theme.of(context).textTheme.headline4?.apply(color: AppColor.whiteColor),
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
      var requestBody = {
        "phone": _personalNumber.text,
      };
      var response = await ContactBloc().checkContactForAddNew(requestBody);

      setState(() {
        _loader = false;
      });

      if (response['status'] == true) {
        _conetUser = response['conetuser'];

        displayProfileScreen(response);
      } else {
        Utils.displayToastTopError(response["message"]);
      }
    } catch (e) {
      print(e);
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

    var requestBody = {
      "per_name": _personalName.text,
      "per_num": _personalNumber.text,
      "per_email": _personalEmail.text,
      "per_dob": _personalDob.text,
      "per_add": _personalAddress.text,
      "per_lan": _personalLandline.text == '' ? null : int.parse(_personalLandline.text),
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
      "entreprenerur_list": (entreprenerurList.map((e) => e.toJson()).toList()),
    };

    print(jsonEncode(requestBody));

    Utils.hideKeyboard(context);

    var response = await ContactBloc().addNewContact(requestBody);
    setState(() {
      _loader = false;
    });
    if (response['status'] == true) {
      Utils.displayToast(response['message'].toString());
      await checkPermission();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToast('Token is Expired');
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong');
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
