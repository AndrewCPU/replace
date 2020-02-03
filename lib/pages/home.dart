

import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/widgets/ChannelView.dart';
import 'package:Replace/pages/widgets/youtubeentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:Replace/colorsheet.dart';
import 'package:Replace/pages/widgets/navbar.dart';

import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends StatefulWidget{
  String collapsedText;
  Widget panel;
  String title;
  HomePage({this.collapsedText, this.panel, this.title}){
    // ignore: undefined_prefixed_name

  }
  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends State<HomePage>{
  String collapsedText;
  Widget panel;
  String title;
  static String currentTVID = "apple";
  QrImage qr;
  YoutubeConnection youtubeConnection = YoutubeConnection();

  void initState(){
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }
  HomeState(){
    collapsedText = "Controls";
    title = "Replace.LIVE";
//    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
//    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).backgroundColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    qr = QrImage(
      data: "$currentTVID",
      version: QrVersions.auto,
      size: 200.0,
    );
  }




  String uid = "cQWD0j0ow9";

  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).backgroundColor);

    Size size = MediaQuery.of(context).size;

    Container logoContainer = Container(child:  Image.network("https://i.ya-webdesign.com/images/r-logo-png-12.png", height: size.height / 15,), margin: EdgeInsets.only(top: kBottomNavigationBarHeight / 8),);

    Hero logo = Hero(tag: "logo",child: logoContainer,);
    var arr = ["cartoons","news","music","edm","weather","games streaming","art","programming","video gaming", "league of legends", "minecraft", "music videos"];

//    SizedBox sizedBox = SizedBox(child: card, width: size.width <= 700 ? size.width : size.width / 2,);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        parallaxEnabled: true,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        color: Theme.of(context).backgroundColor,
        panel: Padding(padding: EdgeInsets.only(top: 70, left: 20, right: 20),child: Center(child: Column(children: <Widget>[
          GestureDetector(child: qr, onTap: (){
            print("Refreshing: to " + currentTVID);
              setState(() {
                qr = QrImage(
                  data: currentTVID,
                  version: QrVersions.auto,
                  size: 200.0,
                );
              });
          },),           OutlineButton(child: Text("Scan a TV"), onPressed: updateQR),
        ],))),
        collapsed: Center(child: OutlineButton( onPressed: open,child: Text(this.collapsedText, style: TextStyle(fontWeight: FontWeight.bold),))),
        body: Stack(children: <Widget>[


//          IndexedStack(children: <Widget>[SizedBox(child: VideoPlayer(), width: size.width, height: size.height / 2)],),
            new Container(
              child:
              Center(
                child:
                   Container(
                      margin: EdgeInsets.only(top: 100), child:
                   ListView.builder(itemCount: 10, itemBuilder: (context,  index){
//                        return Text(index.toString());
                        return ChannelView(mode: arr[index],);

                        //return Container(child: Text( (index.toString() + " INDEX")),);
                   }, scrollDirection: Axis.vertical, physics: BouncingScrollPhysics(),)
                  ,
                padding: EdgeInsets.only(top: 20, bottom: 20),),
              ),
              height: size.height,
              width: 500.0,
            ),
          NavigationBar(child: Row(children: <Widget>[
    logo, Center(child:Padding(padding: EdgeInsets.all(10),child:Text("Replace DOT Live", style: Theme.of(context).textTheme.title,) ,),)
    ],),)  ],)
      )
    );
  }

  void open(){
    panelController.open();
  }
  void updateQR() {
    print("UPDATE");
    scanner.scan().then((resp){
      print("THIS IS THE SCANNER CALLBACK SAYING " + resp);
        currentTVID = resp;
        print(resp);
        setState(() {
          qr = QrImage(
            data: resp,
            version: QrVersions.auto,
            size: 200.0,
          );
        });
    }).whenComplete(() {
      setState(() {
        print("Restating");
      });
    });

  }
}


class WebHomePage extends StatefulWidget{
  @override
  State createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage>{

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Web version"));
  }
}

