import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/models/contactDetails.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class SocialContact extends StatefulWidget {
  const SocialContact({Key? key}) : super(key: key);

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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.apply(color: AppColor.whiteColor),
                )
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            "Social Connect",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.apply(color: AppColor.whiteColor),
          ),
        ),
        body: _loader
            ? Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          "assets/icons/ic_social_facebook.svg",
                          height: 40,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Facebook",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(_socialFacebookText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: AppColor.gray30Color))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _socialFacebook
                                    ? AppColor.accentColor
                                    : AppColor.whiteColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _socialFacebook
                                      ? AppColor.accentColor
                                      : AppColor.gray30Color,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            _socialFacebook ? "Connected" : "  Connect   ",
                            style: TextStyle(
                              color: _socialFacebook
                                  ? AppColor.whiteColor
                                  : AppColor.gray30Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          "assets/icons/ic_social_instagram.svg",
                          height: 40,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Instagram",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(_socialInstagramText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: AppColor.gray30Color))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _socialInstagram
                                    ? AppColor.accentColor
                                    : AppColor.whiteColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _socialFacebook
                                      ? AppColor.accentColor
                                      : AppColor.gray30Color,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            _socialInstagram ? "Connected" : "  Connect   ",
                            style: TextStyle(
                              color: _socialInstagram
                                  ? AppColor.whiteColor
                                  : AppColor.gray30Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          "assets/icons/ic_social_twitter.svg",
                          height: 40,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Twitter",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(_socialTwitterText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: AppColor.gray30Color))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _socialTwitter
                                    ? AppColor.accentColor
                                    : AppColor.whiteColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _socialFacebook
                                      ? AppColor.accentColor
                                      : AppColor.gray30Color,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            _socialTwitter ? "Connected" : "  Connect   ",
                            style: TextStyle(
                              color: _socialTwitter
                                  ? AppColor.whiteColor
                                  : AppColor.gray30Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          "assets/icons/ic_social_skype.svg",
                          height: 40,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Skype",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(_socialSkypeText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: AppColor.gray30Color))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _socialSkype
                                    ? AppColor.accentColor
                                    : AppColor.whiteColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _socialFacebook
                                      ? AppColor.accentColor
                                      : AppColor.gray30Color,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            _socialSkype ? "Connected" : "  Connect   ",
                            style: TextStyle(
                              color: _socialSkype
                                  ? AppColor.whiteColor
                                  : AppColor.gray30Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 8),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
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
          _socialFacebook = contactDetail?.social?.facebook == null ||
                  contactDetail?.social?.facebook == ""
              ? false
              : true;
          _socialInstagram = contactDetail?.social?.instagram == null ||
                  contactDetail?.social?.instagram == ""
              ? false
              : true;
          _socialTwitter = contactDetail?.social?.twitter == null ||
                  contactDetail?.social?.twitter == ""
              ? false
              : true;
          _socialSkype = contactDetail?.social?.skype == null ||
                  contactDetail?.social?.skype == ""
              ? false
              : true;

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
