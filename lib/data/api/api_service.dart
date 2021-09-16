import 'dart:convert';
import 'package:restoranapp/data/model/response.dart';
import 'package:http/http.dart' as http;
import 'package:restoranapp/data/model/restorant.dart';

class ApiService{
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseImageUrl = _baseUrl+"images/medium/";
  
  Future<Response> fetchRestaurants() async {
   final response =
       await http.get(Uri.parse(_baseUrl+"list"));
   if (response.statusCode == 200) {
     
    return Response.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to load restaurant');
   }
 }
 Future<Restorant> fetchRestaurant(String id) async {
   final response =
       await http.get(Uri.parse(_baseUrl+"detail/"+id));
   if (response.statusCode == 200) {
     var a = Restorant.fromJson(jsonDecode(response.body)['restaurant']);
     
    return a;
   } else {
     throw Exception('Failed to load restaurant');
   }
 }
 Future<bool> addNewReview(String id,String name,String review) async {
   final response =
       await http.post(Uri.parse(_baseUrl+"review"),body: {'id':id,'name':name,'review':review});
   if (response.statusCode == 200) {
     
    return true;
   } else {
     throw Exception('Failed to send review');
   }
 }
  
 Future<Response> searchRestorant(String text) async{
   final response =
       await http.get(Uri.parse(_baseUrl+"/search?q="+text));
   if (response.statusCode == 200) {
     var a = Response.fromJson(jsonDecode(response.body));
     
    return a;
   } else {
     throw Exception('Failed to load restaurant');
   }
 }
}