import 'dart:async';
import 'dart:io';

import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api_models/getTotalCount_response_model/totalCount_response_body.dart';

part 'bottomNavigationEvent.dart';
part 'bottomNavigationState.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc(
      {required this.contactPageRepository,
      required this.keypadPageRepository,
      required this.conetWebPageRepository,
      required this.settingsPageRepository})
      : super(PageLoading()) {
    on<AppStarted>((event, emit) {
      print('------------> adding PageTapped event on AppStarted event call in BottomNavigationBloc');
      add(PageTapped(index: currentIndex));
    });

    on<PageRefreshed>((event, emit) {
      print('------------> adding PageTapped event on PageRefreshed event call in BottomNavigationBloc');
      add(PageTapped(index: currentIndex));
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      // emit(CurrentIndexChanged(currentIndex: currentIndex));
      emit(PageLoading());

      if (currentIndex == 0) {
        var data = await _getContactPageData();
        emit(CoNetWebPageLoaded(conetContactObject: data));
      }
      if (currentIndex == 1) {
        var data = await _getContactPageData();

        var mostDailedContactData = await getMostDailedContacts();
        emit(ContactPageLoaded(contactObject: data, mostDailedContacts: mostDailedContactData));
      }
      if (currentIndex == 2) {
        var data = await _getKeypadPageData();
        emit(KeypadPageLoaded(contactObject: data));
      }
      if (currentIndex == 3) {
        emit(RecentPageLoaded());
      }
      if (currentIndex == 4) {
        List<TotalCountResponseData> data = await _getSettingsPageData();
        emit(SettingsPageLoaded(totalcountData: data));
      }
    });
  }

  final ContactPageRepository contactPageRepository;
  // final RecentPageRepository recentPageRepository;
  final KeypadPageRepository keypadPageRepository;
  final CoNetWebPageRepository conetWebPageRepository;
  final SettingsPageRepository settingsPageRepository;
  int currentIndex = 0;
  bool isAppLifecycleStateIsPaused = false;

  setIsAppLifecycleStateIsPausedValue(bool value) {
    isAppLifecycleStateIsPaused = value;
  }

  bool getIsAppLifecycleStateIsPausedValue() {
    return isAppLifecycleStateIsPaused;
  }

  getRemoveContactData() async {
    await contactPageRepository.getRemoveData();
  }

  Future _getContactPageData() async {
    var data = await contactPageRepository.getData();
    print("first time call fetch data ${data.length}");
    List<AllContacts> contacts = [];
    contacts.addAll(data);
    try {
      if (contacts.isEmpty) {
        await contactPageRepository.getallContacts();
        data = await contactPageRepository.getLocalData();
        contacts.addAll(data);

        print("localData12 : $contacts");
      }

      print("localData1 : ${contacts.length}");
    } catch (e) {
      print("contactpage : $e");
    }
    return contacts;
  }

  Future getMostDailedContacts() async {
    var data = await contactPageRepository.getMostDailedCalls();
    List<RecentCalls> mostDailedCalls = [];
    try {
      mostDailedCalls.addAll(data);
    } catch (e) {
      print("getMostDailedContacts : $e");
    }
    return mostDailedCalls;
  }

  Future _getKeypadPageData() async {
    var data = await contactPageRepository.getLocalData();
    List<AllContacts> contacts = [];
    contacts.addAll(data);
    return contacts;
  }

  Future<String?> _getCoNetwebPageData() async {
    String? data = conetWebPageRepository.data;
    if (data == null) {
      await conetWebPageRepository.fetchData();
      data = conetWebPageRepository.data;
    }
    return data;
  }

  Future<List<TotalCountResponseData>> _getSettingsPageData() async {
    List<TotalCountResponseData> data = [];
    try {
      TotalCountResponse response = await settingsPageRepository.fetchTotalcountData();
      print("_getSettingsPageData : ${response.data}");

      if (response.status == true) {
        data = response.data;
      } else {
        data = [];
      }
    } catch (e) {
      print("getMostDailedContacts : $e");
    }
    return data;
  }
}
