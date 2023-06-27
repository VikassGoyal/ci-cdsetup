// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class RecentCallsEvent extends Equatable {
  const RecentCallsEvent();

  @override
  List<Object> get props => [];
}

class GetRecentCallsEvent extends RecentCallsEvent {
  bool isInitialFetch;
  bool isRefreshData;
  GetRecentCallsEvent({this.isInitialFetch = false, this.isRefreshData = false});
}
