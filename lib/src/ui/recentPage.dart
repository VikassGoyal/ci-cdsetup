import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/src/app.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/contact/callHistoryProfile.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

import '../../bottomNavigation/bottomNavigationBloc.dart';
import 'notification.dart';

class RecentPage extends StatefulWidget {
  List<RecentCalls>? callLogs;

  RecentPage({this.callLogs}) : super();
  @override
  _RecentPageState createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  final List _loadedCallLogs = [];
  List? _searchResult = [];
  List<RecentCalls>? _callHistory = [];
  TextEditingController? _outputController;
  bool _loader = false;
  bool _showCancelIcon = false;
  // final TextEditingController _textEditingController = TextEditingController();
  TextEditingController? _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    try {
      _callHistory = widget.callLogs;
    } catch (e) {
      print("RecentPageerror : $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget contactListItem(int index) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
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
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (_callHistory![index].name == "" || _callHistory![index].name == "null")
                          ? "Unknown"
                          : _callHistory![index].name!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        _callHistory![index].callType.toString() != "CallType.missed" &&
                                _callHistory![index].callType.toString() != "CallType.rejected"
                            ? _callHistory![index].callType.toString() == "CallType.incoming"
                                ? Image.asset(
                                    "assets/icons/ic_incoming_call.png",
                                    width: 10,
                                  )
                                : Image.asset(
                                    "assets/icons/ic_outcoming_call.png",
                                    width: 10,
                                  )
                            : Image.asset(
                                "assets/icons/ic_missed_call.png",
                                width: 14,
                              ),
                        const SizedBox(width: 8),
                        Text(
                          _callHistory![index].number ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              timeFormat(_callHistory![index].timestamp),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
            ),
            Visibility(
              visible: _callHistory![index].number != null,
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
                        _callHistory!.where((element) => element.number == _callHistory![index].number).toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallHistroyProfile(callLogs: data),
                      ),
                    );
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
      return Expanded(
        child: RefreshIndicator(
          color: AppColor.primaryColor,
          backgroundColor: AppColor.whiteColor,
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 3),
              () {
                BlocProvider.of<BottomNavigationBloc>(context).add(PageRefreshed(index: 1));
              },
            );
          },
          child: _callHistory == null || _callHistory!.isEmpty
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
                  itemCount: _callHistory!.length,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    );
                  },
                  itemBuilder: (context, index) {
                    return contactListItem(index);
                  },
                ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: SvgPicture.asset(
          "assets/logo.svg",
          height: 24,
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
          Container(color: AppColor.primaryColor, height: 20),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            color: AppColor.primaryColor,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 36,
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
                      style: Theme.of(context).textTheme.headline3,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: -5),
                        isDense: true,
                        hintText: "Search",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.headline3?.apply(color: AppColor.gray30Color),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIconConstraints: const BoxConstraints(maxHeight: 20),
                        prefixIcon: InkWell(
                          onTap: () {
                            if (_showCancelIcon == true) {
                              _clearText();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 11, right: 11),
                            child: Icon(
                              _showCancelIcon ? Icons.close : Icons.search,
                              color: AppColor.gray30Color,
                              size: 18,
                            ),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.qr_code,
                            color: AppColor.gray30Color,
                            size: 18,
                          ),
                          onPressed: () {
                            _checkQRPermission();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
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
                    child: const Icon(
                      Icons.add,
                      size: 18,
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
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
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
                      height: 18,
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
          Container(color: AppColor.primaryColor, height: 20),
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
        if (data.tocontact.name.toLowerCase().contains(query.toLowerCase())) {
          _searchResult!.add(data);
        }
      }

      setState(() {
        _callHistory = [];
        _callHistory = _searchResult as List<RecentCalls>?;
      });
      return;
    } else {
      setState(() {
        _callHistory = [];
        _callHistory = _loadedCallLogs as List<RecentCalls>?;
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
    var requestBody = {"value": _outputController!.text, "qrcode": true};
    var response = await ContactBloc().sendQrValue(requestBody);

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

  timeFormat(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }

  void _clearText() {
    _textEditingController!.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _showCancelIcon = false;
    });
  }
}
