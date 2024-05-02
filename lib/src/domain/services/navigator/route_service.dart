import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/app_manager.dart';

import '../../../modules/onboarding/screens/onboarding_screen.dart';

@singleton
class RouteService {
  static BuildContext get context => AppManager.globalKeyRootMaterial.currentContext!;

  static Route? getCurrentRoute() {
    Route? currentRoute;
    Navigator.popUntil(context, (route) {
      currentRoute = route;
      return true;
    });
    return currentRoute;
  }
  //navigator back
  static dynamic pop() {
    return Navigator.pop(context);
  }

  static dynamic popBackResult() {
    return Navigator.pop(context,true);
  }

  static dynamic popToRootPage() {
    return Navigator.popUntil(context, (route) => route.isFirst);
  }
  // navigator => screens any
  static dynamic routeGoOnePage(Widget page, {RouteSettings? settings}) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page, settings: settings),
    );
  }

  static dynamic routePushReplacementPage(Widget page, {RouteSettings? settings}) {
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => page, settings: settings);
    return Navigator.pushReplacement(
      context,
      route,
    );
  }

  static dynamic routeOnboarding() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OnboardScreen()), (route) => false);
  }
}