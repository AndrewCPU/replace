import 'package:Replace/network/Authentication.dart';
import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';
import '../main.dart';

import 'changepass.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
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
    // TODO: implement build
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
    FlatButton LoginButton = FlatButton(
      child: Text("Login"),
      onPressed: login,
    );
    MaterialButton ForgotPasswordButton = MaterialButton(
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
      onPressed: forgotpassword,
    );

    return PromptPage(
      child: Column(
        children: <Widget>[
          username,
          password,
          Container(
            alignment: Alignment.centerRight,
            child: ForgotPasswordButton,
          ),
          LoginButton
        ],
      ),
    );
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;
    Authentication authentication = Authentication();
    authentication.loginUser(username, password);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      if (MyApp.mobile) return HomePage();
      return WebHomePage();
    }));
  }

  void forgotpassword() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ChangePassPage()));
  }
}
