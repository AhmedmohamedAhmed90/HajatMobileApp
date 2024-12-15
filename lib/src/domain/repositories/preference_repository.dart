import 'package:shared_preferences/shared_preferences.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

class PreferenceRepository {
  PreferenceRepository(this._prefs);
  final SharedPreferences _prefs;
  static PreferenceRepository get instance => getIt<PreferenceRepository>();

  void init() {}
}
