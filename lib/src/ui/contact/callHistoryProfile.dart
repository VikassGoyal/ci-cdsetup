import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/utils/textFormContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import '../utils.dart';

class CallHistroyProfile extends StatefulWidget {
  List<RecentCalls>? callLogs;

  CallHistroyProfile({this.callLogs}) : super();

  @override
  _CallHistroyProfileState createState() => _CallHistroyProfileState();
}

class _CallHistroyProfileState extends State<CallHistroyProfile> {
  final _personalNumber = TextEditingController();
  final _personalName = TextEditingController();
  List<RecentCalls>? _callHistory = [];

  ContactDetail? contactDetail;

  bool _loader = true;
  final bool _loaderoverflow = false;
  bool personalTab = true;

  @override
  void initState() {
    super.initState();
    try {
      _callHistory = widget.callLogs!;

      _personalName.text = _callHistory![0].name!;
      _personalNumber.text = _callHistory![0].number!;
      print("CallHistroyProfile : $_callHistory");
    } catch (e) {
      print("RecentPageerror : $e");
    }

    Future.delayed(Duration.zero, () {
      // getProfileDetails(widget.phoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMobileNumber() {
      return TextFormFieldContact(
        hintText: "Mobile number",
        padding: 14.0,
        readonly: true,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        onSubmitField: () {},
        controller: _personalNumber,
        parametersValidate: "Please enter Mobile number.",
      );
    }

    Widget _buildformBody() {
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Visibility(
              visible: _personalNumber.text == '' ? false : true,
              child: _buildMobileNumber(),
            ),
            const SizedBox(height: 10),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     border: Border.all(color: AppColor.dividerItemColor),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: Text(
            //           "Today",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodyText1
            //               !.apply(color: AppColor.placeholder),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(
            //             "11:26 AM",
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyText1
            //                 !.apply(color: AppColor.secondaryColor),
            //           ),
            //           SizedBox(width: 20),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Outgoing Call",
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyText1
            //                     !.apply(color: AppColor.placeholder),
            //               ),
            //               SizedBox(height: 2),
            //               Text(
            //                 "20 Minutes",
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyText1
            //                     !.apply(color: AppColor.placeholder),
            //               ),
            //             ],
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 36),
          ],
        ),
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          const SizedBox(height: 110),
          Text(
            (_personalName.text == "" || _personalName.text == "null") ? "Unknown Number" : _personalName.text,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber == null) {
                        return;
                      }
                      callChatMessenger("9566664128");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_message.svg",
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_personalNumber.text == '') {
                        return;
                      }
                      _callNumber(_personalNumber.text);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_call.svg",
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_whatsapp.svg",
                      height: 56,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/ic_profile_mail.svg",
                      height: 56,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildformBody(),
          // Positioned.fill(
          //   child:
          // ),
        ],
      );
    }

    Widget stackContainer() {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 60.0,
                color: AppColor.primaryColor,
              ),
              bodyContent()
            ],
          ),
          Positioned(
            top: 10.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
                style: Theme.of(context).textTheme.bodyText2!.apply(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Contact",
          style: Theme.of(context).textTheme.headline4!.apply(color: AppColor.whiteColor),
        ),
        actions: const [
          // PopupMenuButton(
          //   color: Color(0xFFF0F0F0),
          //   elevation: 10,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(7.0))),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //     child: Icon(
          //       Icons.more_horiz,
          //       color: AppColor.whiteColor,
          //     ),
          //   ),
          //   onSelected: (value) {},
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       child: Text(
          //         "Delete",
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyText1
          //             !.apply(color: AppColor.blackColor),
          //       ),
          //       value: 1,
          //     ),
          //     PopupMenuItem(
          //       child: Text(
          //         "Share",
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyText1
          //             !.apply(color: AppColor.blackColor),
          //       ),
          //       value: 2,
          //     ),
          //     PopupMenuItem(
          //       child: Text(
          //         "Block",
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyText1
          //             !.apply(color: AppColor.blackColor),
          //       ),
          //       value: 2,
          //     )
          //   ],
          // )
        ],
      ),
      body: _loader
          ? LoadingOverlay(
              isLoading: _loaderoverflow,
              opacity: 0.3,
              progressIndicator: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
              ),
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: stackContainer(),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
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

  getProfileDetails(String phoneNumber) async {
    try {
      // var requestBody = {
      //   "phone": phoneNumber,
      // };
      var response = await ContactBloc().getProfileDetails(GetProfileDetailsRequestBody(phone: phoneNumber));

      if (response['status'] == true) {
        contactDetail = ContactDetail.fromJson(response["user"]);
        _loader = true;

        print(contactDetail!.personal!.number);

        //Personal
        setState(() {
          _personalName.text = contactDetail!.name!;
          _personalNumber.text = contactDetail!.personal!.number!;
        });
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      print(e);
    }
  }
}
