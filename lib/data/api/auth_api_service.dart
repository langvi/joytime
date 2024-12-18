import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/data/api/base/base_response.dart';
import 'package:joytime/data/api/base/dio_builder.dart';
import 'package:joytime/data/api/base/rest_api_client.dart';
import 'package:joytime/data/storage/app_storage.dart';
import 'package:joytime/shared/consts/urls.dart';

@LazySingleton()
class AuthApiService extends RestApiClient {
  final AppStorage _appStorage;
  AuthApiService(this._appStorage)
      : super(
            dio: DioBuilder.createDio(
                options: BaseOptions(
          baseUrl: AppUrls.apiAuthBaseUrl,
        )));

  @override
  Map<String, String>? get headers => {
        if (_appStorage.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${_appStorage.accessToken}',
      };
  Future<BaseResponse<dynamic>> signIn(
      {required String username, required String password}) async {
    var res = await request(
        path: AppUrls.login,
        method: RequestMethod.post,
        body: {
          "username": username.trim().toLowerCase(),
          "password": password.trim()
        });
    return BaseResponse.fromJson(res);
  }
}
