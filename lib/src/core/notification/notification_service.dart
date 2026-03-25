import 'dart:async';
import 'dart:convert';
import "dart:developer";
import 'dart:io';
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../config/res/config_imports.dart';
 import '../network/un_authenticated_interceptor.dart';

part 'navigation_types.dart';
part 'notification_routes.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('========= >>> backGroundMessage ${message.data}');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  static String deviceToken = "";
  static int _notificationIdCounter = 0;

  Future<bool> _requestPermissions() async {
    try {
      if (Platform.isIOS) {
        final iOSImplementation = _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

        final bool? result = await iOSImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return result ?? false;
      } else {
        final androidImplementation = _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        final bool? result = await androidImplementation
            ?.requestNotificationsPermission();
        await _createAndroidChannel();
        return result ?? false;
      }
    } catch (e) {
      log('❌ Error requesting permissions: $e');
      return false;
    }
  }

  Future<void> _createAndroidChannel() async {
    final androidImplementation = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.createNotificationChannel(_channel);
  }

  void _showNotification(RemoteMessage message) async {
    log('🔔 ========= _showNotification called =========');

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: ConstantManager.appName,
          enableVibration: true,
          playSound: true,
          icon: "@mipmap/ic_launcher",
          importance: Importance.high,
          priority: Priority.max,
        );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final notification = message.notification;

    // Extract title and body based on platform structure
    String title = '';
    String body = '';

    if (Platform.isIOS) {
      // iOS: Check notification object first, then data
      title =
          notification?.title ??
          message.data['title'] ??
          message.data['Title'] ??
          'إشعار جديد';

      body =
          notification?.body ??
          message.data['body'] ??
          message.data['Body'] ??
          message.data['message'] ??
          message.data['body_ar'] ??
          message.data['body_en'] ??
          '';
    } else {
      // Android: Data comes directly in data object
      title =
          message.data['title'] ??
          message.data['Title'] ??
          notification?.title ??
          'إشعار جديد';

      body =
          message.data['message'] ??
          message.data['body'] ??
          message.data['Body'] ??
          message.data['body_ar'] ??
          message.data['body_en'] ??
          notification?.body ??
          '';
    }

    log('📱 Platform: ${Platform.isIOS ? "iOS" : "Android"}');
    log('📝 Title: $title');
    log('📝 Body: $body');
    log('📝 notification?.title: ${notification?.title}');
    log('📝 notification?.body: ${notification?.body}');
    log('📝 data[title]: ${message.data['title']}');
    log('📝 data[message]: ${message.data['message']}');
    log('📝 data[body]: ${message.data['body']}');
    log('📝 data[body_ar]: ${message.data['body_ar']}');
    log('📝 data[body_en]: ${message.data['body_en']}');
    log('========================================');

    // Generate safe notification ID
    _notificationIdCounter++;
    if (_notificationIdCounter > 2147483647) {
      _notificationIdCounter = 1;
    }

    try {
      await _flutterLocalNotificationsPlugin.show(
        _notificationIdCounter,
        title,
        body,
        notificationDetails,
        payload: json.encode(message.toMap()),
      );
      log('✅ Notification shown successfully with ID: $_notificationIdCounter');
    } catch (e) {
      log('❌ Error showing notification: $e');
    }
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) {
        if (payload?.payload != null) {
          _handleNotificationsTap(
            RemoteMessage.fromMap(json.decode(payload?.payload ?? "")),
          );
        }
      },
    );
  }

  Future<void> _registerNotification() async {
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      await firebaseMessaging.requestPermission(
        alert:Platform.isIOS ? false : true,
        badge: true,
        sound: true,
      );
      log('✅ Firebase notification permission granted');
    } catch (e) {
      log('❌ Error registering notification: $e');
    }
  }

  void _handleNotificationsTap(RemoteMessage? message) async {
    if (message == null) return;
    log('👆 Notification tapped, navigating...');
    NotificationNavigator._instance?.onRoutingMessage(message);
  }

  int count = 0;

  Future<void> _saveFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      deviceToken = token ?? "";
      log("✅ Firebase FCM token: $token");
    } catch (e, s) {
      count++;
      log('❌ Error getting FCM token: $e', stackTrace: s);
      if (count < 5) {
        Future.delayed(const Duration(seconds: 3), () => _saveFcmToken());
      }
    }
  }

  Future<void> _setForegroundNotificationOptions() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
      log('✅ Foreground notification options set');
    } catch (e) {
      log('❌ Error setting foreground options: $e');
    }
  }

  Future<void> setupNotifications() async {
    log('🚀 Starting notification setup...');
    try {
      await Future.wait([
        _setForegroundNotificationOptions(),
        _registerNotification(),
        _requestPermissions(),
        NotificationNavigator._instance!.init(),
      ]);
      await _saveFcmToken();
      await _initLocalNotification();
      _configureNotification();
      log('✅ Notification setup completed successfully');
    } catch (e, s) {
      log('❌ Error in setupNotifications: $e', stackTrace: s);
    }
  }

  static List<NotificationActionListener> listeners = [];

  void _configureNotification() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log('╔════════════════════════════════════════╗');
      log('║     NOTIFICATION RECEIVED (Foreground)  ║');
      log('╚════════════════════════════════════════╝');
      log('📱 Platform: ${Platform.isIOS ? "iOS" : "Android"}');
      log('📱 Message ID: ${event.messageId}');
      log('📊 Full Data: ${event.data}');
      log('🔔 Notification Object:');
      log('   - Title: ${event.notification?.title}');
      log('   - Body: ${event.notification?.body}');
      log('📦 Data Fields:');
      event.data.forEach((key, value) {
        log('   - $key: $value');
      });
      log('════════════════════════════════════════');

      final notiifcationType = event.data['type'].toString().toNotification;

      if (notiifcationType != null) {
        log('🎯 Notification Type: ${notiifcationType.key}');

        final bool isBlocked =
            notiifcationType == NotificationType.block ||
            notiifcationType == NotificationType.userBlocked ||
            notiifcationType == NotificationType.blockNotify ||
            notiifcationType == NotificationType.deleteNotify;

        if (isBlocked) {
          UnAuthenticatedInterceptor.instance.notifyListeners(true);
        }

        for (var action in listeners) {
          if (action.conditionCheck(notiifcationType)) {
            action.onMessage(event.data);
          }
        }
      }

      _showNotification(event);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log('📬 Initial message found: ${message.data}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      log('👆 Notification opened from background');
      _handleNotificationsTap(event);
    });
  }
}

class NotificationNavigator {
  NotificationNavigator._({this.onNoInitialMessage});

  static NotificationNavigator? _instance;
  RemoteMessage? _message;

  factory NotificationNavigator({void Function()? onNoInitialMessage}) {
    return _instance ??= NotificationNavigator._(
      onNoInitialMessage: onNoInitialMessage,
    );
  }

  Future<void> init() async {
    _message = await FirebaseMessaging.instance.getInitialMessage();
    if (_message != null) {
      log('📬 Initial message found, routing...');
      onRoutingMessage(_message);
    } else {
      log('📭 No initial message');
      onNoInitialMessage?.call();
    }
  }

  void onRoutingMessage(RemoteMessage? message) {
    if (message == null) return;
    log('🧭 Routing notification...');
    NotificationRoutes.navigateByType(message.data);
  }

  final void Function()? onNoInitialMessage;
}

class NotificationActionListener {
  final void Function(Map<String, dynamic> data) onMessage;
  final List<NotificationType> types;

  bool conditionCheck(NotificationType type) {
    return types.any((e) => e.index == type.index);
  }

  NotificationActionListener({required this.types, required this.onMessage});
}
