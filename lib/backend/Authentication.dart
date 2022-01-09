import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';


class Authentication {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> loginUser(String email, String password) async {
    final SharedPreferences prefs = await _prefs;

    try {
      var oldEmail = prefs.getString("email");
      if (email.compareTo(oldEmail!) != 0) {
        return false;
      }
    } catch (e) {
      return false;
    }

    // Hashing password
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha1.convert(bytes);

    try {
      var oldPassword = prefs.getString("password");
      if (digest.toString().compareTo(oldPassword!) != 0) {
        return false;
      }
    } catch (e) {
      return false;
    }
    prefs.setBool("isActive", true);
    return true;
  }

  Future registerUser({email, password, username}) async {
    final SharedPreferences prefs = await _prefs;

    // Hashing password
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha1.convert(bytes);

    prefs.setString("email", email);
    prefs.setString("password", digest.toString());
    prefs.setString("username", username);
    prefs.setBool("isActive", true);
  }

  Future logoutUser() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("isActive", false);
  }

   Future<bool> isUserActive() async {
    final SharedPreferences prefs = await _prefs;

    return  prefs.getBool("isActive")!;
  }
}
