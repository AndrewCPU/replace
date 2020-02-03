import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/widgets/youtubeentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChannelView extends StatefulWidget{
  String mode;
  ChannelView({this.mode});
  @override
  State<StatefulWidget> createState() => _ChannelState(mode: mode);
}
class _ChannelState extends State<ChannelView>{
  YoutubeConnection youtubeConnection = new YoutubeConnection();
  String mode;
  List<Widget> channels = [];

  _ChannelState({this.mode}){
    loadChannels(this.mode);
  }


  void loadChannels(mode){
    youtubeConnection.getChannels(mode,(response){
      List<Widget> channels = [];
      for(String channel in response){
        channel = channel.replaceAll("?v=", "");
        print(channel);
        channels.add(YouTubeEntry(videoURL: channel));
      }
      setState(() {
        this.channels = channels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var text = new RichText( textAlign: TextAlign.left,
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: Theme.of(context).textTheme.title.merge(TextStyle(fontSize: 30)),
        children: <TextSpan>[
          new TextSpan(text: 'Watch '),
          new TextSpan(text: mode, style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );

    return Column(children: <Widget>[
      text,
      Container(child: ListView(physics: BouncingScrollPhysics(),
        children: channels,
        padding: EdgeInsets.only(bottom: 10),
        scrollDirection: Axis.horizontal,), width: MediaQuery.of(context).size.width, height: 400,)
    ],);

//    return ;
  }
}