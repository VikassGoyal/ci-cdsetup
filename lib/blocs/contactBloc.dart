import 'package:conet/repositories/repositories.dart';

import '../api_models/ filterSearchResults_request_model/ filterSearchResults_request_body.dart';
import '../api_models/addNewContact_request_model/addNewContact_request_body.dart';
import '../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../api_models/deleteContact__request_model/deleteContact.dart';
import '../api_models/getMutualsContacts__request_model/getMutualsContact_request_body.dart';
import '../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import '../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
import '../api_models/updateProfileDetails_request_model/updateProfileDetails_request_body.dart';
import '../api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import '../api_models/uploadProfileImage_request_model/uploadProfileImage_request_body.dart';

class ContactBloc {
  ContactPageRepository? contactPageRepository;

  ContactBloc() {
    contactPageRepository = ContactPageRepository();
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
