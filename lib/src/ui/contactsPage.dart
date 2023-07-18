import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
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
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../bottomNavigation/bottomNavigationBloc.dart';
import 'contact/contactProfile.dart';

class ContactsPage extends StatefulWidget {
  var contactsData;
  var mostDailedContacts;

  ContactsPage({this.contactsData, this.mostDailedContacts}) : super();

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  TextEditingController? _textEditingController;
  List<AllContacts> _loadedcontacts = [];
  List<RecentCalls> recentCalls = [];
  List<AllContacts> _contacts = [];
  List<AllContacts> _searchResult = [];
  List<AllContacts> _blanklistcontacts = [];
  List<RecentCalls> _blanklistrecentCalls = [];
  final List<DeviceContactData> _importportcontacts = [];
  TextEditingController? _outputController;
  ContactPageRepository? contactPageRepository;
  FocusNode _focusNode = FocusNode();

  Barcode? result;
  // QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool _loader = false;
  bool _showCancelIcon = false;
  double susItemHeight = 40;

  @override
  void initState() {
    super.initState();
    contactPageRepository = ContactPageRepository();
    var responseData = widget.contactsData ?? _blanklistcontacts;
    _textEditingController = TextEditingController();
    _contacts = [];
    recentCalls = [];
    _loadedcontacts = [];
    _contacts = responseData;
    _loadedcontacts = _contacts;
    recentCalls = widget.mostDailedContacts ?? _blanklistrecentCalls;

    SchedulerBinding.instance.addPostFrameCallback((_) => _checkShowDialog());
    _outputController = TextEditingController();

    _handleList(_contacts);
  }

  // //QR SCAN
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     qrViewController!.pauseCamera();
  //   }
  // }

  // Overridden this due to Error in AZListView
  void _sortListBySuspensionTag(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      if (a.getSuspensionTag() == "@" && b.getSuspensionTag() != "@") {
        return -1;
      } else if (a.getSuspensionTag() != "@" && b.getSuspensionTag() == "@") {
        return 1;
      } else if (a.getSuspensionTag() == "#" && b.getSuspensionTag() != "#") {
        return -1;
      } else if (a.getSuspensionTag() != "#" && b.getSuspensionTag() == "#") {
        return 1;
      } else {
        return a.getSuspensionTag().compareTo(b.getSuspensionTag());
      }
    });
  }

  void _handleList(List<AllContacts> list) {
    Set<String> uniqueContacts = {};
    List<AllContacts> uniqueList = [];

    for (int i = 0; i < list.length; i++) {
      String? name = list[i].name ?? list[i].phone;
      String pinyin = PinyinHelper.getPinyinE(name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
      // Create a unique key based on name and phone
      String contactKey = '${list[i].name}${list[i].phone}';
      if (!uniqueContacts.contains(contactKey)) {
        uniqueContacts.add(contactKey); // Add the unique key to the set
        uniqueList.add(list[i]); // Add the unique contact to the unique list
      }
    }

    _sortListBySuspensionTag(uniqueList);
    uniqueList.sort((a, b) {
      final nameA = a.name?.toLowerCase() ?? '';
      final nameB = b.name?.toLowerCase() ?? '';
      return nameA.compareTo(nameB);
    });
    SuspensionUtil.setShowSuspensionStatus(uniqueList);
    // SuspensionUtil.sortListBySuspensionTag(uniqueList);

    // Update the original list with the unique list
    list.clear();
    list.addAll(uniqueList);
  }

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
    setState(() {
      _showCancelIcon = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
    _outputController!.dispose();
    _focusNode.dispose();
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
            _focusNode.unfocus();

            _clearText();
            if (_contacts[index].userId == null) {
              print(_contacts[index].id);
              print(_contacts[index].contactMetaId);

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
                print("value : $value");
                if (value) {
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
                      print("Cliked");
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

    Widget _buildSusWidget(String susTag) {
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

    Widget _buildListItem(AllContacts model, int index) {
      String susTag = model.getSuspensionTag();
      return Column(
        children: <Widget>[
          Offstage(
            offstage: model.isShowSuspension != true,
            child: _buildSusWidget(susTag),
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
              BlocProvider.of<BottomNavigationBloc>(context).add(PageRefreshed(index: 0));
              _updateContact();
            });
          },
          child: AzListView(
            data: _contacts,
            itemCount: _contacts.length,
            itemBuilder: (BuildContext context, int index) {
              AllContacts model = _contacts[index];
              return _buildListItem(model, index);
            },
            physics: const BouncingScrollPhysics(),
            indexBarData: SuspensionUtil.getTagIndexList(_contacts),
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
                print("value : $value");
                _updateContact();
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: AppColor.whiteColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              ).then((value) {
                print("value : $value");
                _updateContact();
              });
            },
          )
        ],
      ),
      body: LoadingOverlay(
        isLoading: _loader,
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
                        controller: _textEditingController,
                        onChanged: (value) {
                          filterSearchResults(value);

                          setState(() {
                            // _showCancelIcon = true;
                            value.length > 1 ? _showCancelIcon = true : _showCancelIcon = false;
                          });
                        },
                        focusNode: _focusNode,
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

  void restoreSearchResults() {
    setState(() {
      _contacts = [];
      _contacts = _loadedcontacts;
      _searchResult = [];
    });
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

      setState(() {
        _contacts = [];
        _contacts = _searchResult;
      });
      return;
    } else {
      setState(() {
        _contacts = [];
        _contacts = _loadedcontacts;
      });
    }
  }

  _checkShowDialog() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool('imported') == false) {
      _showDialog();
    }
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          backgroundColor: AppColor.whiteColor,
          title: Center(
            child: Text(
              'Confirmation',
              style: TextStyle(
                  color: AppColor.logoutcolor,
                  fontFamily: kSfproDisplayFontFamily,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: Text(
            'Do you want to import contacts to konet?',
            style: TextStyle(
                color: AppColor.logoutheadingcolor,
                fontFamily: kSfproRoundedFontFamily,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100.0.w),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        )),
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Yes',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: kSfproRoundedFontFamily,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 100.0.w),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        )),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: kSfproRoundedFontFamily,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            )
          ],
        );
      },
    ).then((value) async {
      if (value == null) return;
      if (value) {
        print(value);
        SchedulerBinding.instance.addPostFrameCallback((_) => _checkPermission());
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('imported', true);
      }
    });
  }

  _checkPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      _importContacts();
    } else {
      var reqStatus = await Permission.contacts.request();
      if (reqStatus.isGranted) {
        _importContacts();
      } else if (reqStatus.isDenied) {
        Utils.displayToast("Permission Denied");
      } else if (reqStatus.isPermanentlyDenied) {
        openAppSettings();
        Utils.displayToast("Permission Denied Permanently");
      } else {
        Utils.displayToast("Something Went Wrong ");
      }
    }
  }

  _importContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);

    for (var item in contacts) {
      if (item.phones!.toList().isNotEmpty) {
        DeviceContactData data = DeviceContactData(item.displayName, item.phones!.toList()[0].value);
        _importportcontacts.add(data);
      }
    }
    callImportApi();
  }

  callImportApi() async {
    setState(() {
      _loader = true;
    });
    try {
      var response = await ContactBloc().importContacts(_importportcontacts);
      if (response['status'] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('imported', true);
        _updateContact();
        Utils.displayToast("Successfully imported");
      } else if (response['status'] == "Token is Expired") {
        tokenExpired(context);
        setState(() {
          _loader = false;
        });
      } else {
        setState(() {
          _loader = false;
        });
        Utils.displayToast("Something went wrong");
      }
    } catch (e) {
      print(e);
      setState(() {
        _loader = false;
      });
      Utils.displayToast("Something went wrong");
    }
  }

  _updateContact() async {
    if (_loader == false) {
      setState(() {
        _loader = true;
      });
    }
    await contactPageRepository!.getallContacts();

    setState(() {
      _loader = false;
    });
    var response = contactPageRepository!.getData();

    setState(() {
      _contacts = [];
      _loadedcontacts = [];
      _contacts = response;
      _loadedcontacts = _contacts;
    });

    _handleList(_contacts);
  }

//QRscanner Start
  _checkQRPermission() async {
    print("coming");
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
        Utils.displayToast("Permission Denied");
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
    //var requestBody = {"value": _outputController?.text, "qrcode": true};
    var response = await ContactBloc().sendQrValue(QrValueRequestBody(
      value: _outputController?.text,
      qrcode: false,
    ));

    if (response['status'] == true) {
      Utils.displayToast("Scanned successfully");
      setState(() {
        _loader = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return NotificationScreen();
        }),
      );
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToast('Token is Expired');
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong');
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
