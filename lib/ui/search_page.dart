
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/provider/restaurant_provider.dart';
import 'package:restoranapp/provider/search_provider.dart';
import 'package:restoranapp/widget/card_restaurant.dart';
import 'package:restoranapp/widget/empty_animation.dart';
class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching =false;
  var textController = new TextEditingController();
  String titleSearch="";
  
  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      appBar:  AppBar(
        title: TextField(
          controller: textController,
          onSubmitted: (text){
            setState(() {
              this.titleSearch=text;
              Provider.of<SearchProvider>(context,listen: false).fetchSearchRestaurants(text);
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: 
            InputDecoration(

              hintText: "Type Restaurant Name or Menu",
              hintStyle: TextStyle(color: Colors.white)
            ),),
        actions: [
           IconButton(onPressed: (){
             setState(() {
               textController.clear();
             });
           }, icon: Icon(Icons.cancel)
           )
        ],
      
      ),
     body: Consumer<SearchProvider>(
       builder: (context,state,_){
          if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {

          return ListView.builder(
                itemCount: state.searchRestaurant.length,
                itemBuilder: (context,index){
                  return CardRestaurant(restorant: state.searchRestaurant[index]);
                },
              );
        } else if (state.state == ResultState.NoData) {
          return AnimationPage(message: "Restaurant is not found,\n Type restaurant name or menu",icon: Icons.error_rounded,);
        } else if (state.state == ResultState.Error) {
          return AnimationPage(message: "Something was wrong !!!",icon: Icons.cancel,);
        } else {
          return Center(child: Text(''));
        }
     }),
    );
  }
}