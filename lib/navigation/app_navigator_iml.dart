import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter/material.dart' as m;
import 'package:joytime/navigation/app_navigator.dart';
import 'package:joytime/navigation/app_poup.dart';
import 'package:joytime/navigation/app_poup_info.dart';
import 'package:joytime/routes/app_routes.dart';
import 'package:joytime/shared/config/log_config.dart';
import 'package:joytime/shared/mixin/log_mixin.dart';
import 'package:joytime/utils/object_utils.dart';
import 'package:joytime/utils/view_utils.dart';

@LazySingleton(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator with LogMixin {
  final AppRouter _appRouter;
  final AppPoup _appPoup;
  TabsRouter? tabsRouter;
  AppNavigatorImpl(this._appRouter, this._appPoup);
  BuildContext get _rootRouterContext =>
      _appRouter.navigatorKey.currentContext!;
  //
  BuildContext? get _currentTabRouterContext =>
      _currentTabRouter?.navigatorKey.currentContext;
  //
  StackRouter? get _currentTabRouter =>
      tabsRouter?.stackRouterOfIndex(currentBottomTab);
  //
  StackRouter get _currentTabRouterOrRootRouter =>
      _currentTabRouter ?? _appRouter;
  //
  BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;
  //
  final _shownPopups = <AppPopupInfo, Completer<dynamic>>{};
  @override
  bool get canPopSelfOrChildren => _appRouter.canPop();

  @override
  int get currentBottomTab {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    return tabsRouter?.activeIndex ?? 0;
  }

  @override
  String getCurrentRouteName({bool useRootNavigator = false}) {
    return AutoRouter.of(useRootNavigator
            ? _rootRouterContext
            : _currentTabContextOrRootContext)
        .current
        .name;
  }

  @override
  void navigateToBottomTab(int index, {bool notify = true}) {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (LogConfig.enableNavigatorObserverLog) {
      logD('navigateToBottomTab with index = $index, notify = $notify');
    }
    tabsRouter?.setActiveIndex(index, notify: notify);
  }

  @override
  Future<bool> pop<T extends Object?>(
      {T? result, bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pop with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter.maybePop<T>(result)
        : _currentTabRouterOrRootRouter.maybePop<T>(result);
  }

  @override
  Future<T?> popAndPush<T extends Object?, R extends Object?>(
      PageRouteInfo appRouteInfo,
      {R? result,
      bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD(
          'popAndPush $appRouteInfo with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter.popAndPush<T, R>(appRouteInfo, result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            appRouteInfo,
            result: result,
          );
  }

  @override
  Future<void> popAndPushAll(List<PageRouteInfo> listAppRouteInfo,
      {bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popAndPushAll $listAppRouteInfo, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter.popAndPushAll(listAppRouteInfo)
        : _currentTabRouterOrRootRouter.popAndPushAll(listAppRouteInfo);
  }

  @override
  void popUntilRoot({bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRoot, useRootNav = $useRootNavigator');
    }

    useRootNavigator
        ? _appRouter.popUntilRoot()
        : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  @override
  void popUntilRootOfCurrentBottomTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPop() == true) {
      if (LogConfig.enableNavigatorObserverLog) {
        logD('popUntilRootOfCurrentBottomTab');
      }
      _currentTabRouter?.popUntilRoot();
    }
  }

  @override
  void popUntilRouteName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRouteName $routeName');
    }

    _appRouter.popUntilRouteWithName(routeName);
  }

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo appRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('push $appRouteInfo');
    }

    return _appRouter.push<T>(appRouteInfo);
  }

  @override
  Future<void> pushAll(List<PageRouteInfo> listAppRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pushAll $listAppRouteInfo');
    }

    return _appRouter.pushAll(listAppRouteInfo);
  }

  @override
  bool removeAllRoutesWithName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeAllRoutesWithName $routeName');
    }

    return _appRouter.removeWhere((route) => route.name == routeName);
  }

  @override
  bool removeLast() {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeLast');
    }

    return _appRouter.removeLast();
  }

  @override
  bool removeUntilRouteName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeUntilRouteName $routeName');
    }

    return _appRouter.removeUntil((route) => route.name == routeName);
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo appRouteInfo) {
    _shownPopups.clear();
    if (LogConfig.enableNavigatorObserverLog) {
      logD('replace by $appRouteInfo');
    }

    return _appRouter.replace<T>(appRouteInfo);
  }

  @override
  Future<void> replaceAll(List<PageRouteInfo> listAppRouteInfo) {
    _shownPopups.clear();
    if (LogConfig.enableNavigatorObserverLog) {
      logD('replaceAll by $listAppRouteInfo');
    }

    return _appRouter.replaceAll(listAppRouteInfo);
  }

  @override
  void showErrorSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
    );
  }

  @override
  void showSuccessSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
    );
  }

  @override
  Future<T?> showDialogApp<T extends Object?>(AppPopupInfo appPopupInfo,
      {bool barrierDismissible = true,
      bool useSafeArea = false,
      bool useRootNavigator = true}) {
    if (_shownPopups.containsKey(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return _shownPopups[appPopupInfo]!.future.safeCast();
    }
    _shownPopups[appPopupInfo] = Completer<T?>();

    return showDialog<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      builder: (_) => m.PopScope(
        onPopInvoked: (value) async {
          logD('Dialog $appPopupInfo dismissed');
          _shownPopups.remove(appPopupInfo);
        },
        child: _appPoup.getPopup(appPopupInfo, this),
      ),
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    );
  }

  @override
  Future<T?> showGeneralDialog<T extends Object?>(AppPopupInfo appPopupInfo,
      {Widget Function(BuildContext p1, Animation<double> p2,
              Animation<double> p3, Widget p4)?
          transitionBuilder,
      Duration transitionDuration = const Duration(milliseconds: 200),
      bool barrierDismissible = false,
      Color barrierColor = const Color(0x80000000),
      bool useRootNavigator = true}) {
    if (_shownPopups.containsKey(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return _shownPopups[appPopupInfo]!.future.safeCast();
    }
    _shownPopups[appPopupInfo] = Completer<T?>();

    return m.showGeneralDialog<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      pageBuilder: (
        m.BuildContext context,
        m.Animation<double> animation1,
        m.Animation<double> animation2,
      ) =>
          m.PopScope(
        onPopInvoked: (value) async {
          logD('Dialog $appPopupInfo dismissed');
          _shownPopups.remove(appPopupInfo);
        },
        child: _appPoup.getPopup(appPopupInfo, this),
      ),
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
  }

  @override
  Future<T?> showModalBottomSheetApp<T extends Object?>(
      {required Widget Function(BuildContext) builder,
      bool isScrollControlled = false,
      bool useRootNavigator = false,
      bool isDismissible = true,
      bool enableDrag = true,
      Color barrierColor = Colors.black54,
      Color? backgroundColor}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD(
          'showModalBottomSheet ${builder.toString()}, useRootNav = $useRootNavigator');
    }

    return m.showModalBottomSheet<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      builder: builder,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
    );
  }

  @override
  void showFlushBar(String message,
      {Duration? duration, Color? backgroudColor}) async {
    await Future.delayed(Duration(milliseconds: 100));
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: backgroudColor ?? Colors.green,
      duration: duration ?? Duration(seconds: 3),
    ).show(_rootRouterContext);
  }

  @override
  List<PageRouteInfo> get tabRouters => [];
}
