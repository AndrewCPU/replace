import 'package:http/http.dart' as http;

class YoutubeConnection{
  static void get(url, callback) async{
    final response = await http.get(url);
    callback(response);
  }

  getChannels(mode, callback){
    var channels = <String>[];
      get("https://www.youtube.com/results?search_query=24+7+live+stream+" + mode + "&sp=EgJAAQ%253D%253D", (response){
        RegExp regExp = new RegExp("\\?v=[a-zA-Z0-9\\-_]+",
          caseSensitive: true,
          multiLine: false,
        );
        var a = regExp.allMatches(response.body);
        for(var b in a) {
          if (!channels.contains(b.group(0))) {
//            callback(b.group(0).replaceAll("?v=", ""));
            channels.add(b.group(0));
          }
        }
        callback(channels);
      });
  }
}