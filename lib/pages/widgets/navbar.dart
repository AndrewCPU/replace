import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget{
  Widget child;
  NavigationBar({this.child});
  @override
  State createState() => NavigationState(child: child);
}

class NavigationState extends State<NavigationBar>{
  Widget child;
  NavigationState({this.child});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Container logoContainer = Container(child:  Image.network("https://i.ya-webdesign.com/images/r-logo-png-12.png", height: h / 15,), margin: EdgeInsets.only(top: kBottomNavigationBarHeight / 8),);

    Hero logo = Hero(tag: "logo",child: logoContainer,);
    return Positioned(top: statusBarHeight, left: 0, child: Center(
        child:
        SizedBox(
          child:
          Container(
            decoration:
            BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))),
            child:
        Row(children: <Widget>[
      logo, Center(child:Padding(padding: EdgeInsets.all(10),child:Text("Replace DOT Live", style: Theme.of(context).textTheme.title,) ,)
          )])
      ),
      width: w, height: h / 10,)
      )
    );
  }
}