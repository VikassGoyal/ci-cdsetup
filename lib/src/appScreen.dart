import 'dart:io';

import 'package:conet/bottomNavigation/bottomNavigationBloc.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/recentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'ui/conetWebPage.dart';
import 'ui/contactsPage.dart';
import 'ui/keypadPage.dart';
import 'ui/settings/settings.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
            );
          }
          if (state is ContactPageLoaded) {
            return ContactsPage(
              contactsData: state.contactObject,
              mostDailedContacts: state.mostDailedContacts,
            );
          }
          if (state is RecentPageLoaded) {
            return RecentPage();
          }
          if (state is KeypadPageLoaded) {
            return KeypadPage(contactsData: state.contactObject);
          }
          if (state is CoNetWebPageLoaded) {
            return ConetWebPage(contactsData: state.conetContactObject);
          }
          if (state is SettingsPageLoaded) {
            return Settings(totalcount: state.totalcountData);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          return Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColor.bottomNavBgColor,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColor.secondaryColor,
              unselectedItemColor: AppColor.bottomUnselectItemColor,
              backgroundColor: AppColor.bottomNavBgColor,
              currentIndex: context.select((BottomNavigationBloc bloc) => bloc.currentIndex),
              onTap: (index) {
                final currentIndex = context.read<BottomNavigationBloc>().currentIndex;
                if (index != currentIndex) {
                  context.read<BottomNavigationBloc>().add(PageTapped(index: index));
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: context.select((BottomNavigationBloc bloc) => bloc.currentIndex) == 0
                      ? SvgPicture.asset('assets/icons/contacts_active.svg')
                      : SvgPicture.asset('assets/icons/contacts.svg'),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: context.select((BottomNavigationBloc bloc) => bloc.currentIndex) == 1
                      ? SvgPicture.asset('assets/icons/recent_active.svg')
                      : SvgPicture.asset('assets/icons/recent.svg'),
                  label: 'Recent',
                ),
                BottomNavigationBarItem(
                  icon: context.select((BottomNavigationBloc bloc) => bloc.currentIndex) == 2
                      ? SvgPicture.asset('assets/icons/keypad_active.svg')
                      : SvgPicture.asset('assets/icons/keypad.svg'),
                  label: 'Keypad',
                ),
                BottomNavigationBarItem(
                  icon: context.select((BottomNavigationBloc bloc) => bloc.currentIndex) == 3
                      ? SvgPicture.asset('assets/icons/conetweb_active.svg')
                      : SvgPicture.asset('assets/icons/conetweb.svg'),
                  label: 'KoNet web',
                ),
                BottomNavigationBarItem(
                  icon: context.select((BottomNavigationBloc bloc) => bloc.currentIndex) == 4
                      ? SvgPicture.asset('assets/icons/settings_active.svg')
                      : SvgPicture.asset('assets/icons/settings.svg'),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
