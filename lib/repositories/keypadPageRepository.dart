import 'package:conet/models/allContacts.dart';
import 'package:conet/src/localdb/database_helper.dart';

class KeypadPageRepository {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  String? _data;

  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _data = 'First Page';
  }

  getLocalData() async {
    List<AllContacts> getAllcontacts = await databaseHelper.getAllcontactsList();

    print("getLocalData: $getAllcontacts");
    return getAllcontacts;
  }

  String? get data => _data;
}
