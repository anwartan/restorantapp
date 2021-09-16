
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/ui/detail_page.dart';
import 'package:restoranapp/ui/favorite_page.dart';
import 'package:restoranapp/provider/restaurant_provider.dart';
import 'package:restoranapp/ui/search_page.dart';
import 'package:restoranapp/ui/setting_page.dart';
import 'package:restoranapp/utils/notification_helper.dart';
import 'package:restoranapp/widget/card_restaurant.dart';
import 'package:restoranapp/widget/empty_animation.dart';
class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  bool isSearching =false;
  String titleSearch="";
  List<Restorant> restaurantArr = [];
  List<Restorant> tmp = [];
  var textController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if(index==1){
      Navigator.pushNamed(context, FavoritePage.routeName);
    }else if(index==2){
      Navigator.pushNamed(context, SettingPage.routeName);
    }
    
  }
  @override
  void initState() {

    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        DetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
        actions: [
          
           IconButton(onPressed: (){
             Navigator.pushNamed(context, SearchPage.routeName);
           }, icon: Icon(Icons.search)
           ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: Consumer<RestaurantProvider>(
       builder: (context,state,_){
          if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {

          return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context,index){
                  return CardRestaurant(restorant: state.restaurants[index]);
                },
              );
        } else if (state.state == ResultState.NoData) {
          return AnimationPage(message: "Restaurant is not found,\n Type restaurant name",icon: Icons.error_rounded,);
        } else if (state.state == ResultState.Error) {
          return AnimationPage(message: "Something was wrong !!!",icon: Icons.cancel,);
        } else {
          return Center(child: Text(''));
        }
     }),
      
    );
  }
  
}

showAlertDialog(BuildContext context,String message,VoidCallback action ) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: action
  );
  AlertDialog alert = AlertDialog(
    title: Text("Information"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}