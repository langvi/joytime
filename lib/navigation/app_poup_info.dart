import 'package:flutter/material.dart';

class AppPopupInfo {
  final String message;
  final void Function()? onPressed;
  final void Function()? onRetryPressed;
  final PopupType type;
  final Widget? child;
  AppPopupInfo._(
      {this.message = '',
      this.onPressed,
      this.onRetryPressed,
      required this.type,
      this.child});

  // Named constructor for ConfirmDialog
  factory AppPopupInfo.confirmDialog({
    String message = '',
    void Function()? onPressed,
  }) {
    return AppPopupInfo._(
      message: message,
      onPressed: onPressed,
      type: PopupType.confirmDialog,
    );
  }
  factory AppPopupInfo.dialogWidget({
    void Function()? onPressed,
    required Widget child,
  }) {
    return AppPopupInfo._(
      message: '',
      onPressed: onPressed,
      child: child,
      type: PopupType.dialogWidget,
    );
  }
  factory AppPopupInfo.confirm2Dialog({
    String message = '',
    void Function()? onPressed,
  }) {
    return AppPopupInfo._(
      message: message,
      onPressed: onPressed,
      type: PopupType.confirm2Dialog,
    );
  }
  factory AppPopupInfo.confirm2DialogWidget({
    required Widget child,
    void Function()? onPressed,
  }) {
    return AppPopupInfo._(
      message: '',
      onPressed: onPressed,
      child: child,
      type: PopupType.confirm2DialogWidget,
    );
  }

  // Named constructor for ErrorWithRetryDialog
  factory AppPopupInfo.errorWithRetryDialog({
    String message = '',
    void Function()? onRetryPressed,
  }) {
    return AppPopupInfo._(
      message: message,
      onRetryPressed: onRetryPressed,
      type: PopupType.errorWithRetryDialog,
    );
  }

  // Named constructor for RequiredLoginDialog
  factory AppPopupInfo.requiredLoginDialog() {
    return AppPopupInfo._(
      type: PopupType.requiredLoginDialog,
    );
  }
}

// Enum to represent the type of popup
enum PopupType {
  confirmDialog,
  confirm2Dialog,
  dialogWidget,
  confirm2DialogWidget,
  errorWithRetryDialog,
  requiredLoginDialog,
}
