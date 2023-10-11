import 'package:conet/api_models/%20filterSearchResults_request_model/%20filterSearchResults_request_body.dart';
import 'package:conet/api_models/addNewContact_request_model/addNewContact_request_body.dart';
import 'package:conet/api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import 'package:conet/api_models/getMutualsContacts__request_model/getMutualsContact_request_body.dart';
import 'package:conet/api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import 'package:conet/api_models/konetwebpage_request_model/konetwebpage_request_body.dart';
import 'package:conet/api_models/qrValue_request_model/qrValue_request_body.dart';
import 'package:conet/api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
import 'package:conet/api_models/updateProfileDetails_request_model/updateProfileDetails_request_body.dart';
import 'package:conet/api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import 'package:conet/api_models/uploadProfileImage_request_model/uploadProfileImage_request_body.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_operations_event.dart';
import 'contacts_operations_state.dart';

class ContactsOperationsBloc extends Bloc<ContactsOperationsEvent, ContactsOperationsState> {
  final ContactPageRepository contactPageRepository;
  bool isImportAndSyncInProgress = false;

  ContactsOperationsBloc({required this.contactPageRepository}) : super(const ContactsOperationsInitial()) {
    on<SyncContactsEvent>((event, emit) async {
      //
    });
  }

  setIsImportAndSyncInProgressValue(bool value) {
    isImportAndSyncInProgress = value;
  }

  bool getIsImportAndSyncInProgressValue() {
    return isImportAndSyncInProgress;
  }

  contactRequest() async {
    try {
      var response = await contactPageRepository?.getNotification();
      return response;
    } catch (e) {
      print(e);
    }
  }

  deleteContact(int id) async {
    try {
      var response = await contactPageRepository?.deleteContactResponse(id);
      return response;
    } catch (e) {
      print(e);
    }
  }

  deleteAccount() async {
    try {
      var response = await contactPageRepository?.deleteAccountResponse();
      return response;
    } catch (e) {
      print(e);
    }
  }

  contactRequestResponse(RequestContactResponseRequestBody requestContactResponseRequestBody) async {
    try {
      var response = await contactPageRepository?.contactRequestResponse(requestContactResponseRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  checkContactForAddNew(CheckContactForAddNewRequestBody checkContactForAddNewRequestBody) async {
    try {
      var response = await contactPageRepository?.checkContactForAddNew(checkContactForAddNewRequestBody);
      return response;
    } catch (e) {
      print('error');
      print(e);
    }
  }

  checkContactForchangeNumber(CheckContactForAddNewRequestBody checkContactForAddNewRequestBody) async {
    try {
      var response = await contactPageRepository?.checkContactForchangeNumber(checkContactForAddNewRequestBody);
      return response;
    } catch (e) {
      print('error');
      print(e);
    }
  }

  //GetProfileDetails
  getProfileDetails(GetProfileDetailsRequestBody getProfileDetailsRequestBody) async {
    try {
      var response = await contactPageRepository?.getProfileDetails(getProfileDetailsRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  getKonetUserdetail(KonetwebpageRequestBody konetwebpageRequestBody) async {
    try {
      var response = await contactPageRepository?.getKonetUserdetail(konetwebpageRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  getMutualContacts(GetMutualsContactRequestBody getMutualsContactRequestBody) async {
    try {
      var response = await contactPageRepository?.getMutualContacts(getMutualsContactRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //UpdateProfile
  updateProfileDetails(UpdateProfileDetailsRequestBody updateProfileDetailsRequestBody) async {
    try {
      var response = await contactPageRepository?.updateProfileDetails(updateProfileDetailsRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //UpdateProfileImage
  updateProfileImage(UploadProfileImageRequestBody uploadProfileImagrequestBody) async {
    try {
      var response = await contactPageRepository?.updateProfileImage(uploadProfileImagrequestBody);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  //AddNewContact
  addNewContact(AddNewContactRequestBody addNewContactRequestBody) async {
    try {
      var response = await contactPageRepository?.addNewContact(addNewContactRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //importContacts
  importContacts(requestBody) async {
    try {
      var response = await contactPageRepository?.importContacts(requestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //AddNewContact
  sendQrValue(QrValueRequestBody qrValueRequestBody) async {
    try {
      var response = await contactPageRepository?.sendQrValue(qrValueRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //SearchConetwebContact
  searchConetwebContact(FilterSearchResultsRequestBody filterSearchResultsRequestBody) async {
    try {
      var response = await contactPageRepository?.searchConetwebContact(filterSearchResultsRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //UpdateTypeStatus
  updateTypeStatus(UpdateTypeStatusRequestBody updateTypeStatusRequestBody) async {
    try {
      var response = await contactPageRepository?.updateTypeStatus(updateTypeStatusRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
