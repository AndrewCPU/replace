import 'package:Replace/pages/NavigationBar/playlist.dart';
import 'package:flutter/material.dart';

/*
Name of file: playlistpage.dart
Purpose: The purpose of the file is to display the page where users
will be able to view their playlists, create playlists, add to their playlists, delete playlists
and also play videos from here.
Version and date: Version 2, last modified on 6/5/2020
Author: Larry Long and Andrew Stein
Dependencies: playlist.dart file, material flutter package
 */

//stateful widget for playlist page UI
class PlaylistPage extends StatefulWidget {
  @override
  PlaylistPageState createState() => PlaylistPageState();
}

class PlaylistPageState extends State<PlaylistPage>
    with TickerProviderStateMixin {
  List<Playlist> playlists = [];
  TextEditingController _textEditingController = TextEditingController();
  PlaylistHelper _playlistHelper = PlaylistHelper();

  @override
  void initState() {
    //loads the playlists as the initial state of the page
    loadPlaylist();
    super.initState();
  }

  @override
  //build function for widgets and displaying UI
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .05,
          bottom: MediaQuery.of(context).size.height * .05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Playlists',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * .05),
                    ),
                    InkWell(
                      child: Container(
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                      onTap: () {
                        _playlistHelper
                            .createPlaylistBox(context)
                            .whenComplete(() {
                          loadPlaylist();
                        });
                      },
                    ),
                  ],
                ),
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.refresh,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      loadPlaylist();
                    });
                  },
                ),
              ],
            ),
            playlistList(),
          ],
        ),
      ),
    );
  }

  //ui for list of playlists
  Widget playlistList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return playlistChannels(index);
        });
  }

  //ui for lists of playlist channels
  Widget playlistChannels(index) {
    String thisPlaylistName = playlists[index].playlistName;
    List<String> channelList = playlists[index].playlistChannels;
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(thisPlaylistName,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .04)),
              InkWell(
                child: Container(
                  child: Icon(
                    Icons.delete,
                  ),
                ),
                onTap: () {
                  //TODO add alert asking for confirmation
                  _playlistHelper
                      .removePlaylist(thisPlaylistName)
                      .whenComplete(() {
                    loadPlaylist();
                  });
                },
              )
            ],
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: channelList.length,
              itemBuilder: (context, index) {
                //TODO maybe message if no playlists or streams in a playlist
                return playlistCard(
                    context, index, thisPlaylistName, channelList);
              },
              scrollDirection: Axis.horizontal,
            ),
            height: MediaQuery.of(context).size.height * 0.45,
          ),
        ],
      ),
    );
  }

  //ui for clickable playlist cards to play videos
  Widget playlistCard(context, index, thisPlaylistName, channelList) {
    String videoURL = channelList[index];
    AnimationController _controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
        reverseDuration: const Duration(milliseconds: 300));
    _controller.reset();
    return Container(
        margin: EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * .75,
        child: GestureDetector(
          onTap: () {
            _controller.forward().then((onValue) {
              _controller.reverse();
            });
            _playlistHelper.playPlaylistVideo(videoURL);
          },
          child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(
                parent: _controller, curve: Curves.easeOutQuart)),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        "https://img.youtube.com/vi/$videoURL/hqdefault.jpg",
                        scale: 0.2,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Row(
                    //TODO add upvote/downvote/removefromplaylist
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text('10'
                            //votes.toString()
                            ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          color: Colors.greenAccent,
                          onPressed: () {
                            //vote(1)
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          color: Colors.redAccent,
                          onPressed: () {
                            //vote(-1)
                          },
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Icon(
                            Icons.delete,
                          ),
                          onTap: () {
                            //TODO alert for confirmation
                            _playlistHelper
                                .removeFromPlaylist(
                                    videoURL, thisPlaylistName, channelList)
                                .whenComplete(() {
                              loadPlaylist();
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  //no parameters or return value
  //calls the getPlaylists function from the playlistHelper class and
  //stores the list of playlists in a list
  //calls the setstate to set the variable playlists at the top which the UI is
  //dependent on. Setstate calls the buildFunction of the stateful widget to rebuild
  //and show the current state of the playlists and its videos
  //this function is called after each function to modify the playlists in any way
  //in order to show the new UI to the user
  void loadPlaylist() async {
    List list = await _playlistHelper.getPlaylists();
    setState(() {
      playlists = list;
    });
  }
}
