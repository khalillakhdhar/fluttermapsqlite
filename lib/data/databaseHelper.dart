import 'dart:io';
import 'dart:async';
import 'package:fluttermap/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  final String tableUser = "User";
  final String columnUser = "name";
  final String columnUsername = "username";
  final String columnPassword = "password";
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, flaglogged TEXT)");
    print("db created");
  }

  //insert
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    print(" état de sauvegarde " + res.toString());
    return res;
  }

  Future<User> selectUser(User user) async {
    print(" authentification");
    var dbClient = await db;

    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnUsername, columnPassword],
        where: "$columnUsername= ? and $columnPassword=?",
        whereArgs: [user.username, user.password]);
    if (maps.length > 0) {
      print("exist!");
      return user;
    } else
      return null;
  }
}
