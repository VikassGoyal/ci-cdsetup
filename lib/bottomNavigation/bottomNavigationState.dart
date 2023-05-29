part of 'bottomNavigationBloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  const CurrentIndexChanged({required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class ContactPageLoaded extends BottomNavigationState {
  var contactObject;
  var mostDailedContacts;

  ContactPageLoaded(
      {@required this.contactObject, @required this.mostDailedContacts});
}

class RecentPageLoaded extends BottomNavigationState {
  List<RecentCalls> callLog;

  RecentPageLoaded({required this.callLog});
}

class KeypadPageLoaded extends BottomNavigationState {
  var contactObject;

  KeypadPageLoaded({@required this.contactObject});
}

class CoNetWebPageLoaded extends BottomNavigationState {
  var conetContactObject;

  CoNetWebPageLoaded({@required this.conetContactObject});
}

class SettingsPageLoaded extends BottomNavigationState {
  var totalcountData;

  SettingsPageLoaded({@required this.totalcountData});
}
