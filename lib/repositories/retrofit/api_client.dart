import 'dart:ffi';

import 'package:conet/api_models/updateProfileDetails_request_model/updateProfileDetails_request_body.dart';
import 'package:conet/constants/constants.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/repositories/retrofit/api_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../../api_models/ filterSearchResults_request_model/ filterSearchResults_request_body.dart';
import '../../api_models/addNewContact_request_model/addNewContact_request_body.dart';
import '../../api_models/changepassword_request_model/changepassword_request_body.dart';
import '../../api_models/checkContactForAddNew_request_model/checkContactForAddNew_request_body.dart';
import '../../api_models/forgotpassword__request_model/forgotpassword_request_body.dart';
import '../../api_models/getAllContact_response_model/getAllContact_response_body.dart';
import '../../api_models/getMutualsContacts__request_model/getMutualsContact_request_body.dart';
import '../../api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import '../../api_models/getTotalCount_response_model/totalCount_response_body.dart';
import '../../api_models/konetwebpage_request_model/konetwebpage_request_body.dart';
import '../../api_models/login_request_body/login_request_body.dart';
import '../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
import '../../api_models/signup_request_body/signup_request_body.dart';
import '../../api_models/updatetypestatus_request_model/updateTypeStatus_request_body.dart';
import '../../api_models/uploadProfileImage_request_model/uploadProfileImage_request_body.dart';
import '../../api_models/uploadbusinesslogo_request_ model/uploadebusinesslogo_request_body.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  ///
  /// Auth endpoints.
  ///

  @POST(ApiConstants.login)
  Future<dynamic> login(@Body() LoginRequestBody body);

  @POST(ApiConstants.logout)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> logout();

  @POST(ApiConstants.refreshToken)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> refreshToken();

  @POST(ApiConstants.forgotPassword)
  Future<dynamic> forgotPassword(@Body() ForgotpasswordRequestBody forgotpasswordRequestBody);

  ///
  /// User endpoints.
  ///

  @POST(ApiConstants.signup)
  Future<dynamic> signup(@Body() SignupRequestBody body);

  @POST(ApiConstants.profile)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> profile(@Body() UpdateProfileDetailsRequestBody updateProfileDetailsRequestBody);

  @POST(ApiConstants.uploadprofileimage)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> uploadprofileimage(@Body() UploadProfileImageRequestBody body);

  @DELETE(ApiConstants.deleteprofileimage)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<void> deleteprofileimage();

  @POST(ApiConstants.businesscardLogo)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> businesscardLogo(@Body() UploadbusinesslogoRequestBody uploadbusinesslogoequestBody);

  @DELETE(ApiConstants.deleteBusinesscardLogo)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> deleteBusinesscardLogo(@Path('id') String id);

  @POST(ApiConstants.addnewcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> addnewcontact(@Body() AddNewContactRequestBody addNewContactRequestBod);

  @DELETE(ApiConstants.deleteContact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> deleteContact(@Path('id') String id);

  @DELETE(ApiConstants.deleteaccount)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> deleteAccount();

  @POST(ApiConstants.importcontacts)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> importcontacts(@Body() List<DeviceContactData> body);

  @GET(ApiConstants.getallcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> getallcontact();

  @POST(ApiConstants.konetuserdetail)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> konetuserdetail(@Body() KonetwebpageRequestBody konetwebpageRequestBody);

  @POST(ApiConstants.editContact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> editContact(@Body() GetProfileDetailsRequestBody getProfileDetailsRequestBody);

  @POST(ApiConstants.checkcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> checkcontact(@Body() CheckContactForAddNewRequestBody checkContactForAddNewRequestBody);
// not used yet
  @POST(ApiConstants.getcontactdetails)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> getcontactdetails(@Body() Map<String, dynamic> body);

  // not used yet
  @GET(ApiConstants.requestedcontactlist)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> requestedcontactlist(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.requestedcontactresponse)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> requestedcontactresponse(@Body() RequestContactResponseRequestBody body);

  @POST(ApiConstants.mutualcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> mutualcontact(@Body() GetMutualsContactRequestBody body);

  @POST(ApiConstants.qrvalue)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> qrvalue(@Body() QrValueRequestBody qrValueRequestBody);

  @POST(ApiConstants.search)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> search(@Body() FilterSearchResultsRequestBody filterSearchResultsRequestBody);

  @POST(ApiConstants.changetypestatus)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> changetypestatus(@Body() UpdateTypeStatusRequestBody updateTypeStatusRequestBody);

  @GET(ApiConstants.notification)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> notification();

  @GET(ApiConstants.newInconet)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> newInconet();

  @GET(ApiConstants.totalcount)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<TotalCountResponse> totalcount();

  @POST(ApiConstants.changepassword)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> changePassword(@Body() ChangePasswordRequestBody changePasswordrequestBody);

  @GET(ApiConstants.searchSuggestions)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> searchSuggestions();
}
