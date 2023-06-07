import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/searchContacts.dart';
import 'package:conet/src/ui/businesscard.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/src/ui/newInConet.dart';
import 'package:conet/src/ui/notification.dart';
import 'package:conet/src/ui/qrScreen.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

class ConetWebPage extends StatefulWidget {
  var contactsData;

  ConetWebPage({this.contactsData}) : super();

  @override
  _ConetWebPageState createState() => _ConetWebPageState();
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
    _popupSettings();
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
        barrierLabel: "Label",
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
              margin: const EdgeInsets.only(left: 22, right: 22),
              padding: const EdgeInsets.only(left: 32, right: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    image: const AssetImage(
                      'assets/images/alert_conetweb.png',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "CONET Web Search",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Business Designer,  Graphic Designer, Interior Designer,  MSME, Textiles, Event Planners,  Digital marketing....",
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.placeholder),
                  ),
                  const SizedBox(height: 30),
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
                      constraints: const BoxConstraints(minHeight: 40.0, maxWidth: 100.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Got it",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
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
      print(_contacts[index].name);
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                Positioned(
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
                      "${_contacts[index].name}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: AppColor.blackColor, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${_contacts[index].name}",
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
            const SizedBox(width: 10),
            Visibility(
              visible: _contacts[index].phone != null,
              child: Container(
                width: 38,
                height: 38,
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
            const SizedBox(width: 16),
          ],
        ),
      );
    }

    Widget contactSearchListItem(int index) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (_searchResult[index].mutualList!.length > 1) {
                    _searchResult[index].visible = !_searchResult[index].visible!;
                  }
                });
              },
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
                            image: _searchResult[index].profileImage != null
                                ? AppConstant.profileImageBaseUrl + _searchResult[index].profileImage!
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
                            _searchResult[index].name ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 2),
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
                              Text(
                                (_searchResult[index].mutualList?.length == 1
                                    ? ""
                                    : " ${'(${_searchResult[index].mutualList?.length})'}"),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: AppColor.secondaryColor, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_searchResult[index].status == 'accepted'),
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
                            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_searchResult[index].status == 'requested'),
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
                            style: Theme.of(context).textTheme.button?.apply(color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_searchResult[index].status == null),
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
                            _outputController?.text = _searchResult[index].qrValue!;
                          });
                          if (_outputController?.text != '') {
                            _sentRequest(index, 0, "parent");
                          }
                        },
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 28.0, maxWidth: 70.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Connect",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button?.apply(color: AppColor.accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Visibility(
              visible: _searchResult[index].visible!,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                    itemCount: _searchResult[index].mutualList!.length,
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
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _searchResult[index].mutualList![mutindex].name ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3
                                                ?.copyWith(fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _searchResult[index].mutualList![mutindex] == null
                                                ? ""
                                                : _searchResult[index].mutualList![mutindex].via!,
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
                                          if (_outputController?.text != '') {
                                            _sentRequest(index, mutindex, "child");
                                          }
                                        },
                                        child: Container(
                                          constraints: const BoxConstraints(minHeight: 28.0, maxWidth: 70.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Connect",
                                            textAlign: TextAlign.center,
                                            style:
                                                Theme.of(context).textTheme.button?.apply(color: AppColor.accentColor),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const Image(
              image: AssetImage(
                'assets/images/conetWebDefault.png',
              ),
            ),
            const SizedBox(height: 42),
            Text(
              "CONET Web Search",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.apply(color: AppColor.placeholder),
            ),
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
          return _searchvisible! ? contactSearchListItem(index) : contactListItem(index);
        },
      );
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
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: AppColor.whiteColor,
              ),
              onPressed: () {
                // _showPopup();
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
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
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
                        child: GestureDetector(
                          onTap: () async {
                            print("success");
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                            setState(() {
                              _searchEnabled = true;
                            });

                            if (sharedPreferences.getBool("conetwebpopup") == null) {
                              _showPopup();
                              sharedPreferences.setBool("conetwebpopup", true);
                            }
                          },
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              // filterSearchResults(value);
                             setState(() {
                                value.length > 1 ? _showCancelIcon =true:
                              _showCancelIcon =false;
                             });
                            },
                            onSubmitted: (value) {
                              print(value);
                              filterSearchResults();
                            },
                            focusNode: _focus,
                            maxLines: 1,
                            minLines: 1,
                            textAlign: TextAlign.left,
                            // enabled: false,
                            enabled: _searchEnabled,
                            style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w400),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: -5),
                              hintText: "Search",
                              fillColor: Colors.white,
                              filled: true,
                              isDense: true,
                              hintStyle: Theme.of(context).textTheme.headline3?.apply(color: AppColor.gray30Color),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon:  InkWell(
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
        ));
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
      var requestBody = {
        "filter": _searchController!.text,
      };
      var response = await ContactBloc().searchConetwebContact(requestBody);
      var responseData = response['data'];

      if (response['status'] == true) {
        if (response['msg'] == 'yes') {
          setState(() {
            _searchResult = List<SearchContacts>.from(responseData.map((item) => SearchContacts.fromJson(item)));
            _searchvisible = true;
          });
        } else {
          Utils.displayToast("No Results Found");
        }
      } else {
        Utils.displayToast(response["message"]);
      }
    } else {
      setState(() {
        _contacts = [];
        _contacts = _loadedcontacts;
      });
    }
  }

  _sentRequest(index, mutindex, type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var requestBody = {
      "value": _outputController?.text,
      "qrcode": false,
      "content": "${preferences.getString("name")} request to ${_searchResult[index].mutualList![mutindex].name}",
      "viaid": _searchResult[index].viaId
    };
    var response = await ContactBloc().sendQrValue(requestBody);

    if (response['status'] == true) {
      Utils.displayToast("Request Sent successfully");
      setState(() {
        if (type == "parent") {
          _searchResult[index].status = 'requested';
        } else {
          _searchResult[index].mutualList![mutindex].status = 'requested';
        }
      });
    } else if (response['status'] == "Token is Expired") {
      Utils.displayToast('Token is Expired');
      tokenExpired(context);
    } else {
      Utils.displayToast('Something went wrong');
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
    _searchController!.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _showCancelIcon = false;
    });
  }
}
