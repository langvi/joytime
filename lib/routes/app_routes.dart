import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/routes/app_routes.gr.dart';

@AutoRouterConfig()
@LazySingleton()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
      ];
  @override
  RouteType get defaultRouteType => const RouteType.material();
}
