import 'package:flutter/material.dart';
import 'package:Replace/pages/home.dart';
import 'package:qr_flutter/qr_flutter.dart';

/*
Name of file: scanqr.dart
Purpose: The purpose of the file is to present a button where users will 
be able to click in order to access the scan qr feature
Version and date: Version 2, last modified on 5/1/2020
Author: Andrew Stein, refactored by Larry Long
Dependencies: home.dart file, material flutter package, qr flutter package
 */
class ScanQrView extends StatefulWidget {
  @override
  _ScanQrViewState createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  HomeState qrGetter = HomeState();

  @override
  //build function for widgets and displaying UI
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .05,
        bottom: MediaQuery.of(context).size.height * .05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Connect',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * .05),
          ),
          Center(
            child: GestureDetector(
              child: qrGetter.qr,
              onTap: () {
                print("Refreshing: to " + HomeState.currentTVID);
                setState(() {
                  qrGetter.qr = QrImage(
                    data: HomeState.currentTVID,
                    version: QrVersions.auto,
                    size: 200.0,
                  );
                });
              },
            ),
          ),
          Center(
            child: OutlineButton(
                child: Text("Scan a TV"),
                onPressed: () {
                  qrGetter.updateQR();
                }),
          ),
        ],
      ),
    );
  }
}
