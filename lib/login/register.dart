import 'package:Replace/network/Authentication.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';
import 'login.dart';

/*
Name of file: register.dart
Purpose: The purpose of the file is for users to input their email and password to create account
Version and date: Version 2, last modified on 5/2/2020
Author: Andrew Stein, Larry Long
Dependencies: material and cupertino flutter package, flutterstatusbar package, email validator package
colorsheet.dart, promptpage.dart, home.dart, login.dart, authentication.dart
 */
class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField username = TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        labelText: "Username",
      ),
    );
    TextFormField password = TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Password",
      ),
      obscureText: true,
    );

    FlatButton registerButton = FlatButton(
      child: Text("Register"),
      onPressed: register,
    );
    return PromptPage(
      child: Column(
        children: <Widget>[username, password, registerButton],
      ),
    );
  }

  void register() {
    String username = usernameController.text;
    String password = passwordController.text;
    Authentication authentication = Authentication();
    authentication.registerUser(username, password);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }
}
