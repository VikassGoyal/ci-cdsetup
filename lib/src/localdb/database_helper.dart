import 'dart:async';
import 'dart:io';

import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  //Contact Table
  String allContactTable = 'allContacts_table';
  String colId = 'id';
  String colUserId = 'user_id';
  String colName = 'name';
  String colUserName = 'username';
  String colPhone = 'phone';
  String colEmail = 'email';
  String colProfileImage = 'profile_image';
  String colcompany = 'company';
  String contactMetaId = 'contact_meta_id';
  String contactMetaType = 'contact_meta_type';
  String fromContactMetaType = 'from_contact_meta_type';
  String personalAccess = 'personal_access';

  // Recent Contact
  String recentCallsTable = 'recentCalls_table';
  String colRecentId = 'id';
  String colname = 'name';
  String colnumber = 'number';
  String colcallType = 'callType';
  String coltimestamp = 'timestamp';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}allContact.db';
    // await deleteDatabase(path);
    var allContactsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return allContactsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $allContactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colName TEXT, $colUserName TEXT, $colPhone TEXT, $colEmail TEXT, $colProfileImage TEXT, $colcompany TEXT, $contactMetaId INTEGER, $contactMetaType TEXT, $fromContactMetaType TEXT, $personalAccess INTEGER)');

    await db.execute(
        'CREATE TABLE $recentCallsTable($colRecentId INTEGER PRIMARY KEY AUTOINCREMENT,  $colname TEXT,  $colnumber TEXT,  $colcallType TEXT,  $coltimestamp INTEGER)');
  }

  ////////////////////////////////// CONTACTS //////////////////////////////////
  Future<List<Map<String, dynamic>>> getallContactMapList() async {
    Database db = await database;
//		var result = await db.rawQuery('SELECT * FROM $allContactTable order by $colTitle ASC');
    var result = await db.query(allContactTable, orderBy: '$colName ASC');
    return result;
  }

  // Insert Operation: Insert a allContact object to database
  Future<int> insertallContact(AllContacts allContact) async {
    Database db = await database;
    var result = await db.insert(allContactTable, allContact.toJson());
    return result;
  }

  // Update Operation: Update a allContact object and save it to database
  Future<int> updateAllContacts(AllContacts allContacts) async {
    var db = await database;
    var result = await db.update(allContactTable, allContacts.toJson(),
        where: '$colId = ?', whereArgs: [allContacts]);
    return result;
  }

  // Delete Operation: Delete a allContact object from database
  Future<int> deleteAllContacts(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $allContactTable WHERE $id = $id');
    return result;
  }

  // Delete Operation: Delete a allContact object from database
  Future<int> trancateAllContacts() async {
    var db = await database;
    int result = await db.rawDelete('DELETE FROM $allContactTable');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $allContactTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<AllContacts>> getAllcontactsList() async {
    var allcontactsMapList = await getallContactMapList();
    int count = allcontactsMapList.length;

    print("TotalRow: $count");

    List<AllContacts> allcontactsList = <AllContacts>[];
    for (int i = 0; i < count; i++) {
      allcontactsList.add(AllContacts.fromJson(allcontactsMapList[i]));
    }

    return allcontactsList;
  }

  ////////////////////////////////// RECENT CONTACT //////////////////////////////////

  Future<int> trancateRecentContacts() async {
    var db = await database;
    int result = await db.rawDelete('DELETE FROM $recentCallsTable');
    return result;
  }

  // Insert Operation: Insert a allContact object to database
  Future<int> insertRecentContact(RecentCalls recentCalls) async {
    Database db = await database;
    var result = await db.insert(recentCallsTable, recentCalls.toJson());
    return result;
  }

  Future<List<Map<String, dynamic>>> getRecentCallsMapList() async {
    Database db = await database;
    var result = await db.query(recentCallsTable,
        orderBy: '$coltimestamp DESC', limit: 1500);
    return result;
  }

  Future<List<RecentCalls>> getRecentCalls() async {
    var recentCallsMapList = await getRecentCallsMapList();
    int count = recentCallsMapList.length;
    List<RecentCalls> recentCalls = <RecentCalls>[];
    for (int i = 0; i < count; i++) {
      recentCalls.add(RecentCalls.fromJson(recentCallsMapList[i]));
    }
    return recentCalls;
  }

  Future<List<RecentCalls>> getMostDailedCalls() async {
    Database db = await database;
    var recentCallsMapList = await db.rawQuery(
        "SELECT * FROM $recentCallsTable where $colcallType = 'CallType.outgoing' GROUP BY $colnumber ORDER BY COUNT($colnumber) DESC LIMIT 5");
    int count = recentCallsMapList.length;
    List<RecentCalls> recentCalls = <RecentCalls>[];
    for (int i = 0; i < count; i++) {
      recentCalls.add(RecentCalls.fromJson(recentCallsMapList[i]));
    }
    return recentCalls;
  }
}
