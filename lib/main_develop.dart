import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joytime/app/globals.config.dart';
import 'package:joytime/app/globals.dart';
import 'package:joytime/bloc/bloc_observer.dart';
import 'package:joytime/main.dart';
import 'package:joytime/shared/config/log_config.dart';
import 'package:joytime/tools/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    name: Flavor.DEV.name,
    color: Colors.red,
    location: BannerLocation.topStart,
  );
  if (LogConfig.enableNavigatorObserverLog) {
    Bloc.observer = AppBlocObserver();
  }
  getIt.init();
  runApp(const MyApp());
}
