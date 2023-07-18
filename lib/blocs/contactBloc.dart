import 'package:conet/repositories/repositories.dart';

import '../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
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

  contactRequestResponse(RequestContactResponseRequestBody requestContactResponseRequestBody) async {
    try {
      var response = await contactPageRepository?.contactRequestResponse(requestContactResponseRequestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  checkContactForAddNew(requestBody) async {
    try {
      var response = await contactPageRepository?.checkContactForAddNew(requestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //GetProfileDetails
  getProfileDetails(requestBody) async {
    try {
      var response = await contactPageRepository?.getProfileDetails(requestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }

  //UpdateProfile
  updateProfileDetails(requestBody) async {
    try {
      var response = await contactPageRepository?.updateProfileDetails(requestBody);
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
  addNewContact(requestBody) async {
    try {
      var response = await contactPageRepository?.addNewContact(requestBody);
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
  searchConetwebContact(requestBody) async {
    try {
      var response = await contactPageRepository?.searchConetwebContact(requestBody);
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
