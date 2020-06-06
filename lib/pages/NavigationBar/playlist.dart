import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/YoutubeConnection.dart';
import '../home.dart';

/*
Name of file: playlist.dart
Purpose: This file creates a class for the playlist object to describe
the playlist name, and the list of String ids used in each URL of the youtube channels.
This file also contains the playlistHelper class which manages different functions
for the playlist class, such as retrieving the list of stored playlists, creating playlists,
removing playlists, and removing channels from playlists. playlists are stored
in shared preferences local storage
Version and date: Version 2, last modified on 6/5/2020
Author: Larry Long and Andrew Stein
Dependencies: cupertino, material, shared preferences flutter packages
YoutubeConnection.dart and home.dart
 */

//playlist class
class Playlist {
  final String playlistName;
  final List<String> playlistChannels;

  Playlist({this.playlistName, this.playlistChannels});
}

//playlist helper class, manages functions for playlist objects
class PlaylistHelper {
  //controller to retrieve user input for playlist name
  TextEditingController _textEditingController = TextEditingController();
  //requires build context to create the pop up box and to also close it with navigator.pop
  //returns the cupertinoalertdialog widget
  //creates a dialog box which takes in a name for a playlist
  //when submitted, calls the createPlaylist() function
  Future createPlaylistBox(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Create Playlist'),
            content: Container(
              width: 500,
              height: 100,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(hintText: "Playlist Name"),
                ),
              ),
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

  //requires build context in order to clear form field once successfully submitted
  //no return data besides in case of error
  //creates the playlist with the string provided by the user. stores the string name
  //into the dedicated list in shared preferences that holds all the playlist names
  Future createPlaylist(context) async {
    //only creates a playlist if the field is not empty and isn't the same name
    //as the qrcode
    if (_textEditingController.text.isNotEmpty &&
        //TVID is stored there
        _textEditingController.text != 'qrcode') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> updatedPlaylist = prefs.getStringList("playlists");
      if (updatedPlaylist == null) {
        updatedPlaylist = [];
      } else {
        if (!updatedPlaylist.contains(_textEditingController.text)) {
          //adds the playlist name to shared preferences and pops the dialog box once done
          updatedPlaylist.add(_textEditingController.text);
          prefs.setStringList('playlists', updatedPlaylist);
          print('updated playlist list:$updatedPlaylist');
          Navigator.of(context).pop();
          _textEditingController.clear();
        } else {
          print('${_textEditingController.text} already exists');
        }
      }
    } else {
      print('empty');
      return null;
    }
  }

  //requires the name of the playlist name the user wants to delete
  //returns no data
  //removes a playlist. It removes a playlist name from the list of playlist names
  //in shared preferences. It also gets the list of string ids whose key is the playlist name
  //and empties the list to completely delete the playlist.
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

  //requires videoURL, playlist name, and current list of channel urls
  //no return value
  //this function takes in the current list of channels, removes a specified video URL
  //for presentation. It also removes it from the local storage by setting
  //the new updated list in the shared preferences local storage
  Future removeFromPlaylist(videoURL, thisPlaylistName, channelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedList = channelList;
    updatedList.remove(videoURL);
    prefs.setStringList(thisPlaylistName, updatedList);
  }

  //no parameters
  //returns a List of Playlist objects
  //it gets the list of playlists names from shared preferences
  //for each playlist name, it retrieves the list of string video URLs in shared preferences as well
  //and then adds it to a list of playlist objects, finally returning them
  Future<List<Playlist>> getPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList("playlists");
    List<Playlist> playlists = [];
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

  //takes in video URL
  // no return value
  //plays the requested video by taking in the video url and calling the function in the
  //Youtube connect to play the video through the replace.live website
  void playPlaylistVideo(String a) {
    print("SENDING PLAY CODE FOR " + a);
    var tvID = HomeState.currentTVID;
    YoutubeConnection.get(
        "http://replace.live:3000/control/play_video?tvID=$tvID&channelID=$a",
        (response) {});
  }
}
