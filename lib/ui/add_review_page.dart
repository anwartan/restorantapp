import 'package:flutter/material.dart';
import 'package:restoranapp/data/api/api_service.dart';
import 'package:restoranapp/data/model/restorant.dart';
import 'package:restoranapp/ui/home_page.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = '/add_review_page';
  Restorant restorant;
  AddReviewPage({required this.restorant});
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  
  

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController review = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Add Review"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'What is your name ?',
                labelText: 'Name *',
              ),
              controller: name,
               validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Name is required.' : null;
                },
            )
            ,
            SizedBox(
              height:10,
            )
            ,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'What is your review ?',
                labelText: 'Reviews *',
              ),
              controller: review,
              onSaved: (String? value){
        
              },
              validator: (String? value) {
                return (value == null || value.isEmpty ) ? 'Review is required.' : null;
              },
            ),
             SizedBox(
              height:10,
            )
            ,
            ElevatedButton.icon(
              
              onPressed:  () async {
                if(name.value.text.isNotEmpty && review.value.text.isNotEmpty){
                  var response = await  ApiService().addNewReview(widget.restorant.id, name.value.text, review.value.text);
                 if(response){
                   await Future.delayed(Duration.zero,(){
                     showAlertDialog(context, "Successfull", (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                   });
                   
                 }else{
                   await Future.delayed(Duration.zero,(){
                     showAlertDialog(context, "Failed to send review", (){
                      Navigator.pop(context);
                    });
                   });
                   
                 }
                }else{
                  await Future.delayed(Duration(seconds: 2),(){
                     showAlertDialog(context, "Please check again !!!", (){
                      Navigator.pop(context);
                    });
                   });
                }
                 
              },
              icon: Icon(Icons.send, size: 18),
              label: Text("Send Your Review"),
            ),
           
          ],
        ),
      ) ,
    );
  }
}