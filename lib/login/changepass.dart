import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';

/*
Name of file: changepass.dart
Purpose: The purpose of the file is for users to be able to change their password and also
navigate back to the home page as well
Version and date: Version 2, last modified on 5/2/2020
Author: Larry Long
Dependencies: material and cupertino flutter package, flutterstatusbar package, email validator package
colorsheet.dart, promptpage.dart, home.dart, 
 */
class ChangePassPage extends StatefulWidget {
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Text mailing = Text(
      'Enter your email adress to reset your password',
      style: TextStyle(
        fontSize: 15.0,
      ),
    );

    TextFormField email = TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
      ),
      controller: _controller,
    );

    FlatButton changePasswordButton = FlatButton(
      child: Text("Reset"),
      onPressed: changepassword,
    );
    return PromptPage(
      child: Column(
        children: <Widget>[mailing, email, changePasswordButton],
      ),
    );
  }

  //no parameter
  // no return
  //takes in email input from user
  //still in progress
  void changepassword() {
    bool valid = EmailValidator.validate(_controller.text);
    if (valid) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return WebHomePage();
      }));
    } else {
      _controller.text = "Invalid email";
    }
  }
}
