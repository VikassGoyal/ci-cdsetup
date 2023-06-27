import 'dart:async';
import 'dart:io';

import 'package:conet/models/allContacts.dart';
import 'package:conet/models/recentCalls.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
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

  DatabaseHelper._();

  static DatabaseHelper get instance => _singleton;
  static final DatabaseHelper _singleton = DatabaseHelper._();

  // If schema changes need to be done without the breaking changes with previous app version,
  // increment the db version and write the corresponding migration in onUpdate callback.
  static const String _databaseName = '__conet.db';
  static const int _databaseVersion = 1;

  bool get isInitialized => _isInitialized;
  bool _isInitialized = false;

  late final Database _db;
  Database get database => _db;

  ///
  /// Initialise the SQLite database.
  ///
  Future<void> initialize() async {
    try {
      print('$runtimeType: Initializing the database...');

      if (_isInitialized) {
        print('$runtimeType: Database already initialized.');
        return;
      }

      late final String dbPath;
      if (Platform.isAndroid) {
        dbPath = join(await getDatabasesPath(), _databaseName);
      } else {
        dbPath = join((await getApplicationDocumentsDirectory()).path, _databaseName);
      }

      print('$runtimeType: Database path: $dbPath');

      _db = await openDatabase(
        dbPath,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: _onDowngrade,
        onOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );

      _isInitialized = true;
      print('$runtimeType: Database initialized.');
    } catch (err, stackTrace) {
      print('Error while initializing the database: $err');
      print(stackTrace);
      rethrow;
    }
  }

  ///
  /// OnCreate callback. This is called only once when the database is created for the first time.
  ///
  FutureOr<void> _onCreate(Database db, int version) async {
    print('$runtimeType: Creating the database schema...');
    await db.execute(
        'CREATE TABLE $allContactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colName TEXT, $colUserName TEXT, $colPhone TEXT, $colEmail TEXT, $colProfileImage TEXT, $colcompany TEXT, $contactMetaId INTEGER, $contactMetaType TEXT, $fromContactMetaType TEXT, $personalAccess INTEGER)');

    await db.execute(
        'CREATE TABLE $recentCallsTable($colRecentId INTEGER PRIMARY KEY AUTOINCREMENT,  $colname TEXT,  $colnumber TEXT,  $colcallType TEXT,  $coltimestamp INTEGER)');
  }

  ///
  /// OnUpgrade callback. This is called when the database version is incremented.
  /// Do schema changes here to avoid breaking changes in future app versions.
  ///
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('$runtimeType: Upgrading the database schema from $oldVersion to $newVersion...');
    if (oldVersion == 1 && newVersion == 2) {
      // Write migration code here.
    }
  }

  ///
  /// OnDowngrade callback. This is called when the database version is decremented. Write rollback migrations here.
  ///
  FutureOr<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    print('$runtimeType: Downgrading the database schema from $oldVersion to $newVersion...');
    if (oldVersion == 2 && newVersion == 1) {
      // Write rollback migration code here.
    }
  }

  ////////////////////////////////// CONTACTS //////////////////////////////////
  Future<List<Map<String, dynamic>>> getallContactMapList() async {
//		var result = await db.rawQuery('SELECT * FROM $allContactTable order by $colTitle ASC');
    var result = await database.query(allContactTable, orderBy: '$colName ASC');
    return result;
  }

  // Insert Operation: Insert a allContact object to database
  Future<int> insertallContact(AllContacts allContact) async {
    var result = await database.insert(allContactTable, allContact.toJson());
    return result;
  }

  // Update Operation: Update a allContact object and save it to database
  Future<int> updateAllContacts(AllContacts allContacts) async {
    var result =
        await database.update(allContactTable, allContacts.toJson(), where: '$colId = ?', whereArgs: [allContacts]);
    return result;
  }

  // Delete Operation: Delete a allContact object from database
  Future<int> deleteAllContacts(int id) async {
    int result = await database.rawDelete('DELETE FROM $allContactTable WHERE $id = $id');
    return result;
  }

  // Delete Operation: Delete a allContact object from database
  Future<int> trancateAllContacts() async {
    int result = await database.rawDelete('DELETE FROM $allContactTable');
    return result;
  }

  Future<int?> getCount() async {
    List<Map<String, dynamic>> x = await database.rawQuery('SELECT COUNT (*) from $allContactTable');
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
    int result = await database.rawDelete('DELETE FROM $recentCallsTable');
    return result;
  }

  // Insert Operation: Insert a allContact object to database
  Future<int> insertRecentContact(RecentCalls recentCalls) async {
    var result = await database.insert(recentCallsTable, recentCalls.toJson());
    return result;
  }

  Future<List<Map<String, dynamic>>> getRecentCallsMapList() async {
    var result = await database.query(recentCallsTable, orderBy: '$coltimestamp DESC', limit: 1500);
    return result;
  }

  Future<List<Map<String, dynamic>>> getRecentCallsBetweenInDateTimeMapList(
      DateTime dateTimeFrom, DateTime dateTimeTo, String? name) async {
    int timeFrom = dateTimeFrom.microsecondsSinceEpoch;
    int timeTo = dateTimeTo.microsecondsSinceEpoch;
    var result = await database.query(
      recentCallsTable,
      orderBy: '$coltimestamp DESC',
      limit: 1500,
      where: '$coltimestamp <= ? AND $coltimestamp >= ?',
      whereArgs: [timeFrom, timeTo],
    );
    return result;
  }

  Future<List<RecentCalls>> getRecentCallsBetweenInDateTime(
      DateTime dateTimeFrom, DateTime dateTimeTo, String? name) async {
    var recentCallsMapList = await getRecentCallsBetweenInDateTimeMapList(dateTimeFrom, dateTimeTo, name);
    int count = recentCallsMapList.length;
    List<RecentCalls> recentCalls = <RecentCalls>[];
    for (int i = 0; i < count; i++) {
      recentCalls.add(RecentCalls.fromJson(recentCallsMapList[i]));
    }
    return recentCalls;
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
    var recentCallsMapList = await database.rawQuery(
        "SELECT * FROM $recentCallsTable where $colcallType = 'CallType.outgoing' GROUP BY $colnumber ORDER BY COUNT($colnumber) DESC LIMIT 5");
    int count = recentCallsMapList.length;
    List<RecentCalls> recentCalls = <RecentCalls>[];
    for (int i = 0; i < count; i++) {
      recentCalls.add(RecentCalls.fromJson(recentCallsMapList[i]));
    }
    return recentCalls;
  }
}
