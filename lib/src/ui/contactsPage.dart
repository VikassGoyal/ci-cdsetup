import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/contact/nonConetContactProfile.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  QRViewController? controller;
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

  //QR SCAN
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    //controller!.resumeCamera();
  }

  void _handleList(List<AllContacts> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      String? name = list[i].name ?? list[i].phone;
      String pinyin = PinyinHelper.getPinyinE(name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    SuspensionUtil.sortListBySuspensionTag(_contacts);
    SuspensionUtil.setShowSuspensionStatus(_contacts);
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
  }

  @override
  Widget build(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 180.0 : 300.0;

    Widget contactListItem(int index) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector(
          onTap: () {
            _focusNode.unfocus();

            if (_contacts[index].userId == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NonConetContactProfile(
                    _contacts[index].name!,
                    _contacts[index].phone!,
                    _contacts[index].email ?? " ",
                  ),
                ),
              ).then((value) {
                print("value : $value");
                _updateContact();
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactProfile(
                    _contacts[index].phone!,
                    _contacts[index].contactMetaId!,
                    _contacts[index].contactMetaType!,
                    _contacts[index].fromContactMetaType!,
                  ),
                ),
              ).then((value) {
                print("value : $value");
                _updateContact();
              });
            }
          },
          behavior: HitTestBehavior.translucent,
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
              const SizedBox(width: 14),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (_contacts[index].name == null || _contacts[index].name == '')
                            ? _contacts[index].phone!
                            : _contacts[index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 2),
                      _contacts[index].userId != null
                          ? Text(
                              (_contacts[index].username == null || _contacts[index].username == '')
                                  ? _contacts[index].phone!
                                  : _contacts[index].username!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
                            )
                          : Text(
                              (_contacts[index].phone == null ||
                                      _contacts[index].phone == "null" ||
                                      _contacts[index].phone == '')
                                  ? "Unknown Number"
                                  : _contacts[index].phone!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
                            )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _contacts[index].email != null,
                child: Container(
                  width: 38,
                  height: 38,
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
              const SizedBox(width: 10),
              Visibility(
                visible: _contacts[index].phone != null,
                child: Container(
                  width: 38,
                  height: 38,
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
              const SizedBox(width: 10),
              Visibility(
                visible: _contacts[index].phone != null,
                child: Container(
                  width: 38,
                  height: 38,
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
              const SizedBox(width: 30),
            ],
          ),
        ),
      );
    }

    Widget _buildSusWidget(String susTag) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        height: susItemHeight,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Text(
              susTag,
              textScaleFactor: 1.2,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: AppColor.alphaHeaderTextColor, fontWeight: FontWeight.w400),
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
            margin: const EdgeInsets.only(left: 16, right: 16),
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
        return Future.delayed(const Duration(seconds: 3), () {
            _updateContact();
            
          setState(() {
            _contacts = _contacts;
          });
        });
},
        child:AzListView(
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
            Container(color: AppColor.primaryColor, height: 20),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: AppColor.primaryColor,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 36,
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
                        style: Theme.of(context).textTheme.headline3,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: -5),
                          isDense: true,
                          hintText: "Search",
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: Theme.of(context).textTheme.headline3!.apply(color: AppColor.gray30Color),
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
                              padding: const EdgeInsets.only(left: 11, right: 11),
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
                        ).then((value) {
                          if (value != null && value == true) {
                            _updateContact();
                          }
                        });
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
            Visibility(
              visible: recentCalls.isNotEmpty,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                constraints: const BoxConstraints(maxHeight: 110, minHeight: 110.0),
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
                          width: 80,
                          margin: const EdgeInsets.only(top: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: const AssetImage(
                                  'assets/images/userprofile_border.png',
                                ),
                                backgroundColor: AppColor.whiteColor,
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  child: const Image(
                                    height: 38,
                                    image: AssetImage(
                                      'assets/images/profile_placeholder.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
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
                            height: 130,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "No Data",
                            style: Theme.of(context).textTheme.headline4!.apply(color: AppColor.blackColor),
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

  void filterSearchResults(String query) {
    print(query);
    if (query.isNotEmpty) {
      _searchResult = [];
      for (var data in _loadedcontacts) {
        if (data.name != null) {
          if (data.name!.toLowerCase().contains(query.toLowerCase())) {
            _searchResult.add(data);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          backgroundColor: AppColor.whiteColor,
          title: Text(
            'Confirmation',
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            'Do you want to import contacts to conet?',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'No',
                style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'Yes',
                style: Theme.of(context).textTheme.headline5!.apply(color: AppColor.primaryColor),
              ),
            ),
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
    var requestBody = {"value": _outputController?.text, "qrcode": true};
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
