import 'package:conet/bottomNavigation/bottomNavigationBloc.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:conet/src/ui/contact/contactProfile.dart';
import 'package:conet/src/ui/contact/nonConetContactProfile.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewConetUsers extends StatefulWidget {
  const NewConetUsers({super.key});

  @override
  State<NewConetUsers> createState() => _NewConetUsersState();
}

class _NewConetUsersState extends State<NewConetUsers> {
  late final ContactPageRepository contactPageRepository;
  List<AllContacts> _contacts = [];
  bool _loader = true;

  @override
  void initState() {
    super.initState();
    _contacts = [];
    contactPageRepository = BlocProvider.of<BottomNavigationBloc>(context).contactPageRepository;
    getNewInConet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        systemOverlayStyle: StatusBarTheme.systemUiOverlayStyleOrange,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        leadingWidth: 80.w,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(false);
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
          "KoNet Joiners",
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
                  ),
                ],
              ),
            )
          : _contacts.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _contacts.length,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Theme.of(context).primaryColorLight,
                      onTap: () {
                        if (_contacts[index].userId == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NonConetContactProfile(
                                _contacts[index].name,
                                _contacts[index].phone,
                                _contacts[index].email,
                                _contacts[index].id,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactProfile(
                                  _contacts[index].phone,
                                  _contacts[index].contactMetaId,
                                  _contacts[index].contactMetaType,
                                  _contacts[index].fromContactMetaType,
                                  _contacts[index].contactMetaId),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getDateFormat(_contacts[index].contactMetaType),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: kSfproRoundedFontFamily,
                                color: AppColor.grey2.withOpacity(0.60),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.16,
                              ),
                            ),
                            Text(
                              _contacts[index].name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: kSfproDisplayFontFamily,
                                color: AppColor.blackColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.24,
                              ),
                            )
                          ],
                        ),
                        subtitle: Text(
                          "${_contacts[index].name ?? ""} joined KoNet!",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: kSfproDisplayFontFamily,
                            color: AppColor.secondaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.08,
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 46.w,
                            height: 46.w,
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
                        ),
                      ),
                    );
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
    );
  }

  getNewInConet() async {
    try {
      var response = await contactPageRepository?.getNewInConet();

      setState(() {
        _loader = false;
      });
      if (response['status']) {
        _contacts = List<AllContacts>.from(response['data'].map((item) => AllContacts.fromJson(item)));
      }
    } catch (e) {
      setState(() {
        _loader = false;
      });
      print(e);
    }
  }
}
