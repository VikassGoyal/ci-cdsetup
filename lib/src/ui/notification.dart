import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/blocs/contactRequest.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationResponse> notification = [];
  bool _loader = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getNotificationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget requestItem(int index) {
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
                  margin: const EdgeInsets.only(left: 12, top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/profile.png",
                      // image: "",
                      image: notification[index].profileImage != null
                          ? AppConstant.profileImageBaseUrl + notification[index].profileImage!
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getDateFormat(notification[index].createdAt),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.gray30Color,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    notification[index].name ?? notification[index].phone!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: FloatingActionButton(
                heroTag: null,
                elevation: 0,
                child: Image.asset(
                  "assets/icons/ic_notification_close.png",
                  width: 37,
                ),
                onPressed: () {
                  requestContactResponse(index, 'declined', notification[index].fromContactId);
                },
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: FloatingActionButton(
                heroTag: null,
                elevation: 0,
                child: Image.asset(
                  "assets/icons/ic_notification_tick.png",
                  width: 37,
                ),
                onPressed: () {
                  print("Cliked");
                  requestContactResponse(index, 'accept', notification[index].fromContactId);
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      );
    }

    Widget birdayItem(int index) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_notification_profile_bg.svg",
                    width: 74,
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(left: 12, top: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/profile.png",
                        image: notification[index].profileImage != null
                            ? AppConstant.profileImageBaseUrl + notification[index].profileImage!
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
                      // Text(
                      //   "",
                      //   // "21 July, 2021",
                      //   // notification[index].phone == null
                      //   //     ? "Unknown Number"
                      //   //     : notification[index].phone,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: Theme.of(context).textTheme.bodyText2.copyWith(
                      //         color: AppColor.gray30Color,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      // ),
                      Text(
                        notification[index].name ?? notification[index].phone!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        notification[index].phone ?? "Unknown Number",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: AppColor.gray30Color, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: notification[index].email != null,
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
                          Uri(scheme: 'mailto', path: notification[index].email, queryParameters: {'subject': null});
                      launch(emailLaunchUri.toString());
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: notification[index].phone != null,
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
                      callChatMessenger(notification[index].phone);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: notification[index].phone != null,
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
                      _callNumber(notification[index].phone!);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      );
    }

    Widget requestedViaContact(int index) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 12, top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/profile.png",
                      image: "",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification[index].name ?? notification[index].phone!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leadingWidth: 80.w,
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
        title: Text("Notifications",
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: kSfproRoundedFontFamily,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ),
      body: Container(
        child: _loader
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
                    ),
                  ],
                ),
              )
            : notification.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: notification.length,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1.h,
                        color: Color(0xFF757575),
                      );
                    },
                    itemBuilder: (context, index) {
                      return notification[index].type != 'Birthday'
                          ? (notification[index].type == 'Request' ? requestedViaContact(index) : requestItem(index))
                          : birdayItem(index);
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/no_data.svg",
                          height: 200.h,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "No Data",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: kSfproRoundedFontFamily,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff3F3D56)),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }

  getNotificationData() async {
    try {
      var response = await ContactBloc().contactRequest();

      setState(() {
        _loader = false;
      });
      if (response['status'] == true) {
        var responseData = response['data'];
        setState(() {
          var data = List<NotificationResponse>.from(
            responseData.map((item) => NotificationResponse.fromJson(item)),
          ).where((element) => element.name != null).toList();
          notification = data;
          print(notification);
        });
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      setState(() {
        _loader = false;
      });
      print(e);
    }
  }

  requestContactResponse(index, String type, requestContactId) async {
    try {
      var requestBody = {
        "type": type,
        "responseid": requestContactId,
      };
      var response = await ContactBloc().contactRequestResponse(requestBody);
      if (response["status"] == true) {
        setState(() {
          Utils.displayToast(response["message"]);
          notification.removeAt(index);
        });
      }
      return response;
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

  _callNumber(String phone) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phone);
    } catch (e) {
      print(e);
    }
  }
}
