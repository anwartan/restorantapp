
import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/common/navigation.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/ui/add_review_page.dart';
import 'package:restoranapp/ui/detail_page.dart';
import 'package:restoranapp/ui/favorite_page.dart';
import 'package:restoranapp/provider/favorite_provider.dart';
import 'package:restoranapp/ui/home_page.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/provider/restaurant_provider.dart';
import 'package:restoranapp/provider/scheduling_provider.dart';
import 'package:restoranapp/ui/search_page.dart';
import 'package:restoranapp/provider/search_provider.dart';
import 'package:restoranapp/ui/setting_page.dart';
import 'package:restoranapp/utils/background_service.dart';
import 'package:restoranapp/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
   FlutterLocalNotificationsPlugin();
late SharedPreferences sharedPrefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
   final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
    if (Platform.isAndroid) {
   await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>RestaurantProvider(apiService: ApiService()),),
        ChangeNotifierProvider(create: (context)=>SearchProvider(apiService: ApiService()),),
        ChangeNotifierProvider(create: (context) => SchedulingProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: MaterialApp(
         navigatorKey: navigatorKey,
        title: 'Restaurant App',
        theme: ThemeData(
        
          primarySwatch: Colors.green,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName:(context)=>HomePage(),
          SearchPage.routeName:(context)=> SearchPage(),
          FavoritePage.routeName:(context)=>FavoritePage(),
          DetailPage.routeName:(context)=>DetailPage(
            restorant: ModalRoute.of(context)?.settings.arguments as Restorant
          ),
          SettingPage.routeName:(context)=>SettingPage(),
          AddReviewPage.routeName:(context)=>AddReviewPage(
             restorant: ModalRoute.of(context)?.settings.arguments as Restorant
          )
        },
      ),
    );
  }
}

