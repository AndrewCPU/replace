import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';

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

    FlatButton ChangePasswordButton = FlatButton(
      child: Text("Reset"),
      onPressed: changepassword,
    );
    return PromptPage(
      child: Column(
        children: <Widget>[mailing, email, ChangePasswordButton],
      ),
    );
  }

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
