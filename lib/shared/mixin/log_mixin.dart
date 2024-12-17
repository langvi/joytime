import 'package:logger/logger.dart';

final logger = Logger();
mixin LogMixin on Object {
  void logD(String message, {DateTime? time}) {
    logger.d(message, time: time);
  }

  void logI(String message, {DateTime? time}) {
    logger.i(
      message,
      time: time,
    );
  }

  void logE(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }
}
