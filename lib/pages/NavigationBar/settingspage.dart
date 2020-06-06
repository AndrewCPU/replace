import 'package:Replace/pages/home.dart';
import 'package:flutter/material.dart';

/*
Name of file: settingspage.dart
Purpose: The purpose of the file is to display the certain account details
Version and date: Version 2, last modified on 5/2/2020
Author: Larry Long
Dependencies: home.dart file, material flutter package
 */
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String tvID = HomeState.currentTVID;
  @override
  Widget build(BuildContext context) {
    if (tvID == null) {
      setState(() {
        tvID = 'Currently not connected';
      });
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .05,
          bottom: MediaQuery.of(context).size.height * .05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Account',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * .05),
            ),
            //TODO Save UID/email with shared pref maybe
            Text('UserID:'),
            Text('Email:'),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Text(
              'Settings',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * .03),
            ),
            //TODO perhaps add option to create a unqie name for connected TVs
            Text('Connected TV:'),
            Text('Current QR ID: $tvID'),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () {
                logout();
              },
            )
          ],
        ),
      ),
    );
  }

  void logout() {
    print('Logged out');
  }
}
