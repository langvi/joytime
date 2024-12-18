import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:joytime/bloc/base_stateful_widget.dart';
import 'package:joytime/common_view/common_scaffold.dart';
import 'package:joytime/resources/dimens/app_dimens.dart';

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
    return CommonScaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.w16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: cubit.usernameController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: cubit.passwordController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  cubit.signIn();
                },
                child: Text("Sign in"))
          ],
        ),
      ),
    );
  }
}
