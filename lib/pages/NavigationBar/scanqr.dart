import 'package:flutter/material.dart';
import 'package:Replace/pages/home.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQrView extends StatefulWidget {
  @override
  _ScanQrViewState createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  HomeState qrGetter = HomeState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
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
        OutlineButton(
            child: Text("Scan a TV"),
            onPressed: () {
              qrGetter.updateQR();
            }),
      ],
    );
  }
}
