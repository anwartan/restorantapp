
import 'package:restoranapp/data/model/restorant.dart';

class Response{
  late List<Restorant> restaurants;
  late bool? error;
  late String? message;
  late int? count;
  Response({
    required this.restaurants,
    required this.error,
    required this.count,
    required this.message
  });
  factory Response.fromJson(Map<String, dynamic> response)=>Response(
    count:response['count'],
    error: response['error'],
    message: response['message'],
    restaurants: List<Restorant>.from(response['restaurants'].map((x)=>Restorant.fromJson(x)))
    );
 
}
