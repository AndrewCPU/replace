import 'package:Replace/pages/widgets/animatedbackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../../colorsheet.dart';

class PromptPage extends StatefulWidget {
  Widget child;
  PromptPage({this.child});

  @override
  State createState() => PromptState(child: child);
}

class PromptState extends State<PromptPage>{
  Widget child;
  PromptState({this.child}){
      FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
      FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).backgroundColor);


    Size size = MediaQuery.of(context).size;

    Container logoContainer = Container(child:  Image.network("http://replace.live/bigr/logo.jpg", height: size.height / 4,), margin: EdgeInsets.only(top: 35, bottom: 85),);

    Hero logo = Hero(tag: "logo",child: logoContainer,);

    Card card = Card(child: Container( padding: EdgeInsets.all(10),child:child), color: Theme.of(context).cardColor,);
    SizedBox sizedBox = SizedBox(child: card, width: size.width <= 700 ? size.width : size.width / 2,);
    return Scaffold(      resizeToAvoidBottomInset: true, resizeToAvoidBottomPadding: true,
      body: Stack(children: <Widget>[AnimatedBackground(), Center(child: Column(children: <Widget>[logo, sizedBox],))],), backgroundColor: Theme.of(context).backgroundColor,);
  }
}