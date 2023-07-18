import 'package:conet/constants/constants.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/repositories/retrofit/api_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../api_models/changepassword_request_model/changepassword_request_body.dart';
import '../../api_models/qrValue_request_model/qrValue_request_body.dart';
import '../../api_models/requestContactResponse_request_model.dart/requestContactResponse_request_body.dart';
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
  Future<dynamic> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> logout();

  @POST(ApiConstants.refreshToken)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> refreshToken();

  @POST(ApiConstants.forgotPassword)
  Future<dynamic> forgotPassword(@Body() Map<String, dynamic> body);

  ///
  /// User endpoints.
  ///

  @POST(ApiConstants.signup)
  Future<dynamic> signup(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.profile)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> profile(@Body() Map<String, dynamic> body);

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
  Future<dynamic> addnewcontact(@Body() Map<String, dynamic> body);

  @DELETE(ApiConstants.deleteContact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> deleteContact(@Path('id') String id);

  @POST(ApiConstants.importcontacts)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> importcontacts(@Body() List<DeviceContactData> body);

  @GET(ApiConstants.getallcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> getallcontact();

  @POST(ApiConstants.editContact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> editContact(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.checkcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> checkcontact(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.getcontactdetails)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> getcontactdetails(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.requestedcontactlist)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> requestedcontactlist(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.requestedcontactresponse)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> requestedcontactresponse(@Body() RequestContactResponseRequestBody body);

  @POST(ApiConstants.mutualcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> mutualcontact(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.qrvalue)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> qrvalue(@Body() QrValueRequestBody qrValueRequestBody);

  @POST(ApiConstants.search)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> search(@Body() Map<String, dynamic> body);

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
  Future<dynamic> totalcount();

  @POST(ApiConstants.changepassword)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> changePassword(@Body() ChangePasswordRequestBody changePasswordrequestBody);
}
