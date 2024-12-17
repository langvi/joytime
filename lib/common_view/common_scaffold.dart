import 'package:flutter/material.dart';
import 'package:joytime/utils/view_utils.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: body,
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => ViewUtils.hideKeyboard(context),
            child: scaffold,
          )
        : scaffold;
  }
}
