import 'dart:convert';
import 'package:restoranapp/menu.dart';

class Restorant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menu menu;

  Restorant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu,
  });

  factory Restorant.fromJson(Map<String, dynamic> restorant) => Restorant(
    id: restorant['id'],
    name : restorant['name'],
    description : restorant['description'],
    pictureId : restorant['pictureId'],
    city :restorant['city'],
    rating : restorant['rating'].toDouble(),
    menu : Menu.fromJson(restorant['menus']),
  );

  Map<String,dynamic> toJson() => {
     "id" : id,
    "name" :name,
    "description" : description,
    "pictureId" : pictureId,
    "city" : city,
    "rating" :  rating,
    "menu": menu.toJson(),
  };
}

List<Restorant> parseRestorant(String? json){
 
  if(json==null){
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((e) => Restorant.fromJson(e)).toList();
}