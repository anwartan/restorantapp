import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/provider/favorite_provider.dart';
import 'package:restoranapp/widget/card_restaurant.dart';
import 'package:restoranapp/widget/empty_animation.dart';
class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Consumer<FavoriteProvider>(builder: 
        (context,state,_){
          print(state.favorites.isEmpty);
            if (state.favorites.isEmpty) {
              return AnimationPage(message: "Restaurant is not found,\n Type restaurant name or menu",icon: Icons.error_rounded,);
            }else{
                return ListView.builder(
                      itemCount: state.favorites.length,
                      itemBuilder: (context,index){
                        return CardRestaurant(restorant: state.favorites[index]);
                      }, 
                );
              }
            }
           
        )
    );
  }
}