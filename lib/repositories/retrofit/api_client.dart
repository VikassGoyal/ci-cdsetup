import 'package:conet/constants/constants.dart';
import 'package:conet/models/deviceContactData.dart';
import 'package:conet/repositories/retrofit/api_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

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
  Future<dynamic> uploadprofileimage(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.businesscardLogo)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> businesscardLogo(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.addnewcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> addnewcontact(@Body() Map<String, dynamic> body);

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
  Future<dynamic> requestedcontactresponse(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.mutualcontact)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> mutualcontact(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.qrvalue)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> qrvalue(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.search)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> search(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.changetypestatus)
  @Headers(<String, dynamic>{kAuthHeaderRequired: '1'})
  Future<dynamic> changetypestatus(@Body() Map<String, dynamic> body);

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
  Future<dynamic> changePassword(@Body() Map<String, dynamic> body);
}
