import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:joytime/app/app_cubit.dart';
import 'package:joytime/app/app_state.dart';
import 'package:joytime/app/globals.config.dart';
import 'package:joytime/app/globals.dart';
import 'package:joytime/bloc/base_stateful_widget.dart';
import 'package:joytime/bloc/bloc_observer.dart';
import 'package:joytime/common_view/flavor_banner.dart';
import 'package:joytime/generated/l10n.dart';
import 'package:joytime/navigation/navigator_observer.dart';
import 'package:joytime/routes/app_routes.dart';
import 'package:joytime/routes/app_routes.gr.dart';
import 'package:joytime/tools/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    name: Flavor.PROD.name,
    color: Colors.red,
    location: BannerLocation.topStart,
  );
  getIt.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageSingleStateDelegate<MyApp, AppCubit> {
  final _appRouter = GetIt.instance.get<AppRouter>();

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (FlavorConfig.instance.name == Flavor.PROD.name) {
          return getMaterialApp(state);
        } else {
          return FlavorBanner(
            color: Colors.red,
            location: BannerLocation.topStart,
            child: getMaterialApp(state),
          );
        }
      },
    );
  }

  MaterialApp getMaterialApp(AppState state) {
    return MaterialApp.router(
      title: 'Joytime',
      debugShowCheckedModeBanner: false,
      // theme: darkTheme,
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(state.languageCode),
      localizationsDelegates: const [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      themeMode: ThemeMode.light,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(
        deepLinkBuilder: (deepLink) {
          return const DeepLink([SplashRoute()]);
        },
        navigatorObservers: () => [AppNavigatorObserver()],
      ),
    );
  }
}
