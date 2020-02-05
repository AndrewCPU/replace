import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserGeneratedContentWidget extends StatefulWidget{

  @override
  State createState() => _UserGeneratedContentWidgetState();
}
class _UserGeneratedContentWidgetState extends State<UserGeneratedContentWidget>{

  @override
  Widget build(BuildContext context) {
    return Card(shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)),elevation: 5,child: SizedBox(width: MediaQuery.of(context).size.width * 0.85, child: Padding(padding: EdgeInsets.all(10), child:
      Center(child:
        Column(children: <Widget>[
          Icon(Icons.add_circle_outline, size: 150,),
        ],),),),),);
  }
}