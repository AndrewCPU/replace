import 'dart:math';

import 'package:Replace/colorsheet.dart';
import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouTubeEntry extends StatelessWidget{
  String videoTitle;
  String videoURL;

  YouTubeEntry({this.videoTitle, this.videoURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      playEpisode(videoURL);
    },
    child: ListTile(//https://www.youtube.com/results?search_query=24+7+live+stream
      title: Card(color: Colorsheet.accent,elevation: 5,
          child: Column(children: <Widget>[
            Image.network("https://img.youtube.com/vi/$videoURL/hqdefault.jpg"),
          Padding(child:OutlineButton(onPressed: () => playEpisode(videoURL), child: Center(child: Row(children: <Widget>[Icon(Icons.play_circle_outline), Text("Watch")],),),), padding: EdgeInsets.all(15),) ]),),
    ),);
  }
  void playEpisode(String a){
    print("SENDING PLAY CODE FOR " + a);
    var tvID = HomeState.currentTVID;
    YoutubeConnection.get("http://replace.live:3000/control/play_video?tvID=$tvID&channelID=$a", (response){

    });
  }
}