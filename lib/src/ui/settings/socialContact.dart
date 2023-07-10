import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class SocialContact extends StatefulWidget {
  SocialContact({Key? key}) : super(key: key);

  @override
  _SocialContactState createState() => _SocialContactState();
}

class _SocialContactState extends State<SocialContact> {
  ContactDetail? contactDetail;
  bool _socialFacebook = false;
  bool _socialTwitter = false;
  bool _socialInstagram = false;
  bool _socialSkype = false;

  var _socialFacebookText = "";
  var _socialTwitterText = "";
  var _socialInstagramText = "";
  var _socialSkypeText = "";

  bool _loader = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => getProfileDetails());
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "Social Connect",
            style: TextStyle(
              fontFamily: kSfproRoundedFontFamily,
              color: AppColor.whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: _loader
            ? Container(
                padding: EdgeInsets.only(top: 19.h, bottom: 10.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 16.w),
                        SvgPicture.asset(
                          "assets/icons/ic_social_facebook.svg",
                          height: 30.w,
                          width: 30.w,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Text("Facebook",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: kSfproDisplayFontFamily,
                                      color: AppColor.blackColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Text(_socialFacebookText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: _socialTwitter ? AppColor.whiteColor : AppColor.gray30Color,
                                      fontSize: 13.sp,
                                      fontFamily: kSfproRoundedFontFamily,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                        ),
                        Container(
                          width: 110.w,
                          height: 35.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _socialFacebook ? AppColor.accentColor : AppColor.whiteColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: _socialFacebook ? AppColor.accentColor : AppColor.gray30Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              _socialFacebook ? "Connected" : "  Connect   ",
                              style: TextStyle(
                                  color: _socialFacebook ? AppColor.whiteColor : AppColor.gray30Color,
                                  fontSize: 15.sp,
                                  fontFamily: kSfCompactDisplayFontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(height: 1.h, color: Color(0xFFD7D7D7)),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SizedBox(width: 16.w),
                        SvgPicture.asset(
                          "assets/icons/ic_social_instagram.svg",
                          height: 30.w,
                          width: 30.w,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text("Instagram",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: kSfproDisplayFontFamily,
                                      color: AppColor.blackColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Text(_socialInstagramText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: _socialTwitter ? AppColor.whiteColor : AppColor.gray30Color,
                                      fontSize: 13.sp,
                                      fontFamily: kSfproRoundedFontFamily,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                        ),
                        Container(
                          width: 110.w,
                          height: 35.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _socialInstagram ? AppColor.accentColor : AppColor.whiteColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: _socialFacebook ? AppColor.accentColor : AppColor.gray30Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              _socialInstagram ? "Connected" : "  Connect   ",
                              style: TextStyle(
                                  color: _socialInstagram ? AppColor.whiteColor : AppColor.gray30Color,
                                  fontSize: 15.sp,
                                  fontFamily: kSfCompactDisplayFontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(height: 1.h, color: Color(0xFFD7D7D7)),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        SizedBox(width: 16.w),
                        SvgPicture.asset(
                          "assets/icons/ic_social_twitter.svg",
                          height: 30.w,
                          width: 30.w,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Text(
                                  "Twitter",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: kSfproDisplayFontFamily,
                                    color: AppColor.blackColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              Text(
                                _socialTwitterText ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: _socialTwitter ? AppColor.whiteColor : AppColor.gray30Color,
                                    fontSize: 13.sp,
                                    fontFamily: kSfproRoundedFontFamily,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 110.w,
                          height: 35.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _socialTwitter ? AppColor.accentColor : AppColor.whiteColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: _socialFacebook ? AppColor.accentColor : AppColor.gray30Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              _socialTwitter ? "Connected" : "  Connect   ",
                              style: TextStyle(
                                  color: _socialTwitter ? AppColor.whiteColor : AppColor.gray30Color,
                                  fontSize: 15.sp,
                                  fontFamily: kSfCompactDisplayFontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(height: 1.h, color: Color(0xFFD7D7D7)),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 16.w),
                        SvgPicture.asset(
                          "assets/icons/ic_social_skype.svg",
                          height: 30.w,
                          width: 30.w,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Text("Skype",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: kSfproDisplayFontFamily,
                                      color: AppColor.blackColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Text(
                                _socialSkypeText ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: _socialTwitter ? AppColor.whiteColor : AppColor.gray30Color,
                                    fontSize: 13.sp,
                                    fontFamily: kSfproRoundedFontFamily,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 110.w,
                          height: 35.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _socialSkype ? AppColor.accentColor : AppColor.whiteColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: _socialFacebook ? AppColor.accentColor : AppColor.gray30Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              _socialSkype ? "Connected" : "  Connect   ",
                              style: TextStyle(
                                  color: _socialSkype ? AppColor.whiteColor : AppColor.gray30Color,
                                  fontSize: 15.sp,
                                  fontFamily: kSfCompactDisplayFontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(height: 1.h, color: Color(0xFFD7D7D7)),
                    SizedBox(height: 8.h),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                ),
              ));
  }

  getProfileDetails() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var phone = preferences.getString("phone");
      var requestBody = {
        "phone": phone,
      };
      var response = await ContactBloc().getProfileDetails(requestBody);
      if (response['status'] == true) {
        contactDetail = ContactDetail.fromJson(response["user"]);
        setState(() {
          _loader = true;
          _socialFacebook =
              contactDetail?.social?.facebook == null || contactDetail?.social?.facebook == "" ? false : true;
          _socialInstagram =
              contactDetail?.social?.instagram == null || contactDetail?.social?.instagram == "" ? false : true;
          _socialTwitter =
              contactDetail?.social?.twitter == null || contactDetail?.social?.twitter == "" ? false : true;
          _socialSkype = contactDetail?.social?.skype == null || contactDetail?.social?.skype == "" ? false : true;

          _socialFacebookText = contactDetail?.social?.facebook ?? "";
          _socialTwitterText = contactDetail?.social?.twitter ?? "";
          _socialInstagramText = contactDetail?.social?.instagram ?? "";
          _socialSkypeText = contactDetail?.social?.skype ?? "";
        });
      } else {
        Utils.displayToast(response["message"]);
      }
    } catch (e) {
      print(e);
    }
  }
}
