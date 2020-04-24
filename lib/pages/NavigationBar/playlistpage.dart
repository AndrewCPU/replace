import 'package:flutter/material.dart';

class PlaylistPage extends StatefulWidget {
  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  //placeholder for playlists
  List<String> playlists = [
    'playlist1',
    'playlist2',
    'playlist3',
    'playlist4',
    'playlist5',
    'playlist6',
    'playlist7',
    'playlist8',
    'playlist9',
  ];

  @override
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
                    //add new playlists
                    addPlaylist();
                  },
                )
              ],
            ),
            playlistListSection(),
          ],
        ),
      ),
    );
  }

  Widget playlistListSection() {
    return Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              return playlistCard(index);
            }));
  }

  Widget playlistCard(index) {
    return Container(
        height: MediaQuery.of(context).size.height * .1,
        child: InkWell(
          onTap: () {
            //brings to new page to view playlist
            print('playlist test');
          },
          child: Card(
            child: Text("${playlists[index]}"),
          ),
        ));
  }

  void addPlaylist() {
    //TODO, maybe pop up a box to input a playlist name
    print('add playlist');
  }
}

class Playlist {
  //PLACEHOLDER,
  final String playlistname;
  final int id;
  final String channelURL;

  Playlist({this.playlistname, this.id, this.channelURL});
}
