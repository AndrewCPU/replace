import 'package:Replace/pages/NavigationBar/playlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                return playlistCard(index);
              },
              scrollDirection: Axis.horizontal,
            ),
            height: MediaQuery.of(context).size.height * 0.35,
          ),
        ],
      ),
    );
  }

  Widget playlistCard(index) {
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png",
                      //"https://img.youtube.com/vi/$videoURL/hqdefault.jpg",
                      scale: 0.2,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void addPlaylist() {
    //TODO, maybe pop up a box to input a playlist name
    print('add playlist');
  }

  void loadPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList("playlists");
    for (String playlistName in playlistNames) {
      List<String> playlistContent =
          prefs.getStringList("playlist.$playlistName");
      Playlist playlist = Playlist(
          playlistName: playlistName, playlistChannels: playlistContent);
    }
  }
}
