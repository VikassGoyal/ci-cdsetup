import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conet/blocs/contacts_operations/contacts_operations_bloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/models/entrepreneureData.dart';
import 'package:conet/src/appScreen.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/gtm_constants.dart';
import 'package:conet/utils/switchContactToggle.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gtm/gtm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../api_models/addNewContact_request_model/addNewContact_request_body.dart';
import '../../bottomNavigation/bottomNavigationBloc.dart';
import '../../models/imageUploadModel.dart';
import '../../repositories/contactPageRepository.dart';
import '../../utils/custom_fonts.dart';

class AddContactUserProfilePage extends StatefulWidget {
  const AddContactUserProfilePage({super.key, this.contactDetails, required this.conetUser, this.contactNumber});
  final ContactDetail? contactDetails;
  final bool conetUser;
  final String? contactNumber;

  @override
  State<AddContactUserProfilePage> createState() => _AddContactUserProfilePageState();
}

class _AddContactUserProfilePageState extends State<AddContactUserProfilePage> {
  final _checkContactKey = GlobalKey<FormState>();
  bool professionalTab = true;
  bool _loader = false;

  bool _enterpreneurForms = false;
  bool _companyVisible = false;
  bool _companyWebsiteVisible = false;
  // bool _companyIndustryVisible = false;
  bool _companyWorkNatureVisible = false;
  bool _studentSchoolVisible = false;
  bool _studentGradeVisible = false;
  bool _designationVisible = false;
  bool switchTypeStatus = true;
  bool _conetUser = false;
  String userImage = '';

  late ContactDetail contactDetail;
  DateTime? selectedDate;
  String? _occupationValue;

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
  final gtm = Gtm.instance;
  late final ContactsOperationsBloc contactsOperationsBloc;
  @override
  void initState() {
    _conetUser = widget.conetUser;
    contactsOperationsBloc = BlocProvider.of<ContactsOperationsBloc>(context);
    if (_conetUser) {
      initForConetUser();
    } else {
      initForNonConetUser();
    }

    super.initState();
  }

  void initForNonConetUser() {
    _personalNumber.text = widget.contactNumber!;
  }

  void initForConetUser() {
    contactDetail = widget.contactDetails!;
    _personalName.text = contactDetail.name ?? "";
    userImage = contactDetail.profileImage ?? "";
    _personalNumber.text = contactDetail.personal?.number ?? "";
    _personalEmail.text = contactDetail.personal?.email ?? "";
    _personalDob.text = contactDetail.personal?.dOB ?? "";
    _personalAddress.text = contactDetail.personal?.address1 ?? "";
    _personalLandline.text =
        (contactDetail.personal?.landline == null ? '' : contactDetail.personal?.landline.toString())!;

    _personalCity.text = contactDetail.personal?.city ?? "";
    _personalState.text = contactDetail.personal?.state ?? "";
    _personalCountry.text = contactDetail.personal?.country ?? "";
    _personalPincode.text = contactDetail.personal?.pincode ?? "";
    _personalKeyword.text = contactDetail.personal?.keyword ?? "";

    if (contactDetail.professional != null) {
      _occupationValue = contactDetail.professional?.occupation ?? "";
      _professionalOccupation.text = contactDetail.professional?.occupation ?? "";
      _professionalCompany.text = contactDetail.professional?.company ?? "";
      _professionalCompanyWebsite.text = contactDetail.professional?.companyWebsite ?? "";
      _professionalSchool.text = contactDetail.professional?.schoolUniversity ?? "";
      _professionalWorkNature.text = contactDetail.professional?.workNature ?? "";
      _professionalDesignation.text = contactDetail.professional?.designation ?? "";
      _professionalGrade.text = contactDetail.professional?.grade ?? "";

      entreprenerurListJson = contactDetail.professionalList;

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

        var entrepreneureData = EntrepreneurData();
        entrepreneureData.id = data.id;
        entrepreneureData.company = data.company;
        entrepreneureData.website = data.companyWebsite;
        entrepreneureData.workNature = data.workNature;
        entrepreneureData.images = imageData;
        entreprenerurList.add(entrepreneureData);
      }
      checkOccupation();
    }

    if (contactDetail.social != null) {
      _socialFacebook.text = contactDetail.social?.facebook ?? "";
      _socialInstagram.text = contactDetail.social?.instagram ?? "";
      _socialTwitter.text = contactDetail.social?.twitter ?? "";
      _socialInstagram.text = contactDetail.social?.instagram ?? "";
      _socialGpay.text = contactDetail.social?.gpay ?? "";
      _socialPaytm.text = contactDetail.social?.paytm ?? "";
    }

    dynamic dat = contactDetail.personal?.dOB;

    dat == null ? _personalDob.text : _personalDob.text = dat;

    if (dat != null) {
      print(dat);
      selectedDate = DateFormat('dd-mm-yyyy').parse(dat);
    } else {
      selectedDate = DateTime.now();
    }
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
                Navigator.pop(context);
              },
              child: Container(
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
            ),
            centerTitle: true,
            title: Text("Add Contact",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: kSfproRoundedFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: AppColor.whiteColor))),
        body: LoadingOverlay(
            isLoading: _loader,
            opacity: 0.3,
            progressIndicator: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
            ),
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          color: AppColor.primaryColor,
                        ),
                        _conetUser ? bodyContent() : bodyNonConetContact(),
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
                    )
                  ],
                ),
              ),
            )));
  }

  Widget bodyContent() {
    return Column(
      children: [
        const SizedBox(height: 80),
        selectButton(),
        _buildformBody(),
      ],
    );
  }

  Widget bodyNonConetContact() {
    return Column(
      children: [
        const SizedBox(height: 80),
        _buildForNonConet(),
      ],
    );
  }

  Widget _buildForNonConet() {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildName(false),
        const SizedBox(height: 16),
        _buildMobileNumber(true),
        const SizedBox(height: 30),
        _buildAddContactButton(),
      ],
    );
  }

  Widget _buildformBody() {
    return Column(
      children: professionalTab
          ? [
              const SizedBox(height: 26),
              _buildName(true),
              const SizedBox(height: 16),
              _buildMobileNumber(true),
              const SizedBox(height: 16),
              _buildSecondaryPhoneNumber(),
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
              _buildAddContactButton(),
              const SizedBox(height: 30),
            ],
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
                  MaterialStateProperty.all<Color>(professionalTab ? AppColor.accentColor : AppColor.whiteColor),
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
                professionalTab = true;
              });
            },
            child: Text(
              'Personal',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.apply(color: professionalTab ? AppColor.whiteColor : AppColor.accentColor),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(professionalTab ? AppColor.whiteColor : AppColor.secondaryColor),
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
                  professionalTab = false;
                },
              );
            },
            child: Text(
              'Professional',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.apply(color: professionalTab ? AppColor.secondaryColor : AppColor.whiteColor),
            ),
          ),
        ),
        const SizedBox(width: 22),
      ],
    );
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

  Widget _buildName(readOnlyValue) {
    return TextFormFieldContact(
      hintText: "Name",
      padding: 14.0,
      readonly: readOnlyValue,
      margin: 22.0,
      enableFormatters: false,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      onSubmitField: () {},
      controller: _personalName,
      parametersValidate: "Please enter Mobile number.",
    );
  }

  Widget _buildMobileNumber(readOnlyValue) {
    return TextFormFieldContact(
      hintText: "Phone number",
      padding: 14.0,
      readonly: readOnlyValue,
      margin: 22.0,
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
      textInputType: TextInputType.emailAddress,
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
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      onSubmitField: () {},
      controller: _personalDob,
      parametersValidate: "DOB",
    );
  }

  Widget _buildAddress() {
    return TextFormFieldContact(
      hintText: "Address",
      padding: 14.0,
      readonly: true,
      margin: 22.0,
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

  Widget _buildLandLine() {
    return TextFormFieldContact(
      hintText: "Landline Number",
      padding: 14.0,
      readonly: true,
      margin: 22.0,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      onSubmitField: () {},
      controller: _personalLandline,
      parametersValidate: "Please enter Landline Number.",
    );
  }

  Widget _relationShip() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      // height: 48,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(
        left: 22,
        right: 22,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText2?.apply(
                    color: AppColor.secondaryColor,
                  ),
              decoration: InputDecoration(
                labelText: "Relationship",
                filled: true,
                fillColor: AppColor.whiteColor,
                focusedBorder: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.bodyText2?.apply(
                      color: const Color(0xFF878B95),
                    ),
                labelStyle: Theme.of(context).textTheme.headline6?.apply(
                      color: const Color.fromRGBO(135, 139, 149, 1),
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
                  switchTypeStatus = !switchTypeStatus;
                },
              );
            },
            buttonColor: AppColor.accentColor,
            backgroundColor: AppColor.placeholder,
            textColor: const Color(0xFFFFFFFF),
            value: switchTypeStatus,
          ),
        ],
      ),
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
              professionalTab = false;
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
            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildAddContactButton() {
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
          addNewContact();
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            "Add Contact",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }

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
      onSubmitField: () {},
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
      onSubmitField: () {},
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
      onSubmitField: () {},
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
      onSubmitField: () {},
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
      onSubmitField: () {},
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
      onSubmitField: () {},
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
                  style: Theme.of(context).textTheme.headline5?.apply(color: AppColor.bottomUnselectItemColor),
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
                style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                  labelText: "Company",
                  labelStyle: Theme.of(context).textTheme.headline6?.apply(
                        color: const Color.fromRGBO(135, 139, 149, 1),
                      ),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: InputBorder.none,
                ),
                readOnly: true,
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
                style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                  labelText: "Website",
                  labelStyle: Theme.of(context).textTheme.headline6?.apply(
                        color: const Color.fromRGBO(135, 139, 149, 1),
                      ),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: InputBorder.none,
                ),
                readOnly: true,
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
                style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.secondaryColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                  labelText: 'Work Nature',
                  labelStyle: Theme.of(context).textTheme.headline6?.apply(
                        color: const Color.fromRGBO(135, 139, 149, 1),
                      ),
                  filled: true,
                  fillColor: AppColor.whiteColor,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: InputBorder.none,
                ),
                readOnly: true,
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
                                      ? Image.file(
                                          width: 114,
                                          height: 102,
                                          fit: BoxFit.cover,
                                          File(entreprenerurList[i].images![0].imageAsset),
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return const Center(child: Text('This image type is not supported'));
                                          },
                                        )
                                      : const SizedBox(
                                          width: 114,
                                          height: 102,
                                        ))),
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
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    )
                                  : (entreprenerurList[i].images!.length >= 2
                                      ? Image.file(
                                          width: 114,
                                          height: 102,
                                          fit: BoxFit.cover,
                                          File(entreprenerurList[i].images![1].imageAsset),
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return const Center(child: Text('This image type is not supported'));
                                          },
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
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    )
                                  : (entreprenerurList[i].images!.length >= 2
                                      ? Image.file(
                                          width: 114,
                                          height: 102,
                                          fit: BoxFit.cover,
                                          File(entreprenerurList[i].images![2].imageAsset),
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return const Center(child: Text('This image type is not supported'));
                                          },
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

    //print(jsonEncode(requestBody));

    Utils.hideKeyboard(context);

    var response = await contactsOperationsBloc.addNewContact(AddNewContactRequestBody(
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
      gtm.push(GTMConstants.kcontactAddEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: response['message'].toString(),
      );
      //Utils.displayToast(response['message'].toString(), context);
      await checkPermission();
      context.read<BottomNavigationBloc>().currentIndex = 1;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AppScreen(value: true)),
        (route) => false,
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

  addContactToLocal() async {
    Contact newContact = Contact();
    newContact.givenName = _personalName.text;
    newContact.emails = [Item(label: "work", value: _personalNumber.text)];
    newContact.phones = [Item(label: "mobile", value: _personalNumber.text)];
    await ContactsService.addContact(newContact);
  }
}
