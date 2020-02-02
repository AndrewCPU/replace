import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Authentication {
  String authenticationUrl = "http://replace.live:3000/authentication/";
  void registerUser(username, password){
    password = generateMd5(username + password);
    get(authenticationUrl + "register?username=" + username + "&password=" + password, (content){

    });
  }

  void loginUser(username, password){
    password = generateMd5(username + password);
    get(authenticationUrl + "login?username=" + username + "&password=" + password, (content){
      //content is session token to be stored
    });
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }


  void get(url, callback) async{
    final response = await http.get(url);
    callback(response);
  }
}