import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/networking/apiBaseHelper.dart';
import 'package:conet/src/localdb/database_helper.dart';

class ContactPageRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // var _allContacts;
  // List<AllContacts> _allContacts = [];

  List<AllContacts> allContacts = [];

  getallContacts() async {
    allContacts = [];
    await databaseHelper.trancateAllContacts();
    var response = await _apiBaseHelper.get("getallcontact");
    print('is getallcontact response data null : ${response['data'] == null}');
    if (response['data'] != null) {
      allContacts = List<AllContacts>.from(response['data'].map((item) => AllContacts.fromJson(item)));

      allContacts.forEach((element) async {
        await databaseHelper.insertallContact(element);
      });
    }
  }

  getLocalData() async {
    List<AllContacts> getAllcontacts = await databaseHelper.getAllcontactsList();

    return getAllcontacts;
  }

  getData() {
    return allContacts;
  }

  //getNotification
  getNotification() async {
    var response = await _apiBaseHelper.get("notification");
    return response;
  }

  contactRequestResponse(requestBody) async {
    var response = await _apiBaseHelper.post("requestedcontactresponse", requestBody);
    return response;
  }

  //GetProfileDetails
  checkContactForAddNew(requestBody) async {
    var response = await _apiBaseHelper.post("checkcontact", requestBody);
    return response;
  }

  //GetProfileDetails
  getProfileDetails(requestBody) async {
    var response = await _apiBaseHelper.post("editContact", requestBody);
    return response;
  }

  //UpdateProfile
  updateProfileDetails(requestBody) async {
    var response = await _apiBaseHelper.post("profile", requestBody);
    return response;
  }

  //UpdateProfileImage
  updateProfileImage(requestBody) async {
    var response = await _apiBaseHelper.post("uploadprofileimage", requestBody);
    return response;
  }

  //UpdateBusinessLogo
  updatebusinesslogo(requestBody) async {
    var response = await _apiBaseHelper.post("businesscardLogo", requestBody);
    return response;
  }

  //AddNewContact
  addNewContact(requestBody) async {
    var response = await _apiBaseHelper.post("addnewcontact", requestBody);
    return response;
  }

  //importContacts
  importContacts(requestBody) async {
    var response = await _apiBaseHelper.post("importcontacts", requestBody);
    return response;
  }

  //sendQrValue
  sendQrValue(requestBody) async {
    var response = await _apiBaseHelper.post("qrvalue", requestBody);
    return response;
  }

  //SearchConetwebContact
  searchConetwebContact(requestBody) async {
    var response = await _apiBaseHelper.post("search", requestBody);
    return response;
  }

  //UpdateTypeStatus
  updateTypeStatus(requestBody) async {
    var response = await _apiBaseHelper.post("changetypestatus", requestBody);
    return response;
  }

  //NewinConet
  getNewInConet() async {
    var response = await _apiBaseHelper.get("newInconet");
    return response;
  }

  getMostDailedCalls() async {
    List<RecentCalls> getMostDailedCalls = await databaseHelper.getMostDailedCalls();

    return getMostDailedCalls;
  }
}
