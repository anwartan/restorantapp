import 'dart:convert';
import 'package:restoranapp/data/model/customer_review.dart';
import 'package:restoranapp/data/model/item.dart';
import 'package:restoranapp/data/model/menu.dart';

class Restorant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menu? menu;
  final List<Item> category;
  final List<CustomerReview> customerReview;
  Restorant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menu,
    required this.category,
    required this.customerReview
  });

  factory Restorant.fromJson(Map<String, dynamic> restorant) => Restorant(
    id: restorant['id'],
    name : restorant['name'],
    description : restorant['description'],
    pictureId : restorant['pictureId'],
    city :restorant['city'],
    rating : restorant['rating'].toDouble(),
    menu : Menu.fromJson(restorant['menus']),
    category: List<Item>.from(restorant['categories']?.map((x)=>Item.fromJson(x))??[]),
    customerReview: List<CustomerReview>.from(restorant['customerReviews']?.map((x)=>CustomerReview.fromJson(x))??[])
  );

  Map<String,dynamic> toJson() => {
     "id" : id,
    "name" :name,
    "description" : description,
    "pictureId" : pictureId,
    "city" : city,
    "rating" :  rating,
    "menu": menu?.toJson(),
  };
}

List<Restorant> parseRestorant(String? json){
 
  if(json==null){
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((e) => Restorant.fromJson(e)).toList();
}