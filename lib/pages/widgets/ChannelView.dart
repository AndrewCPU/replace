import 'dart:math';

import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/widgets/youtubeentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChannelView extends StatefulWidget {
  String mode;
  ChannelView({this.mode});
  @override
  State<StatefulWidget> createState() => _ChannelState(mode: mode);
}

class _ChannelState extends State<ChannelView> {
  YoutubeConnection youtubeConnection = new YoutubeConnection();
  String mode;
  List<Widget> channels = [];

  _ChannelState({this.mode}) {
    loadChannels(this.mode);
  }

  void loadChannels(mode) {
    youtubeConnection.getChannels(mode, (response) {
      List<Widget> channels = [];
      for (String channel in response) {
        channel = channel.replaceAll("?v=", "");
        channels.add(YoutubeEntry(videoURL: channel));
      }
      setState(() {
        this.channels = channels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    channels.sort((a, b) => (a as YoutubeEntry).compareTo(b as YoutubeEntry));

    var words = [
      "Watch",
      "Enjoy",
      "View",
      "Observe",
      "Check",
      "Study",
      "Inspect",
      "Examine",
      "Behold"
    ];

    var text = new RichText(
      textAlign: TextAlign.left,
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: Theme.of(context).textTheme.title.merge(TextStyle(fontSize: 30)),
        children: <TextSpan>[
          new TextSpan(
              text: words[Random().nextInt(words.length)] + " ",
              style: TextStyle(fontWeight: FontWeight.w200)),
          new TextSpan(
              text: mode, style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );

    return Column(
      children: <Widget>[
        text,
        Container(
          margin: EdgeInsets.only(
            //top: 30,
            bottom: 35,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: channels,
            padding: EdgeInsets.only(bottom: 10, top: 20),
            scrollDirection: Axis.horizontal,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          //height:400
        )
      ],
    );
  }
}
