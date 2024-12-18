// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:joytime/data/api/auth_api_service.dart';
import 'package:joytime/data/api/base/base_response.dart';

import 'package:joytime/data/storage/app_storage.dart';

@LazySingleton()
class AuthRepository {
  final AppStorage _appStorage;
  final AuthApiService _apiService;
  AuthRepository(this._appStorage, this._apiService);
  Future<dynamic> signIn(
      {required String username, required String password}) async {
    var res = await _apiService.signIn(username: username, password: password);
    return res;
  }
}
