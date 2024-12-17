import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class AppNavigator {
  const AppNavigator();

  List<PageRouteInfo> get tabRouters;

  bool get canPopSelfOrChildren;

  int get currentBottomTab;

  String getCurrentRouteName({bool useRootNavigator = false});

  void popUntilRootOfCurrentBottomTab();

  void navigateToBottomTab(int index, {bool notify = true});

  Future<T?> push<T extends Object?>(PageRouteInfo appRouteInfo);

  Future<void> pushAll(List<PageRouteInfo> listAppRouteInfo);

  Future<T?> replace<T extends Object?>(PageRouteInfo appRouteInfo);

  Future<void> replaceAll(List<PageRouteInfo> listAppRouteInfo);

  Future<bool> pop<T extends Object?>({
    T? result,
    bool useRootNavigator = false,
  });

  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    PageRouteInfo appRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  });

  Future<void> popAndPushAll(List<PageRouteInfo> listAppRouteInfo,
      {bool useRootNavigator = false});

  void popUntilRoot({bool useRootNavigator = false});

  void popUntilRouteName(String routeName);

  bool removeUntilRouteName(String routeName);

  bool removeAllRoutesWithName(String routeName);

  bool removeLast();

  Future<T?> showDialogApp<T extends Object?>(
    Widget child, {
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  });

  Future<T?> showGeneralDialog<T extends Object?>(
    Widget child, {
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    Duration transitionDuration = const Duration(milliseconds: 200),
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
    bool useRootNavigator = true,
  });

  Future<T?> showModalBottomSheetApp<T extends Object?>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color barrierColor = Colors.black54,
    Color? backgroundColor,
  });

  void showErrorSnackBar(String message, {Duration? duration});

  void showSuccessSnackBar(String message, {Duration? duration});
  void showFlushBar(String message,
      {Duration? duration, Color? backgroudColor});
}
