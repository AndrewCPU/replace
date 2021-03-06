import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/widgets/ChannelView.dart';
import 'package:Replace/pages/widgets/appbar.dart';
import 'package:Replace/pages/widgets/usercontent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:Replace/pages/NavigationBar/scanqr.dart';

import 'NavigationBar/playlistpage.dart';
import 'NavigationBar/settingspage.dart';

/*
Name of file: home.dart
Purpose: The purpose of the file is to the ui for the home page, containg all the different
categories which users can watch live streams from. it displays the clickable channel cards
created from the youtubeentry.dart file and channelview.dart file. 
It also displays a sliding up panel for different features such as scanning the qr code
to connect your device and also personalizing user experience with playlists.
Version and date: Version 4, last modified on 6/5/2020
Author: Andrew Stein, some UI by Larry Long
Dependencies: qr scan, sliding up panel, shared preferences, flutter statusbar
flutter cupertino and material packages
youtubeconnection.dart, channelview.dart, appbar.dart, usercontent.dart
playlistpage.dart, settingspage.dart
 */

//stateful widget to display ui
class HomePage extends StatefulWidget {
  String collapsedText;
  Widget panel;
  String title;
  HomePage({this.collapsedText, this.panel, this.title}) {
    // ignore: undefined_prefixed_name
  }
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  String collapsedText;
  Widget panel;
  String title;
  static String currentTVID = "apple";
  QrImage qr;
  YoutubeConnection youtubeConnection = YoutubeConnection();

  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  HomeState() {
    collapsedText = "Controls";
    title = "Replace.LIVE";
//    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
//    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).backgroundColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    //todo get currentTVID (qrCode) from state
    SharedPreferences.getInstance().then((prefs) {
      currentTVID = prefs.getString("qrcode");
      if (mounted) setState(() {});
    });
    qr = QrImage(
      data: "$currentTVID",
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  String uid = "cQWD0j0ow9";

  PanelController panelController = PanelController();

  int selectedTab = 1;
  final Map<int, Widget> tabSections = const <int, Widget>{
    0: Text('Settings'), //tab 1
    1: Text('Scan'), //tab 2
    2: Text('Playlists'), //tab 3
  };
  List<Widget> tabViews = [
    SettingsPage(),
    ScanQrView(),
    PlaylistPage(),
  ];
  final pageController = PageController(
    initialPage: 1,
  );

  @override
  //build function for displaying ui
  Widget build(BuildContext context) {
    var text = new RichText(
      textAlign: TextAlign.left,
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: Theme.of(context).textTheme.title.merge(TextStyle(fontSize: 30)),
        children: <TextSpan>[
          new TextSpan(
              text: 'Submit your own ',
              style: TextStyle(fontWeight: FontWeight.w100)),
          new TextSpan(
              text: "content",
              style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
    Size size = MediaQuery.of(context).size;

    //different categories to search for youtube livestreams
    var arr = [
      "cartoons",
      "news",
      "music",
      "edm",
      "weather",
      "art",
      "music videos"
    ];

//    SizedBox sizedBox = SizedBox(child: card, width: size.width <= 700 ? size.width : size.width / 2,);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).backgroundColor,
        //sliding up panel
        body: SlidingUpPanel(
            onPanelClosed: () {
              setState(() {
                selectedTab = 1;
                pageController.animateToPage(selectedTab,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
              });
            },
            controller: panelController,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            parallaxEnabled: true,
            backdropTapClosesPanel: true,
            backdropEnabled: true,
            color: Theme.of(context).cardColor,
            minHeight: size.height * .15,
            maxHeight: size.height * 0.9,
            panel: Container(
                padding: EdgeInsets.only(
                  top: size.height * .16,
                  left: size.width * .05,
                  right: size.width * .05,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width * .8,
                      //navigation for features in panel
                      child: CupertinoSlidingSegmentedControl(
                          groupValue: selectedTab,
                          children: tabSections,
                          onValueChanged: (index) {
                            setState(() {
                              selectedTab = index;
                              pageController.animateToPage(selectedTab,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            });
                          }),
                    ),
                    Expanded(
                      child: PageView(
                          //physics: NeverScrollableScrollPhysics(),
                          controller: pageController,
                          children: tabViews,
                          onPageChanged: (index) {
                            setState(() {
                              selectedTab = index;
                            });
                          }),
                    )
                  ],
                )),
            collapsed: Container(
              child: Center(
                  child: OutlineButton(
                      onPressed: open,
                      child: Text(
                        this.collapsedText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
            ),
            body: Stack(children: <Widget>[
//          IndexedStack(children: <Widget>[SizedBox(child: VideoPlayer(), width: size.width, height: size.height / 2)],),
              Container(
                margin: EdgeInsets.only(top: size.height / 12),
                child: ListView.builder(
                  itemCount: arr.length + 1,
                  cacheExtent: 1500 * 3.0,
                  itemBuilder: (context, index) {
//                        return Text(index.toString());
                    if (index == arr.length) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: size.height * .17),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              text,
                              UserGeneratedContentWidget(),
                            ],
                          ),
                        ),
                      );
                    } else
                      return ChannelView(
                        mode: arr[index],
                      );
                  },
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.only(top: 20, bottom: 20),
              ),
              NavigationBar()
            ])));
  }

  //no paramters
  // no return value
  // opens the panel when users click on button on top of it
  // users can swipe to open as well
  void open() {
    panelController.open();
  }

  //requires qrcode string id
  //no return value
  //takes the qrcode id and saves into shared preferences for future use
  // and convenience when connecting to device
  void saveLocally(qrCode) async {
    //https://github.com/flutter/plugins/tree/master/packages/shared_preferences/shared_preferences
    /*
    todo save QR CODE string and load it on app start
     */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('qrcode', qrCode);
  }

  //no parameters
  //no return value
  //uses scanner package to scan qr code and gets the qrcode and calls
  //the saveLocally function sending the qrcode id as an argument.
  updateQR() {
    print("UPDATE");
    scanner.scan().then((resp) {
      print("THIS IS THE SCANNER CALLBACK SAYING " + resp);
      currentTVID = resp;
      print(resp);
      setState(() {
        qr = QrImage(
          data: resp,
          version: QrVersions.auto,
          size: 200.0,
        );
        //todo save
        saveLocally(currentTVID);
      });
    }).whenComplete(() {
      setState(() {
        print("Restating");
      });
    });
  }
}

class WebHomePage extends StatefulWidget {
  @override
  State createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Web version"));
  }
}
