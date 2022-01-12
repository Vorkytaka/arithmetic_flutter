import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

// todo: это гавно, переделай!
SharedPreferences? _sharedPreferences;

SharedPreferences get sharedPreferences => _sharedPreferences!;

void main() async {
  _sharedPreferences = await SharedPreferences.getInstance();
  runApp(const App());
}
