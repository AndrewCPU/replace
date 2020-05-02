import 'package:Replace/pages/NavigationBar/playlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistPage extends StatefulWidget {
  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Playlist> playlists = [];
  TextEditingController _textEditingController = TextEditingController();
  PlaylistHelper _playlistHelper = PlaylistHelper();

  @override
  void initState() {
    loadPlaylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .05,
          bottom: MediaQuery.of(context).size.height * .05,
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  InkWell(
                    child: Container(
                      child: Icon(
                        Icons.remove_red_eye,
                      ),
                    ),
                    onTap: () {
                      print(playlists);
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
      ),
    );
  }

  Widget playlistList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return playlistChannels(index);
        });
  }

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
              //TODO REMOVE this test button
              InkWell(
                child: Container(
                  child: Icon(
                    Icons.remove_red_eye,
                  ),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String> channels = prefs.getStringList(thisPlaylistName);
                  print(channels);
                },
              ),
              InkWell(
                child: Container(
                  child: Icon(
                    Icons.close,
                  ),
                ),
                onTap: () {
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
                if (channelList.length != 0) {
                  return playlistCard(
                      context, index, thisPlaylistName, channelList);
                } else {
                  return Container(
                    child: Text('No streams in playlist.'),
                  );
                }
              },
              scrollDirection: Axis.horizontal,
            ),
            height: MediaQuery.of(context).size.height * 0.45,
          ),
        ],
      ),
    );
  }

  Widget playlistCard(context, index, thisPlaylistName, channelList) {
    String videoURL = channelList[index];
    //TODO fix card format
    return Container(
        margin: EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * .75,
        //TODO add bounce effect
        child: GestureDetector(
          onTap: () {
            _playlistHelper.playPlaylistVideo(videoURL);
          },
          child: Card(
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
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                      onTap: () {
                        _playlistHelper
                            .removeFromPlaylist(
                                videoURL, thisPlaylistName, channelList)
                            .whenComplete(() {
                          loadPlaylist();
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void loadPlaylist() async {
    List list = await _playlistHelper.getPlaylists();
    setState(() {
      playlists = list;
    });
  }
}
