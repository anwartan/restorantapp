import 'package:flutter/material.dart';
import 'package:restoranapp/data/model/item.dart';

class CardItem extends StatelessWidget {
  final Item item;
  const CardItem({ required this.item });

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(right: 10,bottom: 5),
            
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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(item.name,overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            );
  }
}