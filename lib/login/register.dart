import 'package:Replace/network/Authentication.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RegisterState();

}

class RegisterState extends State<RegisterPage>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void initState(){
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextFormField username = TextFormField(controller: usernameController, decoration: InputDecoration(
      labelText: "Username",
    ),);
    TextFormField password = TextFormField(controller: passwordController, decoration: InputDecoration(
      labelText: "Password",
    ), obscureText: true,);

    FlatButton RegisterButton = FlatButton(child: Text("Register"), onPressed: register,);
    return PromptPage(child: Column(children: <Widget>[
      username, password, RegisterButton
    ],),);
  }

  void register(){
     String username = usernameController.text;
     String password = passwordController.text;
     Authentication authentication = Authentication();
     authentication.registerUser(username, password);
     Navigator.push(context, MaterialPageRoute(builder: (_) {
       return LoginPage();
     }));
  }

}