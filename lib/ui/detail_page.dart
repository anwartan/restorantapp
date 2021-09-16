import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/customer_review.dart';
import 'package:restoranapp/data/model/item.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/provider/favorite_provider.dart';
import 'package:restoranapp/ui/add_review_page.dart';
import 'package:restoranapp/widget/card_item.dart';
import 'package:restoranapp/widget/empty_animation.dart';

class DetailPage extends StatefulWidget {
  static const routeName="/detailPage";
  Restorant restorant;
  DetailPage({required this.restorant});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
 
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddReviewPage.routeName,arguments: widget.restorant).then(onGoBack);
        },
        child: const Icon(Icons.reviews),
        backgroundColor: Colors.green,),
      body: NestedScrollView(headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            actions: [
               IconButton(onPressed: (){
                  Provider.of<FavoriteProvider>(context,listen: false).addFavorite(widget.restorant);
                  }, 
                  icon: Consumer<FavoriteProvider>(builder: (context,state,_){
                    if(state.isExist(widget.restorant.id)){
                      
                      return Icon(Icons.favorite);
                    }else{
                      return Icon(Icons.favorite_border_outlined);
                    }
                  }),
                ),
            ],
            title: Text(widget.restorant.name),
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
                        image: NetworkImage(ApiService.baseImageUrl+ widget.restorant.pictureId),
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
                      widget.restorant.rating.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Icon(Icons.star,color: Colors.yellow,)
                ],),
                SizedBox(height: 8),
                Text(
                  widget.restorant.description,
                  style: Theme.of(context).textTheme.caption,
                ),
                FutureBuilder<Restorant>(    

                  future: ApiService().fetchRestaurant(widget.restorant.id),
                  builder: (context,snapshot){
                    var state = snapshot.connectionState;
                    if (state != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }else{
                      Restorant newRestorant ;
                      if(snapshot.hasData){
                        newRestorant = snapshot.data!;
                        widget.restorant = snapshot.data!;
                        var menu = newRestorant.menu!;
                        return  Column(children: [
                        _buildList(context,menu.foods,"Foods"),
                        _buildList(context,menu.drinks,"Drinks"),  
                        _buildListReview(context,widget.restorant.customerReview)                      
                        ],);
                        
                        
                      }else{
                        return AnimationPage(message: "Failed to get another data, Please try again",icon: Icons.error,);
                      }                 
                    }
                  },
                ), 
              ],
            ),
          ),
          
        ],
      ),),
    );
  }

  Widget _wrapperSection(BuildContext context,String title,Widget widget){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Divider(indent: 0),
        SizedBox(height: 8),
        Text(
              title,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
              
            ),
        SizedBox(height: 8),
        widget
    ],);
  }

  Widget _buildList(BuildContext context,List<Item> items,String title){
    return _wrapperSection(context, title, Container(
          height: 100,
          child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) => 
                      CardItem(item: items[index])
                  ),
        ),);
  }

  Widget _buildListReview(BuildContext context,List<CustomerReview> reviews){
    return _wrapperSection(context, "Reviews", ListView.builder(
      physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: reviews.length,
                itemBuilder: (BuildContext context, int index) => 
                  ListTile(
                    trailing: Text(reviews[index].date),
                    isThreeLine: true,
                    leading:CircleAvatar(
                      backgroundImage: NetworkImage("https://ui-avatars.com/api/?background=random&name="+reviews[index].name),
                    ),
                    title: Text(reviews[index].name),
                    subtitle: Text(
                      reviews[index].review,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                      onTap: () {
                        
                    },
                  )
              ),);
  }
}