import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._privateConstructor();
  static final SharedPrefsHelper instance =
      SharedPrefsHelper._privateConstructor();

  SharedPreferences? _prefs;
  static const String _dreamPlaceKey = 'dream_place';
  static const String _visitCountKey = 'visit_count';
  static const String _hasVisitedKey = 'has_visited';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTripData({
    required String place,
    required int count,
    required bool hasVisited,
  }) async {
    if (_prefs == null) return;
    await _prefs!.setString(_dreamPlaceKey, place);
    await _prefs!.setInt(_visitCountKey, count);
    await _prefs!.setBool(_hasVisitedKey, hasVisited);
  }

  String get dreamPlace => _prefs?.getString(_dreamPlaceKey) ?? '';
  int get visitCount => _prefs?.getInt(_visitCountKey) ?? 0;
  bool get hasVisited => _prefs?.getBool(_hasVisitedKey) ?? false;
}
