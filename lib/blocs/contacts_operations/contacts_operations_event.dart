import 'package:equatable/equatable.dart';

abstract class ContactsOperationsEvent extends Equatable {
  const ContactsOperationsEvent();

  @override
  List<Object> get props => [];
}

class SyncContactsEvent extends ContactsOperationsEvent {
  // bool isInitialFetch;
  // bool isRefreshData;
  SyncContactsEvent(
      // {
      // this.isInitialFetch = false,
      // this.isRefreshData = false,
      // }
      );
}
