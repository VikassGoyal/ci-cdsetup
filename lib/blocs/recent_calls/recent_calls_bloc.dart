import 'dart:io';

import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/recentPageRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recent_calls_event.dart';
import 'recent_calls_state.dart';

class RecentCallsBloc extends Bloc<RecentCallsEvent, RecentCallsState> {
  final RecentPageRepository recentPageRepository;
  late DateTime dateTimeFrom;
  late DateTime dateTimeTo;
  late DateTime cutDateTimeForRecentCallsData;
  late int cutDaysCount = 730;
  List<RecentCalls> recentCallsData = [];
  int daysGap = 5;
  bool isFetchedAllData = false;

  RecentCallsBloc({required this.recentPageRepository}) : super(const RecentCallsInitial()) {
    dateTimeFrom = DateTime.now();
    dateTimeTo = dateTimeFrom.subtract(Duration(days: daysGap));
    cutDateTimeForRecentCallsData = dateTimeFrom.subtract(Duration(days: cutDaysCount));
    on<GetRecentCallsEvent>((event, emit) async {
      emit(const GetRecentCallsLoading());

      if (event.isRefreshData) {
        dateTimeFrom = DateTime.now();
        dateTimeTo = dateTimeFrom.subtract(Duration(days: daysGap));
        recentCallsData = [];
        isFetchedAllData = false;
      } else if (!event.isInitialFetch) {
        dateTimeFrom = dateTimeTo;
        dateTimeTo = dateTimeFrom.subtract(Duration(days: daysGap));
      }
      //this function called here is reccursive
      bool isError = await fetchRecentCallsData(event);
      if (isError) {
        emit(const GetRecentCallsError('Something went wrong in getting Recent logs.'));
        return;
      }
      emit(GetRecentCallsSuccess(
        isInitialFetch: event.isInitialFetch,
        isFetchedAllData: isFetchedAllData,
        isRefreshData: event.isRefreshData,
        recentCallsData: List<RecentCalls>.from(recentCallsData),
      ));
    });
  }

  //if returns true then it means there is some error response
  Future<bool> fetchRecentCallsData(GetRecentCallsEvent event) async {
    if (cutDateTimeForRecentCallsData.isBefore(dateTimeFrom)) {
      List<RecentCalls>? _callLogs = await _getRecentPageData(dateTimeFrom, dateTimeTo, null);
      if (_callLogs == null) {
        return true;
      } else if (_callLogs.isEmpty) {
        dateTimeFrom = dateTimeTo;
        dateTimeTo = dateTimeFrom.subtract(Duration(days: daysGap));
        //reccursice call
        await fetchRecentCallsData(event);
      } else {
        if (event.isInitialFetch) {
          recentCallsData = _callLogs;
        } else {
          recentCallsData.addAll(_callLogs);
        }
      }
    } else {
      isFetchedAllData = true;
    }
    return false;
  }

  Future<List<RecentCalls>?> _getRecentPageData(DateTime dateTimeFrom, DateTime dateTimeTo, String? name) async {
    try {
      List<RecentCalls>? data = await recentPageRepository.getDataBetweenDateTimes(dateTimeFrom, dateTimeTo, name);

      if (Platform.isAndroid) {
        await recentPageRepository.fetchData(dateTimeFrom, dateTimeTo, name);
        data = await recentPageRepository.getDataBetweenDateTimes(dateTimeFrom, dateTimeTo, name);
      }

      return data;
    } catch (e) {
      print("Recentpage : $e");
    }
    return null;
  }
}
