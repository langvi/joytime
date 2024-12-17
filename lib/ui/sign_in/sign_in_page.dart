import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joytime/bloc/base_stateful_widget.dart';
import './cubit/sign_in_cubit.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends BasePageStateDelegate<SignInPage, SignInCubit> {
  @override
  Widget buildWidgets(BuildContext context) {
    return Container();
  }
}
