import 'package:joytime/shared/mixin/log_mixin.dart';

bool safeBool(dynamic data) {
  if (data != null) {
    if (data is bool) {
      return data;
    }
    try {
      return data;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
  return false;
}

int safeInt(dynamic data) {
  if (data != null) {
    if (data is int) {
      return data;
    }
    if (data is num) {
      return int.parse(data.toString());
    }
    try {
      return int.parse(data as String);
    } catch (e) {
      logger.e(e);
      return 0;
    }
  }
  return 0;
}

num safeNum(dynamic data) {
  if (data != null) {
    if (data is num) {
      return data;
    }
    try {
      return data;
    } catch (e) {
      logger.e(e);
      return 0;
    }
  }
  return 0;
}

double safeDouble(dynamic data) {
  if (data != null) {
    if (data is double) {
      return data;
    }
    try {
      return data;
    } catch (e) {
      logger.e(e);
      return 0.0;
    }
  }
  return 0.0;
}

String safeString(dynamic data) {
  if (data != null) {
    if (data is String) {
      return data;
    }
    try {
      return data;
    } catch (e) {
      logger.e(e);
      return '';
    }
  }
  return "";
}
