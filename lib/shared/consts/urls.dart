import 'package:joytime/tools/flavor_config.dart';

class AppUrls {
  static const String login = "auth/login";
  static String get apiAuthBaseUrl {
    switch (FlavorConfig.instance.name) {
      case 'DEV':
        return 'https://api-dev.airdata.site/user/api/';
      case 'STAGING':
        return 'https://api-dev.airdata.site/user/api/';
      case 'PROD':
        return 'https://api-dev.airdata.site/user/api/';
      default:
        return 'https://api-dev.airdata.site/user/api/';
    }
  }
}
