part of 'firebase_messaging_service.dart';

class LocalNotificationService {
   final VoidCallback? onNotificationsShowService;

  LocalNotificationService.LocalNotificationServices({this.onNotificationsShowService});

  void initFlutterLocalNotificationPlugin(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // DialogService.showDialogNotification(title: title ?? '', body: body ?? '');
  }

  void showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RemoteMessage message) async {
    print('show notification');
    await flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails("channel.id", "channel.name",
              channelDescription: "channel.description", importance: Importance.max, priority: Priority.high, ticker: 'ticker'
              // other properties...
              ),
        ),
        payload: message.data !=    null ? json.encode(message.data) : null);
  }

  void onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {}

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    handleRouteNotification(payload);
  }

  handleRouteNotification(String? payload) {
    print('payload notification: $payload');
    Route? currentRoute = RouteService.getCurrentRoute();


    if (payload!.isNotEmpty ) {
      // var data = json.decode(payload);


    }
   else {
     print('No data');
    }
    return;
  }
}
