import 'package:conet/networking/apiBaseHelper.dart';

class SettingsPageRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  fetchTotalcountData() async {
    var response = await _apiBaseHelper.get("totalcount");
    return response;
  }
}
