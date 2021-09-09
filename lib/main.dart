import 'package:flutter/material.dart';
import 'package:restoranapp/detail_page.dart';
import 'package:restoranapp/list_restorant.dart';
import 'package:restoranapp/restorant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
      
        primarySwatch: Colors.green,
      ),
      initialRoute: ListRestaurant.routeName,
      routes: {
        ListRestaurant.routeName:(context)=>ListRestaurant(),
        DetailPage.routeName:(context)=>DetailPage(
          restorant: ModalRoute.of(context)?.settings.arguments as Restorant
        ),
      },
    );
  }
}

