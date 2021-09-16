import 'package:flutter/foundation.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/response.dart';
import 'package:restoranapp/data/model/restorant.dart';
enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  
  RestaurantProvider({required this.apiService}){
    _fetchAllRestaurant();
  }
  late List<Restorant> _restaurantList ;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  List<Restorant> get restaurants =>_restaurantList;
  ResultState get state => _state;
  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final Response response = await apiService.fetchRestaurants();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = response.restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}