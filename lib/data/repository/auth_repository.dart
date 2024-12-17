// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';

import 'package:joytime/data/preference/app_preferences.dart';

@LazySingleton()
class AuthRepository {
  final AppPreferences _appPreferences;
  AuthRepository(this._appPreferences);
}
