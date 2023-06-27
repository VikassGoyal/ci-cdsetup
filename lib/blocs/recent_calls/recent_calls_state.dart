// ignore_for_file: must_be_immutable

import 'package:conet/models/recentCalls.dart';
import 'package:equatable/equatable.dart';

abstract class RecentCallsState extends Equatable {
  const RecentCallsState();

  @override
  List<Object> get props => [];
}

class RecentCallsInitial extends RecentCallsState {
  const RecentCallsInitial();
}

class GetRecentCallsLoading extends RecentCallsState {
  const GetRecentCallsLoading();
}

class GetRecentCallsError extends RecentCallsState {
  const GetRecentCallsError(this.message);

  final Object message;

  @override
  List<Object> get props => [message];
}

class GetRecentCallsSuccess extends RecentCallsState {
  final List<RecentCalls> recentCallsData;
  bool isInitialFetch;
  bool isRefreshData;
  bool isFetchedAllData;

  GetRecentCallsSuccess({
    this.isInitialFetch = false,
    this.isRefreshData = false,
    this.isFetchedAllData = false,
    required this.recentCallsData,
  });

  @override
  List<Object> get props => [recentCallsData];
}
