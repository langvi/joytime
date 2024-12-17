import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joytime/shared/mixin/log_mixin.dart';

class AppBlocObserver extends BlocObserver with LogMixin {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logE(error.toString(), error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logI('Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    logI("Closed: $bloc");
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    logI("Init: $bloc");
    super.onCreate(bloc);
  }
}
