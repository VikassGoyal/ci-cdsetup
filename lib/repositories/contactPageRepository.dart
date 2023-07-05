import 'package:conet/config/app_config.dart';
import 'package:conet/constants/enums.dart';
import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/repositories/interceptors/token_interceptor.dart';
import 'package:conet/repositories/retrofit/api_client.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/utils/get_it.dart';
import 'package:dio/dio.dart';

class ContactPageRepository {
  ContactPageRepository() {
    final dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 7000), receiveTimeout: const Duration(milliseconds: 7000)));

    // Log requests in development.
    if (locator<AppConfig>().environmentType == EnvironmentType.development) {
      dio.interceptors.add(
        LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true),
      );
    }

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
    allContacts = [];
    await databaseHelper.trancateAllContacts();
    var response = await _apiClient.getallcontact();

    allContacts = List<AllContacts>.from(response['data'].map((item) => AllContacts.fromJson(item)));

    allContacts.forEach((element) async {
      await databaseHelper.insertallContact(element);
    });
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
    var response = await _apiClient.notification();
    return response;
  }

  contactRequestResponse(requestBody) async {
    var response = await _apiClient.requestedcontactresponse(requestBody);
    return response;
  }

  //GetProfileDetails
  checkContactForAddNew(requestBody) async {
    var response = await _apiClient.checkcontact(requestBody);
    return response;
  }

  //GetProfileDetails
  getProfileDetails(requestBody) async {
    var response = await _apiClient.editContact(requestBody);
    return response;
  }

  //UpdateProfile
  updateProfileDetails(requestBody) async {
    var response = await _apiClient.profile(requestBody);
    return response;
  }

  //UpdateProfileImage
  updateProfileImage(requestBody) async {
    var response = await _apiClient.uploadprofileimage(requestBody);
    return response;
  }

  //UpdateBusinessLogo
  updatebusinesslogo(requestBody) async {
    var response = await _apiClient.businesscardLogo(requestBody);
    return response;
  }

  //AddNewContact
  addNewContact(requestBody) async {
    var response = await _apiClient.addnewcontact(requestBody);
    return response;
  }

  //importContacts
  importContacts(requestBody) async {
    var response = await _apiClient.importcontacts(requestBody);
    return response;
  }

  //sendQrValue
  sendQrValue(requestBody) async {
    var response = await _apiClient.qrvalue(requestBody);
    return response;
  }

  //SearchConetwebContact
  searchConetwebContact(requestBody) async {
    var response = await _apiClient.search(requestBody);
    return response;
  }

  //UpdateTypeStatus
  updateTypeStatus(requestBody) async {
    var response = await _apiClient.changetypestatus(requestBody);
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
