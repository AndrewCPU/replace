import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'colorsheet.dart';
import 'login/login.dart';
import 'login/register.dart';
import 'login/subscribe.dart'; //imported subscribe.dart

void main(){
  // ignore: undefined_prefixed_name


  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  static bool mobile = false;
  Widget app;
  static const MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  MyApp(){
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    WidgetsFlutterBinding.ensureInitialized();

    this.app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: white,
        backgroundColor: white,
        accentColor: Colors.cyan,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Login'),
    );
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return app;
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  void navigateToLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  void navigateToRegister(){
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return RegisterPage();
    }));
  }
  //added way to navigate to subscription page
  void navigateToSubscribe() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SubscribePage();
    }));
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
    FlutterStatusbarcolor.setNavigationBarColor(Theme.of(context).backgroundColor);

    Text title = Text("Welcome to REPLACE", style: TextStyle(fontSize: 30),);
    Size size = MediaQuery.of(context).size;
    if(size.width < 600) MyApp.mobile = true;
    else MyApp.mobile = false;
    Widget login = MaterialButton(padding: EdgeInsets.all(15),  elevation: 6, minWidth: 300, child: Text("Login", style: TextStyle(color: Colors.black),), color: Theme.of(context).accentColor, onPressed:navigateToLogin, shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ), );
    Widget register = MaterialButton(padding: EdgeInsets.all(15), elevation: 6, minWidth: 300, child: Text("Register", style: TextStyle(color: Colors.black),), color: Colors.transparent, onPressed:navigateToRegister, shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.white70)
    ),);
    Widget subscribe = MaterialButton(padding: EdgeInsets.all(15), elevation: 6, minWidth: 300, child: Text("Subscribe", style: TextStyle(color: Colors.black),), color: Colors.transparent, onPressed:navigateToSubscribe, shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.white70)
    ),);


    login = Padding(padding: EdgeInsets.all(20), child: login,);
    register = Padding(padding: EdgeInsets.all(20), child: register,);
    subscribe = Padding(padding: EdgeInsets.all(20), child: subscribe,);

    Container options = Container(height: size.height / 3, margin: EdgeInsets.only(top: size.height / 4), child: ListView(children: <Widget>[(login), register, subscribe]));

    Container logoContainer = Container(child:  Image.network("https://i.ya-webdesign.com/images/r-logo-png-12.png", height: size.height / 3,), margin: EdgeInsets.only(top: kBottomNavigationBarHeight / 8),);

    Hero logo = Hero(tag: "logo",child: logoContainer,);

    return Scaffold(body:Stack(children: <Widget>[
      Center(child: Column(children: <Widget>[
        logo, options,
      ],),)

    ],), backgroundColor: Theme.of(context).backgroundColor,);
  }
}