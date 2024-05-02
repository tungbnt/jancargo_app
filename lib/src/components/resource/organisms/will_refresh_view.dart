import 'package:flutter/material.dart';

class WillRefreshView extends StatelessWidget {
  const WillRefreshView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              maxHeight: height,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
