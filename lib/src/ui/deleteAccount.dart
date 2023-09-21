import 'package:conet/src/common_widgets/remove_scroll_glow.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/contactBloc.dart';
import '../../bottomNavigation/bottomNavigationBloc.dart';
import '../../utils/check_internet_connection.dart';
import '../../utils/custom_fonts.dart';
import '../localdb/database_helper.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: AppColor.whiteColor,
          ),
        ),
        title: Text(
          "Delete Account Permanently",
          style: TextStyle(
              fontSize: 18.sp, fontFamily: kSfproRoundedFontFamily, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: ScrollConfiguration(
        behavior: RemoveScrollGlow(),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Konet', // App name
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColor.whiteColor),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Text(
                  'The app is a realtime contacts book on cloud. It disrupts and replaces the pre-installed contacts app on every phone. This realtime contacts book on cloud virtually allows users to store, manage and update their contact information such as contact name, phone number, email ID, work place and social media accounts from time to time so that the User’s contacts always have updated information at all times. The App allows users to make and receive phone calls and messages as a regular phone manager. It further enables users to view and manage their call logs with their contacts in their History.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.sp, color: AppColor.whiteColor, letterSpacing: 0.2

                      // Customize the font size as needed for the paragraph
                      ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'Please rethink before deciding to delete your account. This action is irreversible and it will delete your Konet account with all of your data permanently.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  onPressed: () async {
                    print("clicked");
                    _showAlertDialog();
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0.h,
                    ),
                    alignment: Alignment.center,
                    child: Text("Delete Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: kSfproRoundedFontFamily,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0.w))),
          backgroundColor: Colors.white,
          title: Text(
            "Delete Account Permanently",
            style: TextStyle(
                color: Color(0xff3F3D56),
                fontFamily: kSfproDisplayFontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
          ),
          content: Text("Are you sure you want to delete this account permanently",
              style: TextStyle(
                  color: const Color(0xff878B95),
                  fontFamily: kSfproRoundedFontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300)),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 110.w, minHeight: 42.h),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          )),
                      child: Text("Yes",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: kSfproRoundedFontFamily,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500)),
                      onPressed: () async {
                        try {
                          bool hasInternet = await checkInternetConnection();

                          if (hasInternet) {
                            var response = await ContactBloc().deleteAccount();
                            if (response != null && response["status"] == true) {
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();

                              await databaseHelper.trancateAllContacts();
                              await databaseHelper.trancateRecentContacts();
                              BlocProvider.of<BottomNavigationBloc>(context).getRemoveContactData();

                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: 'Success',
                                text: response['message'].toString(),
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => const Login()),
                                  (Route<dynamic> route) => false);
                            }
                          }
                        } catch (e) {
                          Utils.displayToastBottomError("Account not deleted", context);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 110.w, minHeight: 42.h),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                            )),
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: kSfproRoundedFontFamily,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
