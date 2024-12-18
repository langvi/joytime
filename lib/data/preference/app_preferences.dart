import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/shared/consts/preference_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class AppPreferences {
  AppPreferences._internal(
      this._sharedPreference, this._flutterSecureStorage, this._accessToken);
  static Future<AppPreferences> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final flutterSecureStorage = FlutterSecureStorage();
    String accessToken = await flutterSecureStorage.read(
            key: SharedPreferenceKeys.accessToken) ??
        '';
    return AppPreferences._internal(
        sharedPreferences, flutterSecureStorage, accessToken);
  }

  final SharedPreferences _sharedPreference;
  final FlutterSecureStorage _flutterSecureStorage;
  String _accessToken = '';

  // AppPreferences(this._sharedPreference, this._flutterSecureStorage);
  String get deviceToken {
    return _sharedPreference.getString(SharedPreferenceKeys.deviceToken) ?? '';
  }

  String get languageCode =>
      _sharedPreference.getString(SharedPreferenceKeys.languageCode) ?? '';
  bool get isFirstLogin =>
      _sharedPreference.getBool(SharedPreferenceKeys.isFirstLogin) ?? true;

  bool get isFirstLaunchApp =>
      _sharedPreference.getBool(SharedPreferenceKeys.isFirstLaunchApp) ?? true;
  String get accessToken {
    return _accessToken;
  }

  // Future<String> get accessToken async {
  //   if (_accessToken != null) {
  //     return _accessToken!;
  //   }
  //   _accessToken = await _flutterSecureStorage.read(
  //           key: SharedPreferenceKeys.accessToken) ??
  //       '';
  //   return _accessToken!;
  // }

  Future<String> get refreshToken async {
    return await _flutterSecureStorage.read(
            key: SharedPreferenceKeys.refreshToken) ??
        '';
  }

  String get currentUser {
    return _sharedPreference.getString(SharedPreferenceKeys.currentUser) ?? '';
  }

  String get currentUsername {
    return _sharedPreference.getString(SharedPreferenceKeys.currentUsername) ??
        '';
  }

  int get currentUserId {
    return _sharedPreference.getInt(SharedPreferenceKeys.currentUserId) ?? -1;
  }

  bool get isLoggedIn {
    final token =
        _sharedPreference.getString(SharedPreferenceKeys.accessToken) ?? '';

    return token.isNotEmpty;
  }

  Future<bool> saveLanguageCode(String languageCode) async {
    return await _sharedPreference.setString(
        SharedPreferenceKeys.languageCode, languageCode);
  }

  Future<bool> saveIsFirstLogin(bool isFirstLogin) async {
    return await _sharedPreference.setBool(
        SharedPreferenceKeys.isFirstLogin, isFirstLogin);
  }

  Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) async {
    return await _sharedPreference.setBool(
        SharedPreferenceKeys.isFirstLaunchApp, isFirstLaunchApp);
  }

  Future<void> saveAccessToken(String token) async {
    _accessToken = token;
    await _flutterSecureStorage.write(
      key: SharedPreferenceKeys.accessToken,
      value: token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    await _flutterSecureStorage.write(
      key: SharedPreferenceKeys.refreshToken,
      value: token,
    );
  }

  Future<void> saveCurrentUser(String currentUser) async {
    await _sharedPreference.setString(
      SharedPreferenceKeys.currentUser,
      currentUser,
    );
  }

  Future<void> saveCurrentUsername(String currentUsername) async {
    await _sharedPreference.setString(
      SharedPreferenceKeys.currentUsername,
      currentUsername,
    );
  }

  Future<void> saveCurrentUserId(int currentUserId) async {
    await _sharedPreference.setInt(
      SharedPreferenceKeys.currentUserId,
      currentUserId,
    );
  }

  Future<void> removeKey(String key) async {
    await _sharedPreference.remove(key);
  }

  Future<void> removeDataToLogout() async {
    String userName = currentUsername;
    await _sharedPreference.clear();
    await _flutterSecureStorage.deleteAll();
    await saveIsFirsLaunchApp(false);
    saveCurrentUsername(userName);
  }
}
