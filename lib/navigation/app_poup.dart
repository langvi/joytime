import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/common_view/common_dialog.dart';
import 'package:joytime/navigation/app_navigator.dart';
import 'package:joytime/navigation/app_poup_info.dart';
import 'package:joytime/routes/app_routes.gr.dart';

@LazySingleton()
class AppPoup {
  Widget getPopup(AppPopupInfo appPopupInfo, AppNavigator navigator) {
    switch (appPopupInfo.type) {
      case PopupType.confirmDialog:
        return CommonDialog(
          actions: [
            PopupButton(
              text: 'OK',
              onPressed: appPopupInfo.onPressed ?? () => navigator.pop(),
            ),
          ],
          message: appPopupInfo.message,
        );
      case PopupType.confirm2Dialog:
        return CommonDialog(
          actions: [
            PopupButton(
              text: 'Huỷ',
              onPressed: () => navigator.pop(),
            ),
            PopupButton(
              text: 'OK',
              onPressed: appPopupInfo.onPressed ?? () => navigator.pop(),
            ),
          ],
          message: appPopupInfo.message,
        );

      case PopupType.confirm2DialogWidget:
        return CommonDialog(
          actions: [
            PopupButton(
              text: 'Huỷ',
              onPressed: () => navigator.pop(),
            ),
            PopupButton(
              text: 'OK',
              onPressed: appPopupInfo.onPressed ?? () => navigator.pop(),
            ),
          ],
          message: null,
          child: appPopupInfo.child,
        );
      case PopupType.dialogWidget:
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: appPopupInfo.child,
        );
      case PopupType.errorWithRetryDialog:
        return CommonDialog(
          actions: [
            PopupButton(
              text: 'Huỷ',
              onPressed: () => navigator.pop(),
            ),
            PopupButton(
              text: 'Thử lại',
              onPressed: appPopupInfo.onRetryPressed ?? () => navigator.pop(),
              isDefault: true,
            ),
          ],
          message: appPopupInfo.message,
        );
      case PopupType.requiredLoginDialog:
        return CommonDialog.adaptive(
          title: 'Thông báo',
          message: 'Phiên làm việc kết thúc! Vui lòng đăng nhập lại',
          actions: [
            PopupButton(
              text: 'Huỷ',
              onPressed: () => navigator.pop(),
            ),
            PopupButton(
              text: 'Đăng nhập',
              onPressed: () async {
                await navigator.pop();
                await navigator.push(const SignInRoute());
              },
            ),
          ],
        );
      default:
        return CommonDialog(
          actions: [
            PopupButton(
              text: 'OK',
              onPressed: appPopupInfo.onPressed ?? () => navigator.pop(),
            ),
          ],
          message: appPopupInfo.message,
        );
    }
  }
}
