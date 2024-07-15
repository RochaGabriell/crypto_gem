import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseApp extends ChangeNotifier {
  late SharedPreferences _db;

  List<Map<String, dynamic>> data = [];

  DatabaseApp() {
    _init();
  }

  _init() async {
    _db = await SharedPreferences.getInstance();
  }

  void setDatabase(String key, List<Map<String, dynamic>> data) async {
    String jsonString = jsonEncode(data);
    await _db.setString(key, jsonString);
    data = data;
    notifyListeners();
  }

  void getDatabase(String key) async {
    String? jsonString = _db.getString(key);
    List<Map<String, dynamic>> data = [];

    if (jsonString != null) {
      data = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    } else {
      data = [];
    }

    this.data = data;
    notifyListeners();
  }

  void clear(String key) {
    _db.remove(key);
    data = [];
    notifyListeners();
  }
}
