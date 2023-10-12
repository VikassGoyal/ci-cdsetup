import 'dart:io';
import 'package:conet/blocs/contacts_operations/contacts_operations_bloc.dart';
import 'package:conet/blocs/contacts_operations/contacts_operations_event.dart';
import 'package:conet/blocs/contacts_operations/contacts_operations_state.dart';
import 'package:conet/blocs/recent_calls/recent_calls_bloc.dart';
import 'package:conet/utils/contacts_helper.dart';
import 'package:conet/utils/gtm_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:azlistview/azlistview.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
import 'package:conet/src/ui/addContactUserProfilePage.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/contact/nonConetContactProfile.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/gtm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../models/contactDetails.dart';
import 'contact/contactProfile.dart';

class ContactsPage extends StatefulWidget {
  var contactsData;
  var mostDailedContacts;
  bool? updatebool = false;

  ContactsPage({super.key, this.contactsData, this.mostDailedContacts, this.updatebool});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final RecentPageRepository recentPageRepository;
  TextEditingController? _textEditingController;
  List<AllContacts> _loadedcontacts = [];
  List<RecentCalls> recentCalls = [];
  List<AllContacts> _contacts = [];
  List<AllContacts> _searchResult = [];
  List<AllContacts> _blanklistcontacts = [];
  List<RecentCalls> _blanklistrecentCalls = [];
  // final List<DeviceContactData> _importportcontacts = [];
  TextEditingController? _outputController;
  late final ContactPageRepository contactPageRepository;
  late final FocusNode textFocusNode;
  Barcode? result;
  // QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late final ContactsOperationsBloc contactsOperationsBloc;
  bool _isContactsPageLoading = false;
  bool _isLoadingForQrCode = false;
  bool _showCancelIcon = false;
  double susItemHeight = 40;
  final gtm = Gtm.instance;
  bool updatecheck = false;
  var lengthofnotification = 0;

  @override
  void initState() {
    super.initState();
    recentPageRepository = BlocProvider.of<RecentCallsBloc>(context).recentPageRepository;
    contactsOperationsBloc = BlocProvider.of<ContactsOperationsBloc>(context);
    contactPageRepository = contactsOperationsBloc.contactPageRepository;
    var responseData = widget.contactsData ?? _blanklistcontacts;
    _textEditingController = TextEditingController();
    textFocusNode = FocusNode();
    _contacts = [];
    recentCalls = [];
    _loadedcontacts = [];
    _contacts = responseData;
    _loadedcontacts = _contacts;
    recentCalls = widget.mostDailedContacts ?? _blanklistrecentCalls;

    gtm.push(GTMConstants.kScreenViewEvent, parameters: {GTMConstants.kpageName: GTMConstants.kContactListScreen});
    updatecheck = widget.updatebool ?? false;
    if (updatecheck) {
      updatecheck = false;
      _updateContact();
    }
    _outputController = TextEditingController();

    ContactsHelper.handleAndSortContactsList(_contacts);
    getNotificationData();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkPermissionAndSyncContacts();
    });
  }

  _updateContact() {
    contactsOperationsBloc.add(const UpdateContactsEvent(isUpdatingAfterContactsSync: false));
  }

  // //QR SCAN
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     qrViewController!.pauseCamera();
  //   }
  // }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.grey[300]!, width: .5),
    );
  }

  void _clearText() {
    _textEditingController!.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    if (mounted) {
      setState(() {
        _showCancelIcon = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
    _outputController!.dispose();
    textFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 180.0 : 300.0;

    Widget contactListItem(int index) {
      return Container(
        padding: EdgeInsets.only(top: 11.h, bottom: 11.h),
        child: GestureDetector(
          onTap: () {
            textFocusNode.unfocus();
            _clearText();
            if (_contacts[index].userId == null) {
              gtm.push(GTMConstants.kcontactDetailsViewEvent,
                  parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NonConetContactProfile(_contacts[index].name ?? "", _contacts[index].phone!,
                      _contacts[index].email ?? "", _contacts[index].id),
                ),
              ).then((value) {
                print("value : $value");
                if (value) {
                  _updateContact();
                } else
                  return null;
              });
            } else {
              gtm.push(GTMConstants.kMutualContactsScreen,
                  parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactProfile(
                      _contacts[index].phone ?? "",
                      _contacts[index].contactMetaId ?? 0,
                      _contacts[index].contactMetaType ?? "",
                      _contacts[index].fromContactMetaType ?? "",
                      _contacts[index].id ?? 0),
                ),
              ).then((value) {
                if (value != null && value) {
                  _updateContact();
                } else
                  return null;
              });
            }
          },
          behavior: HitTestBehavior.translucent,
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
                        child: _contacts[index].profileImage != null
                            ? FadeInImage.assetNetwork(
                                placeholder: "assets/images/profile.png",
                                image: _contacts[index].profileImage != null
                                    ? AppConstant.profileImageBaseUrl + _contacts[index].profileImage!
                                    : "",
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  print(error);
                                  return Image.asset(
                                    "assets/images/profile.png",
                                  );
                                },
                              )
                            : Image.asset(
                                "assets/images/profile.png",
                              )),
                  ),
                  Visibility(
                    visible: _contacts[index].userId != null,
                    child: Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        child: _contacts[index].contactMetaType == "professional"
                            ? SvgPicture.asset(
                                "assets/icons/ic_blue_tick.svg",
                                height: 15,
                              )
                            : SvgPicture.asset(
                                "assets/icons/ic_green_tick.svg",
                                height: 15,
                              ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (_contacts[index].name == null || _contacts[index].name == '')
                            ? _contacts[index].phone!
                            : _contacts[index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: kSfproDisplayFontFamily,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 18.sp,
                          // letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      _contacts[index].userId != null
                          ? Text(
                              (_contacts[index].username == null || _contacts[index].username == '')
                                  ? _contacts[index].phone!
                                  : _contacts[index].username!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: kSfproRoundedFontFamily,
                                color: AppColor.gray30Color,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 13.sp,
                              ),
                            )
                          : Text(
                              (_contacts[index].phone == null ||
                                      _contacts[index].phone == "null" ||
                                      _contacts[index].phone == '')
                                  ? "Unknown Number"
                                  : _contacts[index].phone!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: kSfproRoundedFontFamily,
                                color: AppColor.gray30Color,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 13.sp,
                              ),
                            )
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
                      Uri emailLaunchUri =
                          Uri(scheme: 'mailto', path: _contacts[index].email, queryParameters: {'subject': null});
                      launch(emailLaunchUri.toString());
                    },
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Visibility(
                visible: _contacts[index].phone != null,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    heroTag: null,
                    elevation: 0,
                    child: SvgPicture.asset(
                      "assets/icons/ic_list_chat.svg",
                    ),
                    onPressed: () {
                      print("Cliked");
                      callChatMessenger(_contacts[index].phone);
                    },
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Visibility(
                visible: _contacts[index].phone != null,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    heroTag: null,
                    elevation: 0,
                    child: SvgPicture.asset(
                      "assets/icons/ic_list_call.svg",
                    ),
                    onPressed: () {
                      gtm.push(GTMConstants.kCallEvent, parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                      recentPageRepository.insertDailedCall(_contacts[index].phone!, _contacts[index].name!);
                      _callNumber(_contacts[index].phone!);
                    },
                  ),
                ),
              ),
              SizedBox(width: 25.w),
            ],
          ),
        ),
      );
    }

    Widget buildSusWidget(String susTag) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: susItemHeight,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Text(
              susTag,
              style: TextStyle(
                fontFamily: kSfproDisplayFontFamily,
                color: AppColor.placeholder,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 18.sp,
              ),
            ),
            const Expanded(
                child: Divider(
              height: .0,
              indent: 10.0,
            ))
          ],
        ),
      );
    }

    Widget buildListItem(AllContacts model, int index) {
      String susTag = model.getSuspensionTag();
      return Column(
        children: <Widget>[
          Offstage(
            offstage: model.isShowSuspension != true,
            child: buildSusWidget(susTag),
          ),
          contactListItem(index),
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w),
            child: const Divider(height: 1, color: AppColor.dividerItemColor),
          )
        ],
      );
    }

    Widget azcontactsList() {
      return RefreshIndicator(
          color: AppColor.primaryColor,
          backgroundColor: AppColor.whiteColor,
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 500), () {
              // BlocProvider.of<BottomNavigationBloc>(context).add(PageRefreshed(index: 0));
              _updateContact();
            });
          },
          child: AzListView(
            data: _contacts,
            itemCount: _contacts.length,
            itemBuilder: (BuildContext context, int index) {
              AllContacts model = _contacts[index];
              return buildListItem(model, index);
            },
            physics: const BouncingScrollPhysics(),
            indexHintBuilder: (context, hint) {
              return Container(
                alignment: Alignment.center,
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.blue[700]!.withAlpha(200),
                  shape: BoxShape.circle,
                ),
                child: Text(hint, style: const TextStyle(color: Colors.white, fontSize: 30.0)),
              );
            },
            indexBarMargin: const EdgeInsets.all(0),
          ));
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: const KonetLogo(
          logoHeight: 24,
          fontSize: 19,
          textPadding: 9,
          spacing: 9,
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
              ).then((value) {
                if (value) _updateContact();
              });
            },
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              ).then((value) {
                if (value != null && value) _updateContact();
                getNotificationData();
              });
            },
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
                        if (value != null && value) _updateContact();
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
                            decoration: const BoxDecoration(color: AppColor.accentColor, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                lengthofnotification != 0 ? lengthofnotification.toString() : "0",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<ContactsOperationsBloc, ContactsOperationsState>(listener: (context, state) {
        if (state is SyncContactsEventSuccess) {
          _isContactsPageLoading = false;
          _contacts = state.contactsDataList;
          _loadedcontacts = state.loadedContactsDataList;
          if (state.isUpdatingAfterContactsSync) {
            Utils.displayToast("Successfully imported", context);
          }
        } else if (state is ContactsOperationsLoading) {
          _isContactsPageLoading = true;
        } else if (state is ContactsOperationsError) {
          _isContactsPageLoading = false;
          String errMsg = state.message;
          if (errMsg == 'Token is Expired') {
            _isContactsPageLoading = false;
            tokenExpired(context);
          } else {
            Utils.displayToastBottomError(errMsg, context);
          }
        }
      }, buildWhen: (previous, current) {
        return true;
      }, builder: (context, state) {
        if (state is ContactsOperationsLoading) {
          _isContactsPageLoading = true;
        } else {
          _isContactsPageLoading = false;
        }
        return LoadingOverlay(
          isLoading: _isContactsPageLoading || _isLoadingForQrCode,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                color: AppColor.primaryColor,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 36.w,
                        color: AppColor.primaryColor,
                        child: TextField(
                          onTapOutside: (_) {
                            //unfocusing/hiding the soft keyboard when tapped outside of the textField
                            textFocusNode.unfocus();
                          },
                          controller: _textEditingController,
                          onChanged: (value) {
                            gtm.push(GTMConstants.kcontactSearchEvent,
                                parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                            filterSearchResults(value);
                            //
                            // _showCancelIcon = true;
                            _showCancelIcon = value.length > 1;
                            if (mounted) setState(() {});
                          },
                          focusNode: textFocusNode,
                          maxLines: 1,
                          minLines: 1,
                          textAlign: TextAlign.left,
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
                            isDense: true,
                            hintText: "Search",
                            fillColor: Colors.white,
                            filled: true,
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
                            prefixIconConstraints: const BoxConstraints(maxHeight: 20),
                            prefixIcon: InkWell(
                              onTap: () {
                                if (_showCancelIcon == true) {
                                  _clearText();
                                  restoreSearchResults();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 11.w, right: 11.w),
                                child: Icon(
                                  _showCancelIcon ? Icons.close : Icons.search,
                                  color: AppColor.gray30Color.withOpacity(0.5),
                                  size: 20.w,
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
                    SizedBox(width: 8.w),
                    Container(
                      width: 36.w,
                      height: 36.w,
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor: AppColor.secondaryColor,
                        child: Icon(
                          Icons.add,
                          size: 18.h,
                          color: AppColor.whiteColor,
                        ),
                        onPressed: () {
                          print("Cliked");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddContact(),
                            ),
                          ).then((value) {
                            if (value != null && value == true) {
                              _updateContact();
                            }
                          });
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
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor: AppColor.accentColor,
                        child: SvgPicture.asset("assets/icons/ic_businesscard.svg", height: 18.h),
                        onPressed: () {
                          print("Cliked");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return BussinessCard();
                            }),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: recentCalls.isNotEmpty,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  constraints: BoxConstraints(maxHeight: 110.h, minHeight: 110.h),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        offset: Offset(0.0, 1),
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    color: AppColor.whiteColor,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: recentCalls.length,
                      itemBuilder: (BuildContext ctxt, int i) {
                        return InkWell(
                          onTap: () {
                            gtm.push(GTMConstants.kCallEvent,
                                parameters: {GTMConstants.kstatus: GTMConstants.kstatusdone});
                            recentPageRepository.insertDailedCall(recentCalls[i].number!, recentCalls[i].name);
                            _callNumber(recentCalls[i].number!);
                          },
                          child: Container(
                            width: 80.w,
                            margin: EdgeInsets.only(top: 18.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: const AssetImage(
                                    'assets/images/userprofile_border.png',
                                  ),
                                  backgroundColor: AppColor.whiteColor,
                                  child: Container(
                                    margin: EdgeInsets.all(3.w),
                                    child: Image(
                                      height: 38.w,
                                      image: const AssetImage(
                                        'assets/images/profile_placeholder.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  (recentCalls[i].name == "" || recentCalls[i].name == "null")
                                      ? "Unknown"
                                      : recentCalls[i].name!,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              _contacts.isNotEmpty
                  ? Expanded(
                      child: azcontactsList(),
                    )
                  : Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/no_data.svg",
                              height: 130.h,
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              "No Data",
                              style: TextStyle(
                                fontFamily: kSfproRoundedFontFamily,
                                color: AppColor.black2,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
        );
      }),
    );
  }

  _callNumber(String phone) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phone);
    } catch (e) {
      print(e);
    }
  }

  void restoreSearchResults() {
    _contacts = [];
    _contacts = _loadedcontacts;
    _searchResult = [];
    if (mounted) setState(() {});
  }

  void filterSearchResults(String query) {
    print(query);
    if (query.isNotEmpty) {
      _searchResult = [];
      List<String> subQueries = query.trim().split(' ');

      bool subQueryNotPresent = false;

      for (var data in _loadedcontacts) {
        if (data.name != null) {
          if (subQueries.length == 1) {
            if (data.name!.toLowerCase().contains(subQueries[0].toLowerCase())) {
              _searchResult.add(data);
            }
          } else {
            for (var subQuery in subQueries) {
              if (!(data.name!.toLowerCase().contains(subQuery.toLowerCase()))) {
                subQueryNotPresent = true;
              }
            }
            if (!subQueryNotPresent) {
              _searchResult.add(data);
            }
          }
        }
      }
      //
      _contacts = [];
      _contacts = _searchResult;
      if (mounted) setState(() {});
      return;
    } else {
      _contacts = [];
      _contacts = _loadedcontacts;
      if (mounted) setState(() {});
    }
  }

  _checkPermissionAndSyncContacts() async {
    try {
      if (!contactsOperationsBloc.getIsImportAndSyncInProgressValue()) {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        if (preferences.getBool('imported') == false) {
          if (await checkContactsPermissions()) {
            contactsOperationsBloc.add(const SyncContactsEvent());
          }
        }
      }
    } catch (e) {
      contactsOperationsBloc.setIsImportAndSyncInProgressValue(false);
    }
  }

  Future<bool> checkContactsPermissions() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      return true;
    } else {
      var reqStatus = await Permission.contacts.request();
      if (reqStatus.isGranted || reqStatus.isLimited) {
        return true;
      } else if (reqStatus.isDenied || reqStatus.isPermanentlyDenied) {
        if (mounted) Utils.displayToastBottomError("Permission Denied for Contact Imports", context);
        return false;
      } else {
        if (mounted) Utils.displayToastBottomError("Something Went Wrong in Contact Permissions", context);
        return false;
      }
    }
  }

//QRscanner Start
  _checkQRPermission() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isGranted) {
      scanQrCode();
    } else {
      var reqStatus = await Permission.camera.request();
      print(reqStatus);
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
        _outputController!.clear();
        _outputController!.text = value!;
        if (mounted) setState(() {});
        if (_outputController!.text != '') {
          _isLoadingForQrCode = true;
          if (mounted) setState(() {});
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
    //var requestBody = {"value": _outputController?.text, "qrcode": true};
    var qrResponse = await contactsOperationsBloc.sendQrValue(QrValueRequestBody(
      value: _outputController?.text,
      qrcode: true,
    ));
    var contactDetail;
    if (qrResponse == null) {
      Utils.displayToastBottomError('Something went wrong in QR request', context);
    } else if (qrResponse['status'] == true) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: "Scanned successfully",
      );
      // setState(() {
      //   _loader = false;
      // });
      try {
        // var requestBody = {
        //   "phone": _outputController!.text,
        // };
        var response = await contactsOperationsBloc
            .checkContactForAddNew(CheckContactForAddNewRequestBody(phone: qrResponse["contact"]["phone"]));
        if (response["user"] != null) {
          contactDetail = ContactDetail.fromJson(response["user"]);
          //
          _isLoadingForQrCode = false;
          if (mounted) setState(() {});

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
          _isLoadingForQrCode = false;
          if (mounted) setState(() {});
          Fluttertoast.cancel();
          if (mounted) Utils.displayToastBottomError(response["message"], context);
        }
      } catch (e) {
        _isLoadingForQrCode = false;
        if (mounted) setState(() {});
        //Utils.displayToastBottomError("Something went wrong", context);
      }
    } else if (qrResponse['status'] == "Token is Expired") {
      if (mounted) {
        Utils.displayToastBottomError('Token is Expired', context);
        tokenExpired(context);
      }
    } else {
      if (mounted) Utils.displayToastBottomError('Something went wrong for QR', context);
    }
  }

  getNotificationData() async {
    try {
      var response = await contactsOperationsBloc.contactRequest();

      if (response == null) {
        if (mounted) Utils.displayToastBottomError('Something went wrong in getting Notifications', context);
      } else if (response['status'] == true) {
        var responseData = response['data'];
        print('notifications responseData length : ${responseData?.length ?? -1}');
        if (responseData != null) {
          lengthofnotification = responseData.length;
        } else {
          lengthofnotification = 0;
        }
      } else {
        if (mounted) Utils.displayToastBottomError(response["message"], context);
      }
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() {});
      print(e);
    }
  }

//QRscanner End
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
}
