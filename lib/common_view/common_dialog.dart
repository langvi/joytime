// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PopupPlatform {
  android,
  ios,
  adaptive,
}

class PopupButton {
  String text;
  void Function()? onPressed;
  bool isDefault;
  PopupButton({
    required this.text,
    this.onPressed,
    this.isDefault = false,
  });
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    this.commonPopupPlatform = PopupPlatform.adaptive,
    this.actions = const <PopupButton>[],
    this.title,
    this.message,
    this.child,
    super.key,
  });

  const CommonDialog.android({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Widget? child,
    Key? key,
  }) : this(
          commonPopupPlatform: PopupPlatform.android,
          actions: actions,
          title: title,
          message: message,
          child: child,
          key: key,
        );

  const CommonDialog.ios({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Widget? child,
    Key? key,
  }) : this(
          commonPopupPlatform: PopupPlatform.ios,
          actions: actions,
          title: title,
          message: message,
          child: child,
          key: key,
        );

  const CommonDialog.adaptive({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Widget? child,
    Key? key,
  }) : this(
          commonPopupPlatform: PopupPlatform.adaptive,
          actions: actions,
          title: title,
          message: message,
          child: child,
          key: key,
        );

  final PopupPlatform commonPopupPlatform;
  final List<PopupButton> actions;
  final String? title;
  final String? message;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    switch (commonPopupPlatform) {
      case PopupPlatform.android:
        return _buildAndroidDialog();
      case PopupPlatform.ios:
        return _buildIosDialog();
      case PopupPlatform.adaptive:
        return Platform.isIOS ? _buildIosDialog() : _buildAndroidDialog();
    }
  }

  Widget _buildAndroidDialog() {
    return AlertDialog(
      actions: actions
          .map(
            (e) => TextButton(
              onPressed: e.onPressed,
              child: Text(
                e.text,
              ),
            ),
          )
          .toList(growable: false),
      title: title != null
          ? Text(
              title ?? '',
            )
          : null,
      content: child ??
          (message != null
              ? Text(
                  message ?? '',
                )
              : null),
    );
  }

  Widget _buildIosDialog() {
    return CupertinoAlertDialog(
      actions: actions
          .map((e) => CupertinoDialogAction(
                onPressed: e.onPressed,
                child: Text(
                  e.text,
                ),
              ))
          .toList(growable: false),
      title: title != null
          ? Text(
              title ?? '',
            )
          : null,
      content: child ??
          (message != null
              ? Text(
                  message ?? '',
                )
              : null),
    );
  }
}
