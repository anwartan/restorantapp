import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/response.dart';
import 'package:restoranapp/main.dart';
import 'package:restoranapp/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();
 
class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }
 
  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    Response result = await ApiService().fetchRestaurants();
    Random rand = Random();
    int random = rand.nextInt(result.restaurants.length);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result.restaurants[random]);
    print("hello");
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
 
  Future<void> someTask() async {
    print('Execute some process');
  }
}