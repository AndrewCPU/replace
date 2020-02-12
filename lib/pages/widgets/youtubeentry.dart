import 'dart:math';

import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YoutubeEntry extends StatefulWidget with Comparable {
  String videoTitle;
  String videoURL;
  int votes = 0;

  YoutubeEntry({this.videoTitle, this.videoURL}){
    //todo get votes
    this.votes = new Random().nextInt(1000);
  }

  @override
  State createState() =>
      _YouTubeEntryState(videoTitle: videoTitle, videoURL: videoURL, votes: votes);

  @override
  int compareTo(dynamic other) {
    if(other is YoutubeEntry ){
      if(other.votes > this.votes) {
        return 1;
      }
      else{
        return -1;
      }
    }
    return 0;
  }
}

class _YouTubeEntryState extends State<YoutubeEntry>
    with TickerProviderStateMixin {
  String videoTitle;
  String videoURL;
  bool voted = false;
  int votes;
  AnimationController _controller;

  _YouTubeEntryState({this.videoTitle, this.videoURL, this.votes});

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
        reverseDuration: const Duration(milliseconds: 300));
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 1.15;
    Widget img =
        Image.network("https://img.youtube.com/vi/$videoURL/hqdefault.jpg",scale: 0.2, fit: BoxFit.fill,);
    img = ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: img,
    );
    return GestureDetector(
      onTap: () {
        _controller.forward().then((onValue) {
          _controller.reverse();
        });
        playEpisode(videoURL);
      },
      child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.08).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart)),
          child: Container(
            width: cardWidth,
            child: ListTile(
              //https://www.youtube.com/results?search_query=24+7+live+stream
              title: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 5,
                child: Container(
                  height: 300,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: img,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: cardWidth / 3.55,
                          child: SizedBox(
                            child: Center(
                              child: Text(votes.toString()),
                            ),
                            width: cardWidth / 3,
                          ),
                        ),
                        Container(
                          width: cardWidth / 3.55,
                          child: SizedBox(
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_up),
                                color: Colors.greenAccent,
                                onPressed: () => vote(1),
                              ),
                            ),
                            width: cardWidth / 3,
                          ),
                        ),
                        Container(
                          width: cardWidth / 3.55,
                          child: SizedBox(
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_down),
                                color: Colors.redAccent,
                                onPressed: () => vote(-1),
                              ),
                            ),
                            width: cardWidth / 3,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          )),
    );
  }

  void playEpisode(String a) {
    print("SENDING PLAY CODE FOR " + a);
    var tvID = HomeState.currentTVID;
    YoutubeConnection.get(
        "http://replace.live:3000/control/play_video?tvID=$tvID&channelID=$a",
        (response) {});
  }

  void vote(int i) {
    setState(() {
      voted = true;
    });
  }


}
