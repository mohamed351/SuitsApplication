import 'dart:convert';
import "dart:async";
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constaint/constaint.dart';
import "../models/http_exception.dart";
import 'package:http/http.dart' as http;

import '../models/signUp.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;
  Timer? _authTimer = null;

  String? get token {
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> logout() async {
    _token = null;
    _expireDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    final prefes = await SharedPreferences.getInstance();
    prefes.clear();
    notifyListeners();
  }

  Future<bool> register(SignUp signUpForm) async {
    final response = await http.post(
        Uri.parse(Constaint.baseURL + "/api/Auth/register"),
        body: json.encode(signUpForm.toJson()),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw new HttpException("Faild Register");
    }
  }

  Future<void> loginUser(String phoneNumber, String password) async {
    final response = await http.post(
        Uri.parse(Constaint.baseURL + "/api/Auth/login"),
        body: json.encode({"phoneNumber": phoneNumber, "password": password}),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      print(response);
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      _token = data["token"];
      _expireDate = DateTime.parse(data["expireDate"]);
      _userId = data["userId"];
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expireDate": _expireDate!.toIso8601String()
      });
      prefs.setString("userData", userData);
    } else if (response.statusCode == 401) {
      throw new HttpException("The user name or password is wrong");
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timetoExpire = _expireDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoExpire!), logout);
  }

  Future<bool> tryAutoLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractedUserData = jsonDecode(prefs.getString("userData")!);
    final expireDate =
        DateTime.parse(extractedUserData["expireDate"] as String);
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData["token"] as String;
    _userId = extractedUserData["userId"] as String;
    _expireDate = expireDate;

    _autoLogout();
    notifyListeners();
    return true;
  }
}
