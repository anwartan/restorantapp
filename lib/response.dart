import 'dart:convert';

import 'package:restoranapp/restorant.dart';

class Response{
  late List<Restorant> restaurants;
  late String? error;
  late String? message;
  late int? count;
  Response({
    required this.restaurants
  });
  Response.fromJson(Map<String, dynamic> restorant) {
    
    restaurants = parseRestorant( jsonEncode(restorant['restaurants']));
  
  }
}
