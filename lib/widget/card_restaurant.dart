import 'package:flutter/material.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  
  final Restorant restorant; 
  const CardRestaurant({required this.restorant});
  @override
  Widget build(BuildContext context) {
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
                     ApiService.baseImageUrl+ restorant.pictureId,                
                    ),
                  ),
                ), 
                ListTile(
                  
                  isThreeLine: true,
                  leading:CircleAvatar(
                    backgroundImage: NetworkImage( ApiService.baseImageUrl+restorant.pictureId)),
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