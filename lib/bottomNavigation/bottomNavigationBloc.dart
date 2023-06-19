import 'dart:async';
import 'dart:io';

import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottomNavigationEvent.dart';
part 'bottomNavigationState.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc(
      {required this.contactPageRepository,
      required this.recentPageRepository,
      required this.keypadPageRepository,
      required this.conetWebPageRepository,
      required this.settingsPageRepository})
      : super(PageLoading()) {
    on<AppStarted>((event, emit) {
      add(PageTapped(index: currentIndex));
    });

    on<PageRefreshed>((event, emit) {
      add(PageTapped(index: currentIndex));
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      emit(CurrentIndexChanged(currentIndex: currentIndex));
      emit(PageLoading());

      if (currentIndex == 0) {
        var data = await _getContactPageData();
        var mostDailedContactData = await getMostDailedContacts();
        emit(ContactPageLoaded(contactObject: data, mostDailedContacts: mostDailedContactData));
      }
      if (currentIndex == 1) {
        var data = await _getRecentPageData();
        emit(RecentPageLoaded(callLog: data));
      }
      if (currentIndex == 2) {
        var data = await _getKeypadPageData();
        emit(KeypadPageLoaded(contactObject: data));
      }
      if (currentIndex == 3) {
        var data = await _getContactPageData();
        emit(CoNetWebPageLoaded(conetContactObject: data));
      }
      if (currentIndex == 4) {
        var data = await _getSettingsPageData();
        emit(SettingsPageLoaded(totalcountData: data));
      }
    });
  }

  final ContactPageRepository contactPageRepository;
  final RecentPageRepository recentPageRepository;
  final KeypadPageRepository keypadPageRepository;
  final CoNetWebPageRepository conetWebPageRepository;
  final SettingsPageRepository settingsPageRepository;
  int currentIndex = 0;

  // @override
  // Stream<BottomNavigationState> mapEventToState(
  //     BottomNavigationEvent event) async* {
  //   // if (event is AppStarted) {}

  //   // if (event is PageTapped) {}
  // }

  Future _getContactPageData() async {
    var data = await contactPageRepository.getData();
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

  Future _getRecentPageData() async {
    try {
      var data = await recentPageRepository.getData();

      if (Platform.isAndroid) {
        // if (data == null) {
        await recentPageRepository.fetchData();
        data = await recentPageRepository.getData();
        // }
      }

      return data;
    } catch (e) {
      print("Recentpage : $e");
    }
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

  Future _getSettingsPageData() async {
    var data;
    try {
      var response = await settingsPageRepository.fetchTotalcountData();
      print("_getSettingsPageData : ${response['data']}");

      if (response['status'] == true) {
        data = response['data'];
      } else {
        data = null;
      }
    } catch (e) {
      print("getMostDailedContacts : $e");
    }
    return data;
  }
}

// class RefreshBloc extends Bloc<RefreshEvent, bool> {
//   RefreshBloc() : super(false);

//   @override
//   Stream<bool> mapEventToState(RefreshEvent event) async* {
//     if (event is RefreshData) {
//       yield true; // Indicate that refresh is in progress

//       try {
//         // Perform your data refresh logic here
//         await _fetchRecentData(); // Example: Fetch recent data from an API
//         yield false; // Indicate that refresh is complete
//       } catch (error) {
//         yield false; // Indicate that refresh failed
//         // Handle the error as per your application requirements
//       }
//     }
//   }

//   Future<void> _fetchRecentData() async {
//     // Example: Fetch recent data from an API
//     // Add your implementation here
//     try {
//       var data = await RecentPageRepository().fetchData();
//       print("Recentpage : $data");
//     } catch (e) {
//       print("Recentpage : $e");
//     }
//   }
// }

// // Define the refresh event
// abstract class RefreshEvent {
//   const RefreshEvent();

//   @override
//   List<Object> get props => [];
// }

// class RefreshData extends RefreshEvent {
//   @override
//   String toString() => 'RefreshData';
// }
