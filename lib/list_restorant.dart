import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restoranapp/detail_page.dart';
import 'package:restoranapp/response.dart';
import 'package:restoranapp/restorant.dart';

class ListRestaurant extends StatefulWidget {
  static const routeName = '/list_restaurant';
  
  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  bool isSearching =false;
  String titleSearch="";
  List<Restorant> restaurantArr = [];
  var textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching? Text(
          'Restaurant'
        ):TextField(
          controller: textController,
          onChanged: (text){
            setState(() {
              this.titleSearch=text;
              
              if(restaurantArr.indexWhere((element) => element.name.contains(titleSearch))==-1){
                showAlertDialog(context,"Restaurant is not found",(){
                  Navigator.pop(context);
                });
              }
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: 
            InputDecoration(
              icon: Icon(Icons.search,color: Colors.white,),
              hintText: "Type Restaurant Name",
              hintStyle: TextStyle(color: Colors.white)
            ),),
        actions: [
           isSearching? IconButton(onPressed: (){
             setState(() {
               this.isSearching=false;
               this.titleSearch="";
             });
           }, icon: Icon(Icons.cancel)
           ):
           IconButton(onPressed: (){
             setState(() {
               this.isSearching=true;
             });
           }, icon: Icon(Icons.search)
           )
        ],
      ),
      body: FutureBuilder<String>(
        
        future: 
          DefaultAssetBundle.of(context).loadString('assets/restorant.json'),
          builder: (context,snapshot){
            if(snapshot.hasData){
              
              final Response response = Response.fromJson(jsonDecode(snapshot.data!));
              restaurantArr = response.restaurants;
            }else if(snapshot.hasError){
              showAlertDialog(context, "Restaurant is not found", () {
                Navigator.pop(context);
               });
            }
            return ListView.builder(
              itemCount: restaurantArr.length,
              itemBuilder: (context,index){
                if(restaurantArr[index].name.contains(this.titleSearch)){
                  return _buildRestorantItem(context,restaurantArr[index]);
                }
                return Container();
              },
            );
          },
      ),
    );
  }

  Widget _buildRestorantItem(BuildContext context, Restorant restorant) {
    return Card(

            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, DetailPage.routeName,arguments: restorant);
                    },
                    child:  ClipRRect(
                    child: Image.network(
                      restorant.pictureId,                
                    ),
                  ),
                ), 
                ListTile(
                  
                  isThreeLine: true,
                  leading:CircleAvatar(
                    backgroundImage: NetworkImage(restorant.pictureId)),
                  title: Text(restorant.name),
                  subtitle: Text(
                    restorant.city+"\n"+restorant.rating.toString()+" rating",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                   onTap: () {
                    Navigator.pushNamed(context, DetailPage.routeName,arguments: restorant);
                  },
                  
                ),
              ],
            ),
            
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