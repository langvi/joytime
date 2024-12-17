import 'package:joytime/tools/flavor_config.dart';

class AppUrls {
  static String get apiAuthBaseUrl {
    switch (FlavorConfig.instance.name) {
      case 'DEV':
        return 'https://viu-cms.sftech.vn/api/';
      case 'STAGING':
        return 'https://viu-cms.sftech.vn/api/';
      case 'PROD':
        return 'https://viu-cms.sftech.vn/api/';
      default:
        return 'https://viu-cms.sftech.vn/api/';
    }
  }
}
