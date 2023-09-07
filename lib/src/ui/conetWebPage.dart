import 'package:conet/api_models/qrValue_request_model/qrValue_request_body.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/blocs/userBloc.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/searchContacts.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
import 'package:conet/src/common_widgets/remove_scroll_glow.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/konetUserProfilePage.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/get_it.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gtm/gtm.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_models/ filterSearchResults_request_model/ filterSearchResults_request_body.dart';
import '../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../../blocs/contactRequest.dart';
import '../../models/contactDetails.dart';
import '../../utils/custom_fonts.dart';
import '../../utils/gtm_constants.dart';
import 'addContactUserProfilePage.dart';
import 'utils.dart';

class ConetWebPage extends StatefulWidget {
  //var contactsData;
  bool backcheck;

  ConetWebPage({super.key, required this.backcheck});

  @override
  State<ConetWebPage> createState() => _ConetWebPageState();
}

class _ConetWebPageState extends State<ConetWebPage> {
  final FocusNode _focus = FocusNode();

  final List<AllContacts> _loadedcontacts = [];
  List<AllContacts> _contacts = [];
  List<SearchContacts> _searchResult = [];
  TextEditingController? _searchController;
  TextEditingController? _outputController;
  bool? _searchvisible;
  bool _searchEnabled = false;
  bool _loader = false;
  bool _showCancelIcon = false;
  var keywordvalue;
  var searchvalue;

  bool _suggestionsLoader = true;
  List<SearchContacts> _suggestionResult = [];
  final gtm = Gtm.instance;
  var lengthofnotification = 0;
  @override
  void initState() {
    super.initState();
    // var responseData = widget.contactsData;
    // _contacts = responseData;
    // _contacts = _contacts.where((item) => item.company == "yes").toList();
    // _loadedcontacts = _contacts;
    _searchController = TextEditingController();
    _outputController = TextEditingController();
    _searchvisible = false;
    keywordvalue = null;
    gtm.push(GTMConstants.kScreenViewEvent, parameters: {GTMConstants.kpageName: GTMConstants.KkonetwebpageScreen});
    getNotificationData();

    _popupSettings();

    // Fetch suggestions.
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        final response = await ContactBloc().contactPageRepository?.getSearchSuggestions();
        var responseData = response['data'];

        if (response['status'] == true) {
          if (response['msg'] == 'yes') {
            if (mounted) {
              setState(() {
                _suggestionResult = List<SearchContacts>.from(responseData.map((item) {
                  return SearchContacts.fromJson(item);
                }));
                if (_suggestionResult.isNotEmpty) {
                  _searchResult = _suggestionResult;
                  _searchvisible = true;
                }
              });
            }
          }
        }

        if (mounted) {
          setState(() {
            _suggestionsLoader = false;
          });
        }
      } catch (err) {
        if (mounted) {
          setState(() {
            _suggestionsLoader = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController!.dispose();
    _outputController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _showPopup() async {
      showGeneralDialog(
        barrierLabel: "",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 22.w, right: 22.w),
              padding: EdgeInsets.only(left: 32.w, right: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    image: const AssetImage('assets/images/alert_conetweb.png'),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "KONET Web Search",
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      color: AppColor.black2,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 18.sp,

                      // Remove the underline
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Business Designer,  Graphic Designer, Interior Designer,  MSME, Textiles, Event Planners,  Digital marketing....",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      color: AppColor.placeholder,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                    onPressed: () {
                      _focus.hasFocus.toString();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      constraints: BoxConstraints(minHeight: 50.h, maxWidth: 100.w),
                      alignment: Alignment.center,
                      child: Text(
                        "Got it",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: kSfproRoundedFontFamily,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    Widget contactListItem(int index) {
      return Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Stack(
              children: [
                SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/profile.png",
                      image: _contacts[index].profileImage != null
                          ? AppConstant.profileImageBaseUrl + _contacts[index].profileImage!
                          : "",
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
                  top: 0,
                  right: 0,
                  child: Container(
                    child: _contacts[index].contactMetaType == "professional"
                        ? SvgPicture.asset(
                            "assets/icons/ic_blue_tick.svg",
                            height: 15.h,
                          )
                        : SvgPicture.asset(
                            "assets/icons/ic_green_tick.svg",
                            height: 15.h,
                          ),
                  ),
                )
              ],
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${_contacts[index].name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 13.sp,
                            fontFamily: kSfproRoundedFontFamily,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 2.w),
                    Text("${_contacts[index].name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.gray30Color,
                            fontSize: 13.sp,
                            fontFamily: kSfproRoundedFontFamily,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _contacts[index].email != null,
              child: Container(
                width: 38.w,
                height: 38.w,
                alignment: Alignment.center,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "assets/icons/ic_list_mail.svg",
                  ),
                  onPressed: () {
                    print("Cliked");
                  },
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Visibility(
              visible: _contacts[index].phone != null,
              child: Container(
                width: 38.w,
                height: 38.w,
                alignment: Alignment.center,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "assets/icons/ic_list_chat.svg",
                  ),
                  onPressed: () {
                    print("Cliked");
                  },
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Visibility(
              visible: _contacts[index].phone != null,
              child: Container(
                width: 38.w,
                height: 38.w,
                alignment: Alignment.center,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "assets/icons/ic_list_call.svg",
                  ),
                  onPressed: () {
                    print("Cliked");
                    _callNumber(_contacts[index].phone!);
                  },
                ),
              ),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      );
    }

    Widget contactSearchListItem(int index) {
      return Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 16.w),
                Stack(
                  children: [
                    SizedBox(
                      width: 40.w,
                      height: 40.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: _searchResult[index].profileImage != null
                            ? FadeInImage.assetNetwork(
                                placeholder: "assets/images/profile.png",
                                image: _searchResult[index].profileImage != null
                                    ? AppConstant.profileImageBaseUrl + _searchResult[index].profileImage!
                                    : "",
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/profile.png",
                                  );
                                },
                              )
                            : Image.asset(
                                "assets/images/profile.png",
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _searchResult[index].name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ic_contactlink.svg",
                              height: 10,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              (_searchResult[index].via ?? ""),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: AppColor.secondaryColor, fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_searchResult[index].mutualList!.length > 1) {
                                    _searchResult[index].visible = !_searchResult[index].visible!;
                                  }
                                });
                              },
                              child: Text(
                                  (_searchResult[index].mutualList == null || _searchResult[index].mutualList!.isEmpty
                                      ? ""
                                      : " ${'(${_searchResult[index].mutualList?.length})'}"),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColor.secondaryColor,
                                      fontSize: 13.sp,
                                      fontFamily: kSfproRoundedFontFamily,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        keywordvalue != "" && keywordvalue != null
                            ? Text("Professional: ${keywordvalue}",
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: 13.sp,
                                    fontFamily: kSfproRoundedFontFamily,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                // Visibility(
                //   visible: (_searchResult[index].status == 'accepted'),
                //   child: Container(
                //     height: 25.h,
                //     alignment: Alignment.center,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: AppColor.accentColor,
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //       ),
                //       onPressed: () {},
                //       child: Container(
                //         constraints: BoxConstraints(minHeight: 25.h, minWidth: 70.w),
                //         alignment: Alignment.center,
                //         child: Text("Accepted",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: AppColor.whiteColor,
                //                 fontSize: 13.sp,
                //                 fontFamily: kSfproRoundedFontFamily,
                //                 fontStyle: FontStyle.normal,
                //                 fontWeight: FontWeight.w500)),
                //       ),
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: (_searchResult[index].status == 'requested'),
                //   child: Container(
                //     height: 25.h,
                //     alignment: Alignment.center,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: AppColor.primaryColor,
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //       ),
                //       onPressed: () {},
                //       child: Container(
                //         constraints: BoxConstraints(minHeight: 25.h, minWidth: 70.w),
                //         alignment: Alignment.center,
                //         child: Text("Requested",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: AppColor.whiteColor,
                //                 fontSize: 13.sp,
                //                 fontFamily: kSfproRoundedFontFamily,
                //                 fontStyle: FontStyle.normal,
                //                 fontWeight: FontWeight.w500)),
                //       ),
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: (_searchResult[index].status == null),
                //   child: Container(
                //     height: 25.h,
                //     alignment: Alignment.center,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: AppColor.whiteColor,
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //         side: const BorderSide(color: AppColor.accentColor),
                //       ),
                //       onPressed: () {
                //         print("qeeeeeeeeeeeee");
                //         print(_searchResult[index].qrValue!);
                //         setState(() {
                //           _outputController?.clear();
                //           _outputController?.text = _searchResult[index].qrValue!;
                //         });
                //         if (_outputController?.text != '' && _searchResult.isNotEmpty) {
                //           _sentRequest(index, 0, "parent", _searchResult[index].name);
                //         }
                //       },
                //       child: Container(
                //         constraints: BoxConstraints(minHeight: 25.h, minWidth: 70.w),
                //         alignment: Alignment.center,
                //         child: Text("Connect",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: AppColor.accentColor,
                //                 fontSize: 13.sp,
                //                 fontFamily: kSfproRoundedFontFamily,
                //                 fontStyle: FontStyle.normal,
                //                 fontWeight: FontWeight.w500)),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(width: 16.w),
              ],
            ),
            Visibility(
              visible: _searchResult[index].visible!,
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: AppColor.dividerItemColor),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(1.0, 6.0),
                    ),
                  ],
                ),
                child: Column(children: [
                  // Icon(IconData(0xf87b),color: AppColor.gray30Color,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _searchResult[index].mutualList?.length ?? 0,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      );
                    },
                    itemBuilder: (context, mutindex) {
                      return mutindex != 0
                          ? Container(
                              padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "assets/images/profile.png",
                                            image: _searchResult[index].mutualList![mutindex].profileImage != null
                                                ? AppConstant.profileImageBaseUrl +
                                                    _searchResult[index].mutualList![mutindex].profileImage!
                                                : "",
                                            fit: BoxFit.cover,
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/profile.png",
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _searchResult[index].mutualList![mutindex].via ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3
                                                ?.copyWith(fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(height: 2.h),
                                          // Text(
                                          //   _searchResult[index].mutualList![mutindex] == null
                                          //       ? ""
                                          //       : _searchResult[index].mutualList![mutindex].via ?? '',
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .headline6
                                          //       ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (_searchResult[index].mutualList![mutindex].status == 'accepted'),
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.accentColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          constraints: const BoxConstraints(minHeight: 28.0, maxWidth: 84.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Accepted",
                                            textAlign: TextAlign.center,
                                            style:
                                                Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (_searchResult[index].mutualList![mutindex].status == 'requested'),
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.primaryColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          constraints: const BoxConstraints(minHeight: 28.0, maxWidth: 100.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Requested",
                                            textAlign: TextAlign.center,
                                            style:
                                                Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (_searchResult[index].mutualList![mutindex].status == null),
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.accentColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _outputController?.clear();
                                            _outputController?.text =
                                                _searchResult[index].mutualList![mutindex].qrValue!;
                                          });
                                          if (_outputController?.text != '' && _searchResult.isNotEmpty) {
                                            _sentRequest(index, mutindex, "child",
                                                _searchResult[index].mutualList![mutindex].name);
                                          }
                                        },
                                        child: Container(
                                          constraints: const BoxConstraints(minHeight: 28.0, maxWidth: 70.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Connect",
                                            textAlign: TextAlign.center,
                                            style:
                                                Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ]),
              ),
            )
          ],
        ),
      );
    }

    // Widget contactsList() {
    //   return Expanded(
    //     child: ListView.separated(
    //       shrinkWrap: true,
    //       physics: ClampingScrollPhysics(),
    //       itemCount: _contacts.length,
    //       primary: false,
    //       scrollDirection: Axis.vertical,
    //       separatorBuilder: (context, index) {
    //         return Divider(
    //           height: 1,
    //           color: Colors.grey.shade200,
    //         );
    //       },
    //       itemBuilder: (context, index) {
    //         return _searchvisible
    //             ? contactSearchListItem(index)
    //             : contactListItem(index);
    //       },
    //     ),
    //   );
    // }

    Widget conetWebSearchDefault() {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Image(
              image: AssetImage(
                'assets/images/conetWebDefault.png',
              ),
            ),
            SizedBox(height: 42.h),
            Text(
              "KONET Web Search",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kSfproRoundedFontFamily,
                color: AppColor.placeholder,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18.sp,
              ),
            ),
            if (_suggestionsLoader) ...[
              SizedBox(height: 30.h),
              const CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
              Text(
                'Loading suggestions...',
                style: TextStyle(
                  fontFamily: kSfproRoundedFontFamily,
                  color: AppColor.placeholder,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
            ]
          ],
        ),
      );
    }

    Widget searchConetwebList() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: _searchResult.length,
        primary: false,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: Color(0xFF757575),
          );
        },
        itemBuilder: (context, index) {
          searchvalue = _searchController!.text.toLowerCase();
          keywordvalue = null;
          keywordvalue = _searchResult.isNotEmpty && _searchController!.text.isNotEmpty
              ? _searchResult[index].name != null && _searchResult[index].name == _searchController!.text
                  ? ""
                  : (_searchResult[index].occupation != null &&
                          _searchResult[index].occupation!.toLowerCase().contains(searchvalue)
                      ? "Occupation"
                      : _searchResult[index].industry != null &&
                              _searchResult[index].industry!.toLowerCase().contains(searchvalue)
                          ? "Industry Name"
                          : _searchResult[index].company != null &&
                                  _searchResult[index].company!.toLowerCase().contains(searchvalue)
                              ? "Company Name"
                              : _searchResult[index].company_website != null &&
                                      _searchResult[index].company_website!.toLowerCase().contains(searchvalue)
                                  ? "Company Website"
                                  : _searchResult[index].school_university != null &&
                                          _searchResult[index].school_university!.toLowerCase().contains(searchvalue)
                                      ? "School/University"
                                      : _searchResult[index].grade != null &&
                                              _searchResult[index].grade!.toLowerCase().contains(searchvalue)
                                          ? "Grade"
                                          : _searchResult[index].work_nature != null &&
                                                  _searchResult[index].work_nature!.toLowerCase().contains(searchvalue)
                                              ? "Work Nature"
                                              : _searchResult[index].designation != null &&
                                                      _searchResult[index]
                                                          .designation!
                                                          .toLowerCase()
                                                          .contains(searchvalue)
                                                  ? "Designation"
                                                  : _searchResult[index].keyword != null &&
                                                          _searchResult[index]
                                                              .keyword!
                                                              .any((value) => value.toLowerCase().contains(searchvalue))
                                                      ? "Keyword"
                                                      : _searchResult[index].facebook != null &&
                                                              _searchResult[index]
                                                                  .facebook!
                                                                  .toLowerCase()
                                                                  .contains(searchvalue)
                                                          ? "Facebook Profile"
                                                          : _searchResult[index].instagram != null &&
                                                                  _searchResult[index]
                                                                      .instagram!
                                                                      .toLowerCase()
                                                                      .contains(searchvalue)
                                                              ? "Instagram Profile"
                                                              : _searchResult[index].twitter != null &&
                                                                      _searchResult[index]
                                                                          .twitter!
                                                                          .toLowerCase()
                                                                          .contains(searchvalue)
                                                                  ? "Twitter Profile"
                                                                  : _searchResult[index].skype != null &&
                                                                          _searchResult[index]
                                                                              .skype!
                                                                              .toLowerCase()
                                                                              .contains(searchvalue)
                                                                      ? "Skype Profile"
                                                                      : "")
              : "";

          return _searchvisible!
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KonetUserProfilePage(
                                _searchResult[index].id,
                                _searchResult[index].name,
                                _searchResult[index].profileImage,
                                _searchResult[index].qrValue,
                                _searchResult[index].via,
                                _searchResult[index].viaId,
                                _searchResult[index].status,
                                _searchResult[index].mutualList ?? [],
                                _searchResult[index].listcount ?? 0,
                                _searchResult[index].visible ?? false))).then((value) {
                      if (value == true) {
                        Future.delayed(const Duration(milliseconds: 500), () async {
                          try {
                            final response = await ContactBloc().contactPageRepository?.getSearchSuggestions();
                            var responseData = response['data'];

                            if (response['status'] == true) {
                              if (response['msg'] == 'yes') {
                                if (mounted) {
                                  _searchResult = [];
                                  _suggestionResult = List<SearchContacts>.from(
                                      responseData.map((item) => SearchContacts.fromJson(item)));
                                  if (_suggestionResult.isNotEmpty) {
                                    _searchResult = _suggestionResult;
                                    _searchvisible = true;
                                  }
                                  setState(() {});
                                }
                              }
                            }

                            if (mounted) {
                              setState(() {
                                _suggestionsLoader = false;
                              });
                            }
                          } catch (err) {
                            print(err);
                            if (mounted) {
                              setState(() {
                                _suggestionsLoader = false;
                              });
                            }
                          }
                        });
                      }
                    });
                  },
                  child: contactSearchListItem(index))
              : InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => KonetUserProfilePage(
                                _searchResult[index].id,
                                _searchResult[index].name,
                                _searchResult[index].profileImage,
                                _searchResult[index].qrValue,
                                _searchResult[index].via,
                                _searchResult[index].viaId,
                                _searchResult[index].status,
                                _searchResult[index].mutualList,
                                _searchResult[index].listcount,
                                _searchResult[index].visible)))
                        .then((value) {
                      if (value) {
                        Future.delayed(const Duration(milliseconds: 500), () async {
                          try {
                            final response = await ContactBloc().contactPageRepository?.getSearchSuggestions();
                            var responseData = response['data'];

                            if (response['status'] == true) {
                              if (response['msg'] == 'yes') {
                                if (mounted) {
                                  setState(() {
                                    _suggestionResult = List<SearchContacts>.from(
                                        responseData.map((item) => SearchContacts.fromJson(item)));
                                    if (_suggestionResult.isNotEmpty) {
                                      _searchResult = _suggestionResult;
                                      _searchvisible = true;
                                    }
                                  });
                                }
                              }
                            }

                            if (mounted) {
                              setState(() {
                                _suggestionsLoader = false;
                              });
                            }
                          } catch (err) {
                            if (mounted) {
                              setState(() {
                                _suggestionsLoader = false;
                              });
                            }
                          }
                        });
                      }
                    });
                  },
                  child: contactListItem(index));
        },
      );
    }

    return Material(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
          leadingWidth: widget.backcheck ? 80.w : 155.w,
          centerTitle: widget.backcheck ? true : false,
          backgroundColor: AppColor.primaryColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: widget.backcheck
              ? KonetLogo(
                  logoHeight: 24.h,
                  fontSize: 19.sp,
                  textPadding: 9.w,
                  spacing: 9,
                )
              : SizedBox(),
          leading: widget.backcheck
              ? InkWell(
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
                )
              : Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: KonetLogo(
                    logoHeight: 24.h,
                    fontSize: 19.sp,
                    textPadding: 9.w,
                    spacing: 9,
                  ),
                ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/ic_conet_join.svg",
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewConetUsers(),
                  ),
                );
              },
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                ).then((value) {
                  getNotificationData();
                });
              },
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0.h),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: AppColor.whiteColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationScreen()),
                          ).then((value) {
                            getNotificationData();
                          });
                        },
                      ),
                      lengthofnotification != 0
                          ? Positioned(
                              top: 8,
                              right: 12,
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  color: AppColor.accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    lengthofnotification != 0 ? lengthofnotification.toString() : "0",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: SingleChildScrollView(
            //physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(color: AppColor.primaryColor, height: 20.h),
                Container(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  color: AppColor.primaryColor,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: SizedBox(
                          height: 36.h,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                _searchEnabled = true;
                              });

                              if (locator<StorageService>().getPrefs("conetwebpopup") == null) {
                                _showPopup();
                                locator<StorageService>().setPrefs<bool>("conetwebpopup", true);
                              }
                            },
                            child: TextField(
                              controller: _searchController,

                              onChanged: (value) {
                                // filterSearchResults(value);
                                setState(() {
                                  value.length > 1 ? _showCancelIcon = true : _showCancelIcon = false;
                                });
                              },
                              onSubmitted: (value) {
                                if (value.isEmpty) {
                                  if (_suggestionResult.isNotEmpty) {
                                    setState(() {
                                      _searchResult = _suggestionResult;
                                      _searchvisible = true;
                                    });
                                  } else {
                                    setState(() {
                                      _searchvisible = false;
                                    });
                                  }
                                } else {
                                  filterSearchResults();
                                }
                              },
                              focusNode: _focus,
                              maxLines: 1,
                              minLines: 1,
                              textAlign: TextAlign.left,
                              // enabled: false,
                              enabled: _searchEnabled,
                              style: TextStyle(
                                fontFamily: kSfproDisplayFontFamily,
                                color: AppColor.placeholder,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18.sp,
                              ),
                              textInputAction: TextInputAction.search,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: -5),
                                hintText: "Search",
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontFamily: kSfproDisplayFontFamily,
                                  color: AppColor.gray30Color,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.sp,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: InkWell(
                                  onTap: () {
                                    if (_showCancelIcon == true) {
                                      _clearText();
                                      if (_suggestionResult.isNotEmpty) {
                                        setState(() {
                                          _searchResult = _suggestionResult;
                                          _searchvisible = true;
                                        });
                                      } else {
                                        setState(() {
                                          _searchvisible = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 11.w, right: 11.w),
                                    child: Icon(
                                      _showCancelIcon ? Icons.close : Icons.search,
                                      color: AppColor.gray30Color,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.qr_code,
                                    color: AppColor.gray30Color,
                                    size: 20.w,
                                  ),
                                  onPressed: () {
                                    _checkQRPermission();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 36.w,
                        height: 36.w,
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                          heroTag: null,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          backgroundColor: AppColor.secondaryColor,
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: AppColor.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddContact(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 36.w,
                        height: 36.w,
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                          heroTag: null,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          backgroundColor: AppColor.accentColor,
                          child: SvgPicture.asset(
                            "assets/icons/ic_businesscard.svg",
                            height: 18,
                          ),
                          onPressed: () {
                            print("Cliked");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return BussinessCard();
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(color: AppColor.primaryColor, height: 20),
                _searchvisible! ? searchConetwebList() : conetWebSearchDefault(),
              ],
            ),
          ),
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

  filterSearchResults() async {
    if (_searchController!.text.isNotEmpty) {
      // var requestBody = {
      //   "filter": _searchController!.text,
      // };
      keywordvalue;
      var response =
          await ContactBloc().searchConetwebContact(FilterSearchResultsRequestBody(filter: _searchController!.text));
      var responseData = response['data'];

      if (response != null && response['status'] == true) {
        if (response['msg'] == 'yes') {
          gtm.push(GTMConstants.kkonetwebpageSearchEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
          setState(() {
            _searchResult = List<SearchContacts>.from(responseData.map((item) => SearchContacts.fromJson(item)));
            _searchvisible = true;
          });
        } else {
          Utils.displayToast("No Results Found", context);
        }
      } else {
        Utils.displayToastBottomError(response["message"], context);
      }
    } else {
      setState(() {
        _contacts = [];
        _contacts = _loadedcontacts;
      });
    }
  }

  _sentRequest(index, mutindex, type, receivername) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // var requestBody = {
    //   "value": _outputController?.text,
    //   "qrcode": false,
    //   "content": "${preferences.getString("name")} request to ${_searchResult[index].mutualList![mutindex].name}",
    //   "viaid": _searchResult[index].viaId
    // };

    var response = await ContactBloc().sendQrValue(QrValueRequestBody(
        value: _outputController?.text,
        qrcode: false,
        content: "${preferences.getString("name")} request to ${receivername}",
        viaid: _searchResult[index].viaId));

    if (response['status'] == true) {
      Utils.displayToast("Request Sent successfully", context);
      setState(() {
        if (type == "parent") {
          _searchResult[index].status = 'requested';
        } else {
          _searchResult[index].mutualList![mutindex].status = 'requested';
        }
      });
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToastBottomError('Token is Expired', context);
      tokenExpired(context);
    } else {
      Utils.displayToastBottomError('Something went wrong', context);
    }
  }

  _popupSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getBool("conetwebpopup") != null) {
      setState(() {
        _searchEnabled = true;
      });
    }
  }

//QRscanner Start
  _checkQRPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      scanQrCode();
    } else {
      var reqStatus = await Permission.camera.request();
      if (reqStatus.isGranted) {
        scanQrCode();
      } else if (reqStatus.isDenied) {
        Utils.displayToastBottomError("Permission Denied", context);
      }
    }
  }

  scanQrCode() async {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => const QRScreen(),
    ))
        .then((value) {
      if (value != null) {
        setState(() {
          _outputController!.clear();
          _outputController!.text = value!;
        });
        if (_outputController!.text != '') {
          setState(() {
            _loader = true;
          });
          _sendQrApi();
        }
      }
    });

    // String? barcode = await scanner.scan();
    // setState(() {
    //   _outputController!.clear();
    //   _outputController!.text = barcode!;
    // });
    // if (_outputController!.text != '') {
    //   setState(() {
    //     _loader = true;
    //   });
    //   _sendQrApi();
    // }
  }

  _sendQrApi() async {
    //var requestBody = {"value": _outputController!.text, "qrcode": true};
    var Qrresponse = await ContactBloc().sendQrValue(QrValueRequestBody(
      value: _outputController?.text,
      qrcode: false,
    ));
    var contactDetail;

    if (Qrresponse['status'] == true) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: "Scanned successfully",
      );
      //Utils.displayToast("Scanned successfully", context);
      try {
        // var requestBody = {
        //   "phone": _outputController!.text,
        // };
        var response = await ContactBloc()
            .checkContactForAddNew(CheckContactForAddNewRequestBody(phone: Qrresponse["contact"]["phone"]));
        if (response["user"] != null) {
          contactDetail = ContactDetail.fromJson(response["user"]);
          setState(() {
            _loader = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return AddContactUserProfilePage(
                  contactDetails: contactDetail,
                  conetUser: true,
                );
              },
            ),
          );
        } else {
          setState(() {
            _loader = false;
          });
          Fluttertoast.cancel();
          Utils.displayToastTopError(response["message"], context);
        }
      } catch (e) {
        Utils.displayToastTopError("Something went wrong", context);
      }
    } else if (Qrresponse['status'] == "Token is Expired") {
      Utils.displayToastBottomError('Token is Expired', context);
      tokenExpired(context);
    } else {
      Utils.displayToastBottomError('Something went wrong', context);
    }
  }

  timeFormat(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }

  getNotificationData() async {
    try {
      var response = await ContactBloc().contactRequest();

      if (response['status'] == true) {
        // gtm.push(GTMConstants.knotificationreceivedEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
        var responseData = response['data'];
        print(responseData.length);
        if (responseData != null)
          lengthofnotification = responseData.length;
        else
          lengthofnotification = 0;
      } else {
        Utils.displayToastBottomError(response["message"], context);
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  void _clearText() {
    _searchController!.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _showCancelIcon = false;
    });
  }
}
