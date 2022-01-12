import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage {
  Future<int> getModes();

  Future<bool> saveModes({required int modes});
}

class SharedPreferencesStorage implements Storage {
  static const String _modesKey = 'modes';

  final SharedPreferences sharedPreferences;

  const SharedPreferencesStorage({required this.sharedPreferences});

  @override
  Future<int> getModes() async => sharedPreferences.getInt(_modesKey) ?? 0;

  @override
  Future<bool> saveModes({required int modes}) async => sharedPreferences.setInt(_modesKey, modes);
}
