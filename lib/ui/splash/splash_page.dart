import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:joytime/common_view/common_scaffold.dart';
import 'package:joytime/navigation/app_navigator.dart';
import 'package:joytime/routes/app_routes.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      GetIt.instance.get<AppNavigator>().replace(SignInRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
        body: Center(
      child: Text("Splash"),
    ));
  }
}
