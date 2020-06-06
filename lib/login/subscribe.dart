import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';

/*
Name of file: subscribe.dart
Purpose: The purpose of the file is for users to input their email and subrscribe to a mailing list.
Version and date: Version 2, last modified on 5/2/2020
Author: Andrew Stein, Larry Long, Justin Daniel
Dependencies: material and cupertino flutter package, flutterstatusbar package, email validator package
colorsheet.dart, promptpage.dart, home.dart, 
 */
class SubscribePage extends StatefulWidget {
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setNavigationBarColor(Colorsheet.background);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Text mailing = Text(
      'Subscribe to our mailing list!',
      style: Theme.of(context).textTheme.title,
    );
    //text form for email input
    TextFormField email = TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
      ),
      controller: _controller,
    );
    //text form for name input
    TextFormField name = TextFormField(
      decoration: InputDecoration(
        labelText: "Full Name",
      ),
    );

    FlatButton subscribeButton = FlatButton(
      child: Text("Subscribe"),
      onPressed: subscribe,
    );
    return PromptPage(
      child: Column(
        children: <Widget>[mailing, email, name, subscribeButton],
      ),
    );
  }

  //no parameter
  //no return
  //takes in email input from user
  //still in progress
  void subscribe() {
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
