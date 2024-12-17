import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joytime/bloc/base_stateful_widget.dart';
import 'package:joytime/common_view/common_scaffold.dart';
import './cubit/home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageStateDelegate<HomePage, HomeCubit> {
  @override
  Widget buildWidgets(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => previous.count != current.count,
              builder: (context, state) {
                return Text("${state.count}");
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.isActive != current.isActive,
              builder: (context, state) {
                return Switch.adaptive(
                  value: state.isActive,
                  onChanged: (value) {
                    cubit.seActive(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.count();
        },
      ),
    );
  }
}
