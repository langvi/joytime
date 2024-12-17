import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:joytime/bloc/base_cubit.dart';
import 'package:joytime/bloc/common/common_cubit.dart';
import 'package:joytime/bloc/common/common_state.dart';
import 'package:joytime/navigation/app_navigator.dart';

abstract class BasePageStateDelegate<T extends StatefulWidget,
    C extends BaseCubit> extends State<T> {
  late final C cubit = GetIt.instance.get<C>()
    ..commonCubit = commonCubit
    ..context = context
    ..navigator = navigator;
  late final CommonCubit commonCubit = GetIt.instance.get<CommonCubit>();
  late final AppNavigator navigator = GetIt.instance.get<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<C>(create: (context) => cubit),
          BlocProvider<CommonCubit>(create: (context) => commonCubit)
        ],
        child: Stack(
          children: [
            buildWidgets(context),
            BlocBuilder<CommonCubit, CommonState>(
              builder: (context, state) {
                return Visibility(
                    visible: state.isLoading, child: buildPageLoading());
              },
            )
          ],
        ));
  }

  Widget buildWidgets(BuildContext context);
  Widget buildPageLoading() => Container(
        color: Colors.black38,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}

abstract class BasePageSingleStateDelegate<T extends StatefulWidget,
    C extends BaseCubit> extends State<T> {
  late final C cubit = GetIt.instance.get<C>()
    ..commonCubit = commonCubit
    ..context = context
    ..navigator = navigator;
  late final CommonCubit commonCubit = GetIt.instance.get<CommonCubit>();
  late final AppNavigator navigator = GetIt.instance.get<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<C>(
      create: (context) => cubit,
      child: buildWidgets(context),
    );
  }

  Widget buildWidgets(BuildContext context);
}
