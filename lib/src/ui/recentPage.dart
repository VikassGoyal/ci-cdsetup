import 'dart:io';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/blocs/recent_calls/recent_calls_bloc.dart';
import 'package:conet/blocs/recent_calls/recent_calls_event.dart';
import 'package:conet/blocs/recent_calls/recent_calls_state.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/src/common_widgets/konet_logo.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/contact/callHistoryProfile.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import '../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../models/contactDetails.dart';
import '../../utils/custom_fonts.dart';
import 'addContactUserProfilePage.dart';
import 'notification.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});
  @override
  _RecentPageState createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  List<RecentCalls> _loadedCallLogs = [];
  List<RecentCalls> _searchResult = [];
  List<RecentCalls> _callHistory = [];
  TextEditingController? _outputController;
  bool _loader = false;
  bool _showCancelIcon = false;
  // final TextEditingController _textEditingController = TextEditingController();
  TextEditingController? _textEditingController;
  late RecentCallsBloc recentCallsBloc;
  bool _isRecentCallsLoading = false;

  bool _isFetchedAllData = false;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    try {
      recentCallsBloc = BlocProvider.of<RecentCallsBloc>(context);
      SchedulerBinding.instance.addPostFrameCallback((_) => checkPermissionAndFetchCallLogs());
    } catch (e) {
      print("RecentPageerror : $e");
    }
  }

  checkPermissionAndFetchCallLogs() async {
    if (await checkCallLogsPermissions()) {
      recentCallsBloc.add(GetRecentCallsEvent(isInitialFetch: true));
      _isRecentCallsLoading = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
  }

  // Triggers fecth() and then add new items or change _hasMore flag
  void _loadMore() {
    _isRecentCallsLoading = true;
    recentCallsBloc.add(GetRecentCallsEvent(isInitialFetch: false));
  }

  @override
  Widget build(BuildContext context) {
    Widget contactListItem(int index) {
      return Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Stack(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/profile_placeholder.png',
                      ),
                    ),
                  ),
                ),
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
                        (_callHistory[index].name == "" || _callHistory[index].name == "null")
                            ? "Unknown"
                            : _callHistory[index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: kSfproDisplayFontFamily,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        _callHistory[index].callType.toString() != "CallType.missed" &&
                                _callHistory[index].callType.toString() != "CallType.rejected"
                            ? _callHistory[index].callType.toString() == "CallType.incoming"
                                ? Image.asset(
                                    "assets/icons/ic_incoming_call.png",
                                    width: 10.w,
                                  )
                                : Image.asset(
                                    "assets/icons/ic_outcoming_call.png",
                                    width: 10.w,
                                  )
                            : Image.asset(
                                "assets/icons/ic_missed_call.png",
                                width: 14.w,
                              ),
                        SizedBox(width: 8.w),
                        Text(
                          _callHistory[index].number ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.gray30Color,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              timeFormat(_callHistory[index].timestamp),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
            ),
            Visibility(
              visible: _callHistory[index].number != null,
              child: Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  heroTag: null,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "assets/icons/ic_recent.svg",
                  ),
                  onPressed: () {
                    print("Cliked");

                    List<RecentCalls> data =
                        _callHistory.where((element) => element.number == _callHistory[index].number).toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallHistroyProfile(callLogs: data),
                      ),
                    ).then((value) {
                      if (value) {
                        checkPermissionAndFetchCallLogs();
                        return;
                      } else {
                        return;
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      );
    }

    Widget contactsList() {
      return BlocConsumer<RecentCallsBloc, RecentCallsState>(
        listener: (context, state) {
          if (state is GetRecentCallsSuccess) {
            _loadedCallLogs = state.recentCallsData;
            String searchText = _textEditingController!.text;
            if (searchText.isEmpty) {
              _callHistory = _loadedCallLogs;
            } else {
              filterSearchResults(searchText);
            }
            _isFetchedAllData = state.isFetchedAllData;
            _isRecentCallsLoading = false;
            setState(() {});
          } else if (state is GetRecentCallsLoading) {
            setState(() {});
          }
        },
        buildWhen: (previous, current) {
          return true;
        },
        builder: (context, state) {
          return Expanded(
            child: RefreshIndicator(
              color: AppColor.primaryColor,
              backgroundColor: AppColor.whiteColor,
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 3),
                  () {
                    recentCallsBloc.add(GetRecentCallsEvent(isRefreshData: true));
                    _isRecentCallsLoading = true;
                    _isFetchedAllData = false;
                  },
                );
              },
              child: _callHistory.isEmpty
                  ? Opacity(
                      opacity: 0,
                      child: ListView.separated(
                        itemCount: 0,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                          );
                        },
                        itemBuilder: (context, index) {
                          return const SizedBox.shrink();
                        },
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _isFetchedAllData ? _callHistory.length : _callHistory.length + 1,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                          color: Colors.grey.shade200,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (index >= _callHistory.length) {
                          // Don't trigger if one async loading is already under way
                          if (!_isRecentCallsLoading) {
                            _loadMore();
                          }
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              height: 30.h,
                              width: 30.h,
                              child: const CircularProgressIndicator(
                                color: AppColor.primaryColor,
                                backgroundColor: AppColor.whiteColor,
                              ),
                            ),
                          );
                        }
                        return contactListItem(index);
                      },
                    ),
            ),
          );
          // } else {
          //   return const SizedBox(
          //     height: 50,
          //     width: 50,
          //     child: Center(
          //       child: CircularProgressIndicator(
          //         color: AppColor.primaryColor,
          //       ),
          //     ),
          //   );
          // }
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        leadingWidth: 80.w,
        title: KonetLogo(
          logoHeight: 24.h,
          fontSize: 19.sp,
          textPadding: 9,
          spacing: 9,
        ),
        elevation: 0.0,
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
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            color: AppColor.primaryColor,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 36.h,
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        setState(() {
                          value.length > 1 ? _showCancelIcon = true : _showCancelIcon = false;
                        });
                        filterSearchResults(value);
                      },
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
                        prefixIconConstraints: BoxConstraints(maxHeight: 20.h),
                        prefixIcon: InkWell(
                          onTap: () {
                            if (_showCancelIcon == true) {
                              _clearText();
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
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
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
                          builder: (context) => AddContact(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.h),
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
                    backgroundColor: AppColor.accentColor,
                    child: SvgPicture.asset(
                      "assets/icons/ic_businesscard.svg",
                      height: 18.h,
                    ),
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
          contactsList()
        ],
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

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      _searchResult = [];
      for (var data in _loadedCallLogs) {
        if (data.name!.toLowerCase().contains(query.toLowerCase())) {
          _searchResult.add(data);
        }
      }

      setState(() {
        _callHistory = [];
        _callHistory = _searchResult;
      });
      return;
    } else {
      setState(() {
        _callHistory = [];
        _callHistory = _loadedCallLogs;
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

  Future<bool> checkCallLogsPermissions() async {
    if (Platform.isAndroid) {
      var status = await Permission.phone.status;
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        var newStatus = await Permission.phone.status;
        return (newStatus.isGranted || newStatus.isLimited);
      } else {
        var reqStatus = await Permission.phone.request();
        if (reqStatus.isGranted || reqStatus.isLimited) {
          return true;
        } else if (reqStatus.isDenied) {
          Utils.displayToastBottomError("Permission Denied", context);
          return false;
        } else {
          Utils.displayToastBottomError("Permission Denied", context);
          return false;
        }
      }
    } else {
      //iOS doesn't allow call log permissions
      return true;
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
      Utils.displayToast("Scanned successfully", context);
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
      Utils.displayToast('Token is Expired', context);
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong', context);
    }
  }

  timeFormat(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }

  void _clearText() {
    _textEditingController!.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    _callHistory = _loadedCallLogs;
    setState(() {
      _showCancelIcon = false;
    });
  }
}
