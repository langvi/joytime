import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @preResolve
  Future<EncryptedSharedPreferences> get encryptPrefs async {
    await EncryptedSharedPreferences.initialize('encryptPrefsJoy');
    return EncryptedSharedPreferences.getInstance();
  }
}
