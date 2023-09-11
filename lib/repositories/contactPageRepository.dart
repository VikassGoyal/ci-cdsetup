import 'package:conet/api_models/updateProfileDetails_request_model/updateProfileDetails_request_body.dart';
import 'package:conet/config/app_config.dart';
import 'package:conet/constants/enums.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/interceptors/token_interceptor.dart';
import 'package:conet/repositories/retrofit/api_client.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/utils/get_it.dart';
import 'package:dio/dio.dart';

import '../api_models/ filterSearchResults_request_model/ filterSearchResults_request_body.dart';
import '../api_models/addNewContact_request_model/addNewContact_request_body.dart';
import '../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../api_models/deleteContact__request_model/deleteContact.dart';
import '../api_models/getMutualsContacts__request_model/getMutualsContact_request_body.dart';
import '../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import '../api_models/konetwebpage_request_model/konetwebpage_request_body.dart';
import '../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
import '../api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import '../api_models/uploadProfileImage_request_model/uploadProfileImage_request_body.dart';
import '../api_models/uploadbusinesslogo_request_ model/uploadebusinesslogo_request_body.dart';

class ContactPageRepository {
  ContactPageRepository() {
    final dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 7000), receiveTimeout: const Duration(milliseconds: 7000)));

    // Log requests in development.
    // if (locator<AppConfig>().environmentType == EnvironmentType.development) {
    dio.interceptors.add(
      LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true),
    );
    // }

    // Add refresh token interceptor.
    dio.interceptors.add(TokenInterceptor(dioClient: dio));
    _apiClient = ApiClient(dio, baseUrl: locator<AppConfig>().baseApiUrl);

    print('ContactPageRepository initialised');
  }

  late final ApiClient _apiClient;
  // static final _storageService = locator<StorageService>();

  // ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  List<AllContacts> allContacts = [];

  getallContacts() async {
    try {
      allContacts = [];
      await databaseHelper.trancateAllContacts();
      var response = await _apiClient.getallcontact();
      print('is getallcontact response data null : ${response['data'] == null}');
      if (response['data'] != null) {
        allContacts = List<AllContacts>.from(response['data'].map((item) => AllContacts.fromJson(item)));

        allContacts.forEach((element) async {
          await databaseHelper.insertallContact(element);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getLocalData() async {
    List<AllContacts> getAllcontacts = await databaseHelper.getAllcontactsList();

    return getAllcontacts;
  }

  getData() {
    return allContacts;
  }

  getRemoveData() {
    allContacts = [];
  }

  //getNotification
  getNotification() async {
    var response = await _apiClient.notification();
    return response;
  }

  contactRequestResponse(RequestContactResponseRequestBody requestContactResponseRequestBody) async {
    var response = await _apiClient.requestedcontactresponse(requestContactResponseRequestBody);
    return response;
  }

  //deleteContact
  deleteContactResponse(int id) async {
    var response = await _apiClient.deleteContact(id.toString());
    return response;
  }

  //GetProfileDetails
  checkContactForAddNew(CheckContactForAddNewRequestBody checkContactForAddNewRequestBody) async {
    var response = await _apiClient.checkcontact(checkContactForAddNewRequestBody);
    return response;
  }

  //GetProfileDetails
  getProfileDetails(GetProfileDetailsRequestBody getProfileDetailsRequestBody) async {
    var response = await _apiClient.editContact(getProfileDetailsRequestBody);
    return response;
  }

  //Getkonetwebpagedetail
  getKonetUserdetail(KonetwebpageRequestBody konetwebpageRequestBody) async {
    var response = await _apiClient.konetuserdetail(konetwebpageRequestBody);
    return response;
  }

  getMutualContacts(GetMutualsContactRequestBody getMutualsContactRequestBody) async {
    var response = await _apiClient.mutualcontact(getMutualsContactRequestBody);
    return response;
  }

// not implemented
  Future<void> deleteprofileimage() async {
    await _apiClient.deleteprofileimage();
  }

  //UpdateProfile
  updateProfileDetails(UpdateProfileDetailsRequestBody updateProfileDetailsRequestBody) async {
    var response = await _apiClient.profile(updateProfileDetailsRequestBody);
    return response;
  }

  //UpdateProfileImage
  updateProfileImage(UploadProfileImageRequestBody uploadProfileImagrequestBody) async {
    var response = await _apiClient.uploadprofileimage(uploadProfileImagrequestBody);
    return response;
  }

  //UpdateBusinessLogo
  updatebusinesslogo(UploadbusinesslogoRequestBody uploadbusinesslogoequestBody) async {
    var response = await _apiClient.businesscardLogo(uploadbusinesslogoequestBody);
    return response;
  }

  removeBusinessCard(String id) async {
    var response = await _apiClient.deleteBusinesscardLogo(id);
    return response;
  }

  Future<void> deleteBusinessCard(int id) async {
    await _apiClient.deleteBusinesscardLogo(id.toString());
  }

  //AddNewContact
  addNewContact(AddNewContactRequestBody addNewContactRequestBody) async {
    var response = await _apiClient.addnewcontact(addNewContactRequestBody);
    return response;
  }

  Future<void> deleteContact(int id) async {
    await _apiClient.deleteContact(id.toString());
  }

  //importContacts
  importContacts(requestBody) async {
    try {
      var response = await _apiClient.importcontacts(requestBody);
      return response;
    } catch (e) {
      return null;
    }
  }

  //sendQrValue
  sendQrValue(QrValueRequestBody qrValueRequestBody) async {
    var response = await _apiClient.qrvalue(qrValueRequestBody);
    return response;
  }

  //SearchConetwebContact
  searchConetwebContact(FilterSearchResultsRequestBody filterSearchResultsRequestBody) async {
    var response = await _apiClient.search(filterSearchResultsRequestBody);
    if (response['data'] != null) {
      List<dynamic> originalData = response["data"];
      Map<int, dynamic> groupedData = {};
      originalData.forEach((entry) {
        int id = entry["id"];
        if (groupedData[id] == null) {
          groupedData[id] = entry;
          groupedData[id]["mutual_list"] = [];
          groupedData[id]["listcount"] = 0;
        }

        groupedData[id]["mutual_list"].add({
          "id": entry["id"],
          "name": entry["name"],
          "profile_image": entry["profile_image"],
          "qr_value": entry["qr_value"],
          "email": entry["email"],
          "phone": entry["phone"],
          "via": entry["via"],
          "via_id": entry["via_id"],
          "status": entry["status"],
          "pushed": entry["pushed"],
        });

        groupedData[id]["listcount"]++;
      });

      List<dynamic> newData = groupedData.values.toList();
      response["data"] = newData;
    }
    return response;
  }

  Future<dynamic> getSearchSuggestions() async {
    final response = await _apiClient.searchSuggestions();
    if (response['data'] != null) {
      List<dynamic> originalData = response["data"];
      Map<int, dynamic> groupedData = {};
      originalData.forEach((entry) {
        int id = entry["id"];
        if (groupedData[id] == null) {
          groupedData[id] = entry;
          groupedData[id]["mutual_list"] = [];
          groupedData[id]["listcount"] = 0;
        }

        // groupedData[id]["mutual_list"].add({
        //   "id": entry["id"],
        //   "name": entry["name"],
        //   "profile_image": entry["profile_image"],
        //   "qr_value": entry["qr_value"],
        //   "email": entry["email"],
        //   "phone": entry["phone"],
        //   "via": entry["via"],
        //   "via_id": entry["via_id"],
        //   "status": entry["status"],
        //   "pushed": entry["pushed"],
        // });

        // groupedData[id]["listcount"]++;
      });

      List<dynamic> newData = groupedData.values.toList();
      response["data"] = newData;
    }
    return response;
  }

  //UpdateTypeStatus
  updateTypeStatus(UpdateTypeStatusRequestBody updateTypeStatusRequestBody) async {
    var response = await _apiClient.changetypestatus(updateTypeStatusRequestBody);
    return response;
  }

  //NewinConet
  getNewInConet() async {
    var response = await _apiClient.newInconet();
    return response;
  }

  getMostDailedCalls() async {
    List<RecentCalls> getMostDailedCalls = await databaseHelper.getMostDailedCalls();

    return getMostDailedCalls;
  }
}
