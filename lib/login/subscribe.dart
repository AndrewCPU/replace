import 'package:Replace/pages/home.dart';
import 'package:Replace/pages/widgets/promptpage.dart';
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
  @override
  Widget build(BuildContext context) {
    Text mailing = Text(
      'Subscribe to our mailing list!',
      style: TextStyle(
        fontSize: 16,
      ),
    );
    //text form for email input
    TextFormField email = TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
      ),
    );
    //text form for name input
    TextFormField name = TextFormField(
      decoration: InputDecoration(
        labelText: "Full Name",
      ),
    );

    FlatButton SubscribeButton = FlatButton(
      child: Text("Subscribe"),
      onPressed: subscribe,
    );
    return PromptPage(
      child: Column(
        children: <Widget>[mailing, email, name, SubscribeButton],
      ),
    );
  }

  void subscribe() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WebHomePage();
    }));
  }
}