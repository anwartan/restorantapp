import 'package:flutter/material.dart';
import 'package:restoranapp/item.dart';
import 'package:restoranapp/restorant.dart';

class DetailPage extends StatelessWidget {
  static const routeName="/detailPage";
  final Restorant restorant;
  const DetailPage({required this.restorant});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: NestedScrollView(headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            title: Text(restorant.name),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background:  Stack(
                children:[
                  Container(
                    width: MediaQuery.of(context).size.width,
                  
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(restorant.pictureId),
                      ),
                    ),
                  ),
                  Container(
                    
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black,
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                  )
                ],
              ),
             
            ),
          ),
        ];
            },body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
               mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                      restorant.rating.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Icon(Icons.star,color: Colors.yellow,)
                ],),
                SizedBox(height: 8),
                Text(
                  restorant.description,
                  style: Theme.of(context).textTheme.caption,
                ),
                Divider(indent: 0),
                SizedBox(height: 8),
                Text(
                      "Drinks",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                Container(
                  height: 100,
                  child:ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: restorant.menu.drinks.length,
                    itemBuilder: (BuildContext context, int index) => 
                      _buildItem(context,restorant.menu.drinks[index])
                  ),
                ),
                Divider(indent: 0),
                SizedBox(height: 8),
                Text(
                      "Foods",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                
                Container(
                  height: 100,
                  child:ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: restorant.menu.foods.length,
                    itemBuilder: (BuildContext context, int index) => 
                      _buildItem(context,restorant.menu.foods[index])
                  ),
                )
                               
              ],
            ),
          )
        ],
      ),),
    );
  }
  Widget _buildItem(BuildContext context, Item item) {
    return  Container(
              margin: EdgeInsets.only(right: 5,bottom: 5),
              width: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.network(
                    "https://media.gettyimages.com/photos/two-men-clinking-glasses-of-whiskey-drink-alcohol-beverage-together-picture-id1193256860?s=612x612",       
                    width: 100,         
                  ),
                  Text(item.name,overflow: TextOverflow.ellipsis,)
                ],
              ),
            );
  }  
}