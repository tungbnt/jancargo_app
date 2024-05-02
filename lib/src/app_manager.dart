import 'package:flutter/material.dart';
import 'app_session.dart';

class AppManager {
  static final GlobalKey<NavigatorState> globalKeyRootMaterial =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> globalKeyRootScaffold =
      GlobalKey<NavigatorState>();

  static AppSession get appSession => AppSession();
}
