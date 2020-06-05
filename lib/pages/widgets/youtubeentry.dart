import 'dart:async';
import 'dart:math';
import 'package:Replace/network/YoutubeConnection.dart';
import 'package:Replace/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeEntry extends StatefulWidget with Comparable {
  String videoTitle;
  String videoURL;
  int votes = 0;

  YoutubeEntry({this.videoTitle, this.videoURL}) {
    //todo get votes
    this.votes = new Random().nextInt(1000);
  }

  @override
  State createState() => _YouTubeEntryState(
      videoTitle: videoTitle, videoURL: videoURL, votes: votes);

  @override
  int compareTo(dynamic other) {
    if (other is YoutubeEntry) {
      if (other.votes > this.votes) {
        return 1;
      } else {
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
  String selectedPlaylist;

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
    Widget img = Image.network(
      "https://img.youtube.com/vi/$videoURL/hqdefault.jpg",
      scale: 0.2,
      fit: BoxFit.fill,
    );
    img = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: img,
    );
    Widget x = GestureDetector(
        onTap: () {
          _controller.forward().then((onValue) {
            _controller.reverse();
          });
          playEpisode(videoURL);
        },
        child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(
                parent: _controller, curve: Curves.easeOutQuart)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    Expanded(flex: 3, child: img),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(votes.toString()),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_up),
                                color: Colors.greenAccent,
                                onPressed: () => vote(1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_down),
                                color: Colors.redAccent,
                                onPressed: () => vote(-1),
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                playlistSelect(videoURL);
                              },
                              child: Icon(Icons.add_to_photos),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*Expanded(
                      //flex: 1,
                      child: Center(
                        child: FlatButton.icon(
                          onPressed: () {
                            playlistSelect(videoURL);
                          },
                          icon: Icon(Icons.add_to_photos),
                          label: Text('Add To Playlist'),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            )));

    return x;
  }

  Future playlistSelect(videoURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList("playlists");
    if (playlistNames == null) {
      playlistNames = ['defaultplaylist'];
    }
    return showDialog(
        context: context,
        builder: (context) {
          if (playlistNames.length == 0) {
            return CupertinoAlertDialog(
              title: Text('No Playlists Found'),
            );
          } else {
            return CupertinoAlertDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Choose playlist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(color: Colors.black)
                  ],
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * .3,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Scrollbar(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: playlistNames.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(playlistNames[index]),
                              onTap: () {
                                if (playlistNames[index] != null) {
                                  addToPlaylist(playlistNames[index], videoURL)
                                      .whenComplete(() {
                                    setState(() {
                                      //TODO update playlist view
                                    });
                                  });
                                } else {
                                  print('select a playlist');
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title:
                                              Text('Please select a playlist'),
                                        );
                                      });
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ),
            );
          }
        });
  }

  Future addToPlaylist(playlistName, videoURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedPlaylist = prefs.getStringList(playlistName);
    print(updatedPlaylist);
    if (updatedPlaylist == null) {
      updatedPlaylist = [videoURL];
    } else if (updatedPlaylist.contains(videoURL)) {
      print('already contains this stream');
      return showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                  'Playlist "$playlistName" already contains this stream (videoURL: $videoURL)'),
            );
          });
    } else {
      updatedPlaylist.add(videoURL);
    }
    prefs.setStringList(playlistName, updatedPlaylist);
    print('playlistName: $playlistName');
    print('updated playlist: $updatedPlaylist');
    Navigator.of(context).pop();
    setState(() {});
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
