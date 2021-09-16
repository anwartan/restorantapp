import 'package:flutter/foundation.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/response.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/provider/restaurant_provider.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  
  SearchProvider({required this.apiService});
  List<Restorant> _searchRestaurantList=[];
  
  ResultState _state = ResultState.NoData;
  String _message = '';
  String get message => _message;
  List<Restorant> get searchRestaurant =>_searchRestaurantList;
  
  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurants(String text) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final Response response = await apiService.searchRestorant(text);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurantList = response.restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}