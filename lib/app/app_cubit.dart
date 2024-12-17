import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/app/app_state.dart';
import 'package:joytime/bloc/base_cubit.dart';
import 'package:joytime/resources/dimens/app_dimens.dart';

@Injectable()
class AppCubit extends BaseCubit<AppState> {
  AppCubit() : super(AppState());
  void handleRatioScreen() async {
    Dimens.handleRatioScreen(MediaQuery.of(context).size);
  }
}
