import 'package:flutter/material.dart';

class WillUnfocusFormScope extends StatelessWidget {
  const WillUnfocusFormScope({
    Key? key,
    required this.child,
    this.willUnfocusCallback,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? willUnfocusCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        willUnfocusCallback?.call();
      },
      child: child,
    );
  }
}
