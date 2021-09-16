import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FavoriteProvider extends ChangeNotifier {
  

  FavoriteProvider(){
    _fetchAllFavorites();
  }
  late List<Restorant> _favoriteList=[] ;
  List<Restorant> get favorites =>_favoriteList;
  void _fetchAllFavorites() async {
      
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String data = prefs.getString("favorite")??"";
      List<Restorant> response = List<Restorant>.from(jsonDecode(data).map((x)=>Restorant.fromJson(x)));
      _favoriteList=response;
      notifyListeners();
  }
  void addFavorite(Restorant restorant)async{
    if(isExist(restorant.id)){
      _favoriteList.removeAt(getIndex(restorant.id));
    }else{ 
    _favoriteList.add(restorant);
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("favorite", jsonEncode(_favoriteList));
    notifyListeners();
  }
  bool isExist(String id){
    if(getIndex(id)!=-1){
      return true;
    }
    return false;
  }
  int getIndex(String id){
    return _favoriteList.indexWhere((element) => element.id==id);
  }
}
  