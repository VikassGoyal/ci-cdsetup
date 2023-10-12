import 'package:equatable/equatable.dart';

abstract class ContactsOperationsEvent extends Equatable {
  const ContactsOperationsEvent();

  @override
  List<Object> get props => [];
}

class SyncContactsEvent extends ContactsOperationsEvent {
  const SyncContactsEvent();
}

class UpdateContactsEvent extends ContactsOperationsEvent {
  final bool isUpdatingAfterContactsSync;
  const UpdateContactsEvent({
    this.isUpdatingAfterContactsSync = false,
  });
}
