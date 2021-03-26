import 'dart:async';
import 'package:fluttermap/models/user.dart';
import 'package:fluttermap/data/databaseHelper.dart';

class RestData {
  static final BASEURL = "";
  static final LOGIN_URL = BASEURL + "/";
  Future<User> login(String username, String password) async {
    String flagLogged = "logged";
    var user = new User(null, username, password, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null);
    userRetorno = await db.selectUser(user);
    if (userRetorno != null) {
      flagLogged = "logged";
      return new Future.value(new User(null, username, password, flagLogged));
    } else {
      flagLogged = "not";
      return new Future.value(new User(null, username, password, flagLogged));                                         
    }
  }
}
