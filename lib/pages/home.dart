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
      setState(() {
        currentTVID = prefs.getString("qrcode");
      });
    });
    qr = QrImage(
      data: "$currentTVID",
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  String uid = "cQWD0j0ow9";

  PanelController panelController = PanelController();

  //navbar

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

  //page swipe
  final pageController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).cardColor);
    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).cardColor);

    Size size = MediaQuery.of(context).size;

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
        body: SlidingUpPanel(
            controller: panelController,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            parallaxEnabled: true,
            backdropTapClosesPanel: true,
            backdropEnabled: true,
            color: Theme.of(context).cardColor,
            panel: Padding(
                padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      //TODO how to get swipe to change current tab bar too
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: CupertinoSegmentedControl(
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
                            //TODO fix swipe feature
                            physics: NeverScrollableScrollPhysics(),
                            controller: pageController,
                            children: tabViews,
                            onPageChanged: (index) {
                              selectedTab = index;
                            }),
                      )
                    ],
                  ),
                )),
            collapsed: Center(
                child: OutlineButton(
                    onPressed: open,
                    child: Text(
                      this.collapsedText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
            body: Stack(children: <Widget>[
//          IndexedStack(children: <Widget>[SizedBox(child: VideoPlayer(), width: size.width, height: size.height / 2)],),
              new Container(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: ListView.builder(
                      itemCount: arr.length + 1,
                      cacheExtent: 1500 * 3.0,
                      itemBuilder: (context, index) {
//                        return Text(index.toString());
                        if (index == arr.length) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 100),
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
                ),
                height: size.height,
                width: 500.0,
              ),
              NavigationBar()
            ])));
  }

  void open() {
    panelController.open();
  }

  void saveLocally(qrCode) async {
    //https://github.com/flutter/plugins/tree/master/packages/shared_preferences/shared_preferences
    /*
    todo save QR CODE string and load it on app start
     */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('qrcode', qrCode);
  }

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
