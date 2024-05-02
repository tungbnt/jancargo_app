import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/firebase_options.dart';
import 'package:jancargo_app/src/domain/services/firebase_messaging/firebase_messaging_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:path_provider/path_provider.dart';

import 'src/modules/init_app/screens/init_app.page.dart';





setupHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(AppConstants.APP_NAME_ID);

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = _cert;
  }

  bool _cert(X509Certificate cert, String host, int port) => true;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initFirebaseMessaging();


  HttpOverrides.global = MyHttpOverrides();

  await setupHive();
  configureDependencies();



  runApp( ScreenUtilInit(
        builder: (context, widget) {
          return const JancargoApp();
        }
    ),
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
  // AppBadgerService().addABadge(1);
}

void initFirebaseMessaging() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService().onMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
