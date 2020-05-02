import 'package:Replace/network/YoutubeConnection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class Playlist {
  final String playlistName;
  final List<String> playlistChannels;

  Playlist({this.playlistName, this.playlistChannels});
}

class PlaylistHelper {
  TextEditingController _textEditingController = TextEditingController();
  Future createPlaylistBox(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create Playlist'),
            content: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "Playlist Name"),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    createPlaylist(context);
                  },
                  child: Text('Add')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }

  Future createPlaylist(context) async {
    if (_textEditingController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> updatedPlaylist = prefs.getStringList("playlists");
      if (updatedPlaylist == null) {
        updatedPlaylist = [];
      } else {
        if (!updatedPlaylist.contains(_textEditingController.text)) {
          updatedPlaylist.add(_textEditingController.text);
          prefs.setStringList('playlists', updatedPlaylist);
          print('updated playlist list:$updatedPlaylist');
          Navigator.of(context).pop();
          _textEditingController.clear();
        } else {
          //TODO add error if playlists already exists
          print('${_textEditingController.text} already exists');
        }
      }
    } else {
      //TODO add error if empty
      print('empty');
      return null;
    }
  }

  Future removePlaylist(playlistName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedPlaylistList = prefs.getStringList('playlists');
    List<String> clearedPlaylist = prefs.getStringList(playlistName);
    clearedPlaylist = [];
    updatedPlaylistList.remove(playlistName);
    prefs.setStringList('playlists', updatedPlaylistList);
    prefs.setStringList(playlistName, clearedPlaylist);

    print('removed $playlistName');
    print('updated playlist list:$updatedPlaylistList');
  }

  Future removeFromPlaylist(videoURL, thisPlaylistName, channelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedList = channelList;
    updatedList.remove(videoURL);
    print(updatedList);
    print(thisPlaylistName);
    prefs.setStringList(thisPlaylistName, updatedList);
  }

  Future<List<Playlist>> getPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList("playlists");
    List<Playlist> playlists = [];
    print(playlistNames);
    if (playlistNames == null) {
      playlistNames = [];
      prefs.setStringList('playlists', playlistNames);
    }
    for (int i = 0; i < playlistNames.length; i++) {
      List<String> playlistContent = prefs.getStringList(playlistNames[i]);
      if (playlistContent == null) {
        playlistContent = [];
      }
      Playlist playlist = Playlist(
          playlistName: playlistNames[i], playlistChannels: playlistContent);
      playlists.add(playlist);
    }
    return playlists;
  }

  void playPlaylistVideo(String a) {
    print("SENDING PLAY CODE FOR " + a);
    var tvID = HomeState.currentTVID;
    YoutubeConnection.get(
        "http://replace.live:3000/control/play_video?tvID=$tvID&channelID=$a",
        (response) {});
  }
}
