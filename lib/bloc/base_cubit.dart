import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joytime/bloc/common/common_cubit.dart';
import 'package:joytime/navigation/app_navigator.dart';
import 'package:joytime/shared/mixin/log_mixin.dart';

enum TypeLoad { first, refresh, loadmore }

abstract class BaseCubit<S> extends Cubit<S> with LogMixin {
  BaseCubit(initialState) : super(initialState);
  late final AppNavigator navigator;
  late final CommonCubit _commonCubit;
  set commonCubit(CommonCubit commonCubit) {
    _commonCubit = commonCubit;
  }

  CommonCubit get commonCubit =>
      this is CommonCubit ? this as CommonCubit : _commonCubit;
  late final BuildContext _context;
  set context(BuildContext context) {
    _context = context;
  }

  BuildContext get context =>
      this is BuildContext ? this as BuildContext : _context;

  void showLoading() {
    _commonCubit.setLoading(true);
  }

  void hideLoading() {
    _commonCubit.setLoading(false);
  }

  Future<void> runBlocCatching(
      {required Future<void> Function() action,
      Future<void> Function()? doOnRetry,
      Future<void> Function(Object)? onError,
      bool handleLoading = true}) async {
    if (handleLoading) showLoading();
    try {
      await action();
    } on Object catch (e) {
      addError(e);
      if (e is Error) {
        print(e.stackTrace.toString());
      }
      if (onError != null) {
        await onError.call(e);
      } else {
        _handleOnError(e);
      }
    }
    if (handleLoading) hideLoading();
  }

  void _handleOnError(Object error) {
    // print(error);
    // logger.e(error);
    int statusCode = 0;
    String errorCode = '';
    String errorContent =
        'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
    if (error is TypeError) {
      errorContent = 'Lỗi xử lý dữ liệu\nXin vui lòng thử lại sau!!!';
    }
    if (error is DioException) {
      statusCode = error.response?.statusCode ?? 0;
      errorCode = error.response?.statusMessage ?? '';
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorContent =
              'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
          break;
        case DioExceptionType.badResponse:
          if (error.response != null && error.response?.data is Map) {
            errorContent = error.response!.data['message'] ?? '';
            errorCode = error.response!.data['name'] ?? '';
          } else {
            switch (error.response?.statusCode) {
              case 400:
                errorContent = 'Dữ liệu gửi đi không hợp lệ!';
                break;
              case 401:
              case 302:
                errorContent =
                    'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại!';
                break;
              case 404:
                errorContent =
                    'Không tìm thấy đường dẫn này, xin vui lòng liên hệ Admin';
                break;
              case 500:
                errorContent =
                    'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
                break;
              case 502:
                errorContent =
                    'Server đang bảo trì, Quý khách vui lòng quay lại sau.';
                break;
              case 503:
                errorContent =
                    'Server đang bảo trì, Quý khách vui lòng quay lại sau một vài phút.';
                break;
              default:
                errorContent =
                    'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
            }
          }

          break;
        default:
          errorContent =
              'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
      }
    }
    print("statusCode: $statusCode");
    // if (errorCode == ErrorCode.sessionExprited) {
    //   navigator.showDialogApp(AppPopupInfo.confirmDialog(
    //       message: errorContent,
    //       onPressed: Func0(() {
    //         navigator.popUntilRoot();
    //         navigator.push(LoginRoute());
    //       })));
    // } else {
    //   navigator.showDialogApp(
    //       AppPopupInfo.errorWithRetryDialog(message: errorContent));
    // }
  }
}
