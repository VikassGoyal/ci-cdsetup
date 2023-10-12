import 'package:conet/models/allContacts.dart';
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
  const ContactsOperationsError(this.message, this.errorResult);

  final Object errorResult;
  final String message;

  @override
  List<Object> get props => [message, errorResult];
}

class SyncContactsEventSuccess extends ContactsOperationsState {
  final List<AllContacts> contactsDataList;
  final List<AllContacts> loadedContactsDataList;
  final bool isUpdatingAfterContactsSync;

  const SyncContactsEventSuccess({
    required this.contactsDataList,
    required this.loadedContactsDataList,
    required this.isUpdatingAfterContactsSync,
  });

  @override
  List<Object> get props => [contactsDataList, loadedContactsDataList];
}
