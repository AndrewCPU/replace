import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class PlaylistPage extends StatefulWidget {
  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<String> playlists = [
    'playlist1',
    'playlist2',
    'playlist3',
    'playlist4',
  ];

  @override
  Widget build(BuildContext context) {
    Widget img = Image.network(
      "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png",
      //"https://img.youtube.com/vi/$videoURL/hqdefault.jpg",
      scale: 0.2,
      fit: BoxFit.fill,
    );
    img = ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: img,
    );
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
                      //add new playlists
                      addPlaylist();
                    },
                  )
                ],
              ),
              playlistList(img),
            ],
          ),
        ),
      ),
    );
  }

  Widget playlistList(img) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return playlistChannels(index, img);
        });
  }

  Widget playlistChannels(index, img) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(playlists[index],
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .04)),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return playlistCard(index, img);
              },
              scrollDirection: Axis.horizontal,
            ),
            height: MediaQuery.of(context).size.height * 0.35,
          ),
        ],
      ),
    );
  }

  Widget playlistCard(index, img) {
    return Container(
        width: MediaQuery.of(context).size.width * .8,
        child: InkWell(
          onTap: () {
            //brings to new page to view playlist
            print('playlist test');
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Text("video"),
                Container(
                  height: MediaQuery.of(context).size.height * .1,
                  child: img,
                )
              ],
            ),
          ),
        ));
  }

  void addPlaylist() {
    //TODO, maybe pop up a box to input a playlist name
    print('add playlist');
  }
}

class Playlist {
  final String playlistName;
  final List<String> playlistChannels;

  Playlist({this.playlistName, this.playlistChannels});

  Map<String, dynamic> toMap() {
    return {
      "playlistName": this.playlistName,
      "playlistChannels": this.playlistChannels,
    };
  }
}
