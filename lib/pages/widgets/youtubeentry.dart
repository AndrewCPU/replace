import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class YoutubeEntry extends StatefulWidget{
  String videoTitle;
  String videoURL;
  YoutubeEntry({this.videoTitle, this.videoURL});

  @override
  State createState() => _YouTubeEntryState(videoTitle: videoTitle, videoURL: videoURL);
}

class _YouTubeEntryState extends State<YoutubeEntry>{
  String videoTitle;
  String videoURL;
  bool voted = false;

  _YouTubeEntryState({this.videoTitle, this.videoURL});

  @override
  Widget build(BuildContext context) {

    double cardWidth = MediaQuery.of(context).size.width / 1.15;
    Widget img = Image.network("https://img.youtube.com/vi/$videoURL/hqdefault.jpg");
    img = ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: img,
    );
    return  GestureDetector(onTap: (){
      playEpisode(videoURL);
    },
      child:
      Container(width: cardWidth, child: ListTile(//https://www.youtube.com/results?search_query=24+7+live+stream
        title:
        Card(shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)),elevation: 5,
          child:
          Container(height: 300, child:
          Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 10), child:img,),
            Row(children: <Widget>[
              Container(width: cardWidth / 3.55, child: SizedBox(child: Center(child: Text("0"),), width: cardWidth / 3,),),
              Container(width: cardWidth / 3.55, child: SizedBox(child: Center(child: IconButton(icon: Icon(Icons.keyboard_arrow_up), color: Colors.greenAccent, onPressed: () => vote(1),),), width: cardWidth / 3,),),
              Container(width: cardWidth / 3.55, child: SizedBox(child: Center(child: IconButton(icon: Icon(Icons.keyboard_arrow_down), color: Colors.redAccent, onPressed: () => vote(-1),),), width: cardWidth / 3,),),
            ],),

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

  void vote(int i) {

    setState(() {
      voted = true;
    });
  }
}