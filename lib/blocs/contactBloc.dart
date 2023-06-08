import 'package:conet/repositories/repositories.dart';

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

  contactRequestResponse(requestBody) async {
    try {
      var response = await contactPageRepository?.contactRequestResponse(requestBody);
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
  updateProfileImage(requestBody) async {
    try {
      var response = await contactPageRepository?.updateProfileImage(requestBody);
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
  sendQrValue(requestBody) async {
    try {
      var response = await contactPageRepository?.sendQrValue(requestBody);
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
  updateTypeStatus(requestBody) async {
    try {
      var response = await contactPageRepository?.updateTypeStatus(requestBody);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
