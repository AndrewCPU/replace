import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../colorsheet.dart';

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
