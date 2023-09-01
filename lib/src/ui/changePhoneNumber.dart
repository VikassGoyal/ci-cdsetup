import 'dart:convert';

import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/src/ui/verifyNewPhoneNumber.dart';
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

class ChangePhoneNumber extends StatefulWidget {
  final String? phoneNumber;
  ContactDetail? contactDetail;
  ChangePhoneNumber(
    this.phoneNumber,
    this.contactDetail, {
    super.key,
  });

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final _checkContactKey = GlobalKey<FormState>();
  bool professionalTab = true;
  bool switchTypeStatus = true;
  String userImage = '';

  ContactDetail contactDetail = ContactDetail();
  DateTime? selectedDate;
  final _personalNumber = TextEditingController();

  List<EntrepreneurData> entreprenerurList = [];
  List<ProfessionalList>? entreprenerurListJson = [];
  bool _loader = false;
  final gtm = Gtm.instance;
  @override
  void initState() {
    // TODO: implement initState
    // gtm.push(GTMConstants.kScreenViewEvent, parameters: {GTMConstants.kpageName: GTMConstants.kAddContactScreen});

    super.initState();
    // initcheckPermission();
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

            if (_personalNumber.text != phone) {
              setState(() {
                _loader = true;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => VerifyNewPhoneNumber(widget.contactDetail, _personalNumber.text)));

              //getProfileDetails();
            } else {
              Utils.displayToastBottomError("Please enter valid Mobile number.", context);
            }
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 50.h),
            alignment: Alignment.center,
            child: Text(
              "Update",
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
          "Update Number",
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
}
