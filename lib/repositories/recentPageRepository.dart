import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:conet/src/localdb/database_helper.dart';

class RecentPageRepository {
  List<RecentCalls>? _data;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<CallLogEntry> allContacts = [];

  fetchData(DateTime dateTimeFrom, DateTime dateTimeTo, String? name) async {
    try {
      // Iterable<CallLogEntry> entries = await CallLog.get();
      Iterable<CallLogEntry> entries = await CallLog.query(
        dateTimeFrom: dateTimeTo,
        dateTimeTo: dateTimeFrom,
      );

      // await databaseHelper.trancateRecentContacts();

      List<CallLogEntry> list = entries.toList();
      if (_data == null) {
        _data = [];
      } else {
        _data!.clear();
      }
      print("_data.... : ${list.length}");
      for (int i = 0; i < list.length; i++) {
        print("Fordata.... : ${list[i].name}");
        RecentCalls recentCalls = RecentCalls(
            name: list[i].name.toString(),
            callType: list[i].callType.toString(),
            number: list[i].number.toString(),
            timestamp: list[i].timestamp);
        _data!.add(recentCalls);
        // await databaseHelper.insertRecentContact(recentCalls);
      }
      // _data = await databaseHelper.getRecentCalls();
    } catch (e) {
      print("Error fetchData :  $e");
      _data = [];
    }
  }

  getData() async {
    if (Platform.isIOS) {
      _data = [];
      _data = await databaseHelper.getRecentCalls();
    }
    return _data;
  }

  Future<List<RecentCalls>?> getDataBetweenDateTimes(DateTime dateTimeFrom, DateTime dateTimeTo, String? name) async {
    if (Platform.isIOS) {
      _data = [];
      _data = await databaseHelper.getRecentCallsBetweenInDateTime(dateTimeFrom, dateTimeTo, name);
    }
    return _data == null ? _data : List<RecentCalls>.from(_data!);
  }

  insertDailedCall(phoneNumber) async {
    RecentCalls recentCalls = RecentCalls(
        name: "",
        callType: "CallType.outgoing",
        number: phoneNumber.toString(),
        timestamp: DateTime.now().millisecondsSinceEpoch);
    await databaseHelper.insertRecentContact(recentCalls);
  }
}
