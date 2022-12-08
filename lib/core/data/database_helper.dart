import 'dart:io';

import 'package:contacts_flutter/features/data/models/contacts/contact_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:contacts_flutter/core/utils/constants.dart';

class DatabaseHelper {

  static final DatabaseHelper dbProvider = DatabaseHelper();

  sql.Database? _db;
  final int _dbVersion = 1;

  Future<sql.Database> get database async {
    if (_db != null) {
      return _db!;
    }
     _db = await createDatabase();
    return _db!;
  }

  Future<sql.Database> createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, kDbName);
    var database = await sql.openDatabase(path, version: _dbVersion, onCreate: initDB, onUpgrade: upgradeDB,);
    return database;
  }

  void initDB(sql.Database database, int version) async {
    await database.execute("CREATE TABLE $kContactTable("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "name TEXT,"
        "mobile TEXT,"
        "landline TEXT,"
        "photo BLOB,"
        "favorite INTEGER"
        ")");
  }

  void upgradeDB(sql.Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {}
  }

  // INSERT
  Future<int> addContact(ContactModel contactModel) async {
    var dbClient = await database;
    int result =
        await dbClient.insert(kContactTable, contactModel.toDatabase(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  //UPDATE
  Future<int> updateContact(ContactModel contactModel) async {
    var dbClient = await database;
    int result = await dbClient.update(kContactTable, contactModel.toDatabase(),
        where: "id = ?", whereArgs: [contactModel.id]);
    return result;
  }

  //DELETE
  Future<int> deleteContact(int id) async {
    var dbClient = await database;
    int result =
        await dbClient.delete(kContactTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //GET all contacts
  Future<List<ContactModel>> getAllContacts(
      {required List<String> columns,
      required String columnName,
      required String order}) async {
    final dbClient = await database;

    List<dynamic> response = await dbClient.query(kContactTable,
        columns: columns, orderBy: "$columnName $order");
    if (response.isEmpty) return [];
    List<ContactModel> contacts =
        response.map((e) => ContactModel.fromDatabaseJson(e)).toList();
    return contacts;
  }

  // GET favorite contacts
  Future<List<ContactModel>> getFavoriteContacts(
      {required List<String> columns,
        required String columnName,
        required String order}) async {
    final dbClient = await database;

    List<dynamic> response = await dbClient.query(kContactTable,
        columns: columns, where: '${ContactModel.columnFavorite} = ?', whereArgs: [1], orderBy: "$columnName $order");
    if (response.isEmpty) return [];
    List<ContactModel> contacts =
    response.map((e) => ContactModel.fromDatabaseJson(e)).toList();
    return contacts;
  }

  Future close() async {
    var dbClient = await database;
    return await dbClient.close();
  }
}
