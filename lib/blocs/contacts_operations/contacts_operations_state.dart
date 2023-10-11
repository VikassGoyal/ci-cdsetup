import 'package:equatable/equatable.dart';

abstract class ContactsOperationsState extends Equatable {
  const ContactsOperationsState();

  @override
  List<Object> get props => [];
}

class ContactsOperationsInitial extends ContactsOperationsState {
  const ContactsOperationsInitial();
}

class ContactsOperationsLoading extends ContactsOperationsState {
  const ContactsOperationsLoading();
}

class ContactsOperationsError extends ContactsOperationsState {
  const ContactsOperationsError(this.message);

  final Object message;

  @override
  List<Object> get props => [message];
}

class SyncContactsEventSuccess extends ContactsOperationsState {
  final List contactsData;
  // bool isInitialFetch;
  // bool isRefreshData;
  // bool isFetchedAllData;

  const SyncContactsEventSuccess({
    // this.isInitialFetch = false,
    // this.isRefreshData = false,
    // this.isFetchedAllData = false,
    required this.contactsData,
  });

  @override
  List<Object> get props => [contactsData];
}
