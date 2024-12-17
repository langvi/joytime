import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/data/api/base/dio_builder.dart';
import 'package:joytime/data/api/base/rest_api_client.dart';
import 'package:joytime/data/preference/app_preferences.dart';
import 'package:joytime/shared/consts/urls.dart';

@LazySingleton()
class AuthApiService extends RestApiClient {
  final AppPreferences _appPreferences;
  AuthApiService(this._appPreferences)
      : super(
            dio: DioBuilder.createDio(
                options: BaseOptions(
          baseUrl: AppUrls.apiAuthBaseUrl,
        )));

  @override
  Map<String, String>? get headers => {
        if (_appPreferences.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${_appPreferences.accessToken}',
      };
}
