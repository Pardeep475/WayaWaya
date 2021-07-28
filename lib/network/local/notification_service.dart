import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const CHANNEL_ID = "WAYAWAYA";
  static const CHANNEL_NAME = "ZA_CO_VENUEEGAGE_WAYA";
  static const CHANNEL_DESCRIPTION = "ZA_CO_VENUEEGAGE_WAYA_DESCRIPTION";

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future init() async {
    var androidSettings = AndroidInitializationSettings('app_icon');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSettings = InitializationSettings(
        android: androidSettings, iOS: iOSSettings, macOS: null);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onClickNotification);
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onClickNotification(String payload) {
    debugPrint("click notificaiton");
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  static showSimpleNotification(String title) async {
    var androidDetails = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = new NotificationDetails(
        android: androidDetails, iOS: iOSDetails, macOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, 'Welcome to AtlantisCity', title, platformDetails,
        payload: 'Destination Screen (Simple Notification)');
  }

  Future<void> showScheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidDetails = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = NotificationDetails(
        android: androidDetails, iOS: iOSDetails, macOS: null);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Flutter Local Notification',
        'Flutter Schedule Notification',
        scheduledNotificationDateTime,
        platformDetails,
        payload: 'Destination Screen(Schedule Notification)');
  }

  static Future<void> showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      playSound: true,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Welcome to Atlantis City',
        '',
        RepeatInterval.everyMinute,
        notificationDetails,
        payload: 'Destination Screen(Periodic Notification)');
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("cover_image"),
      largeIcon: DrawableResourceAndroidBitmap("app_icon"),
      contentTitle: 'Flutter Big Picture Notification Title',
      summaryText: 'Flutter Big Picture Notification Summary Text',
    );
    var androidDetails = AndroidNotificationDetails(
        CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
        styleInformation: bigPictureStyleInformation);
    var platformDetails =
        NotificationDetails(android: androidDetails, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification',
        'Flutter Big Picture Notification', platformDetails,
        payload: 'Destination Screen(Big Picture Notification)');
  }

  Future<void> showBigTextNotification() async {
    const BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      htmlFormatBigText: true,
      contentTitle: 'Flutter Big Text Notification Title',
      htmlFormatContentTitle: true,
      summaryText: 'Flutter Big Text Notification Summary Text',
      htmlFormatSummaryText: true,
    );
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
            styleInformation: bigTextStyleInformation);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification',
        'Flutter Big Text Notification', notificationDetails,
        payload: 'Destination Screen(Big Text Notification)');
  }

  Future<void> showInsistentNotification() async {
    const int insistentFlag = 4;
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification',
        'Flutter Insistent Notification', notificationDetails,
        payload: 'Destination Screen(Insistent Notification)');
  }

  Future<void> showOngoingNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,
            autoCancel: false);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification',
        'Flutter Ongoing Notification', notificationDetails,
        payload: 'Destination Screen(Ongoing Notification)');
  }

  Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
                CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: true,
                maxProgress: maxProgress,
                progress: i);
        final NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails, iOS: null, macOS: null);
        await flutterLocalNotificationsPlugin.show(
            0,
            'Flutter Local Notification',
            'Flutter Progress Notification',
            notificationDetails,
            payload: 'Destination Screen(Progress Notification)');
      });
    }
  }
}
