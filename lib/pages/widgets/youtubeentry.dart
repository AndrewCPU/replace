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
    Widget img = Image.network("https://img.youtube.com/vi/$videoURL/hqdefault.jpg");
    img = ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: img,
    );
    return  GestureDetector(onTap: (){
      playEpisode(videoURL);
    },
      child:
      Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 5,child: ListTile(//https://www.youtube.com/results?search_query=24+7+live+stream
        title:
        Card(shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)), color: Theme.of(context).backgroundColor,elevation: 5,
          child:
          Container(height: 300, child:
          Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 10), child:img,),
          ]),)
        ),
      )),
    );
  }
  void playEpisode(String a){
    print("SENDING PLAY CODE FOR " + a);
    var tvID = HomeState.currentTVID;
    YoutubeConnection.get("http://replace.live:3000/control/play_video?tvID=$tvID&channelID=$a", (response){

    });
  }
}