import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/widgets/youtubeentry.dart';
import 'package:flutter/cupertino.dart';

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

    return ListView(physics: BouncingScrollPhysics(), children: channels,);
  }
}