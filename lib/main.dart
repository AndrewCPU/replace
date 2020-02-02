
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'colorsheet.dart';
import 'login/login.dart';
import 'login/register.dart';

void main(){
  // ignore: undefined_prefixed_name


  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  static bool mobile = false;
  Widget app;
  MyApp(){
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    WidgetsFlutterBinding.ensureInitialized();

    this.app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  @override
  Widget build(BuildContext context) {
    Text title = Text("Welcome to REPLACE", style: TextStyle(fontSize: 30),);
    Size size = MediaQuery.of(context).size;
    if(size.width < 600) MyApp.mobile = true;
    else MyApp.mobile = false;
    MaterialButton login = MaterialButton(padding: EdgeInsets.all(15),  elevation: 6, minWidth: 300, child: Text("Login", style: TextStyle(color: Colors.black),), color: Colorsheet.accent, onPressed:navigateToLogin, shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
    ), );
    MaterialButton register = MaterialButton(padding: EdgeInsets.all(15), elevation: 6, minWidth: 300, child: Text("Register", style: TextStyle(color: Colors.white),), color: Colors.transparent, onPressed:navigateToRegister, shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.white70)
    ),);
    MaterialButton watch = MaterialButton(padding: EdgeInsets.all(15), elevation: 6, minWidth: 300, child: Text("Watch", style: TextStyle(color: Colors.white),), color: Colors.transparent, onPressed: () => Navigator.pushNamed(context, "/widget"), shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.white70)
    ),);

    Container options = Container(margin: EdgeInsets.only(top: size.height / 4), child: Column(children: <Widget>[(login), register, watch],));

    Container logoContainer = Container(child:  Image.network("https://i.ya-webdesign.com/images/r-logo-png-12.png", height: size.height / 3,), margin: EdgeInsets.only(top: kBottomNavigationBarHeight / 8),);

    Hero logo = Hero(tag: "logo",child: logoContainer,);

    return Scaffold(body:Stack(children: <Widget>[
      Center(child: Column(children: <Widget>[
       logo, options,
      ],),)

     ],), backgroundColor: Colorsheet.background,);
  }
}
