
import 'models/actor_model.dart';
import 'package:flutter_app/db/local_db.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:developer';

class ApiController{
  Future<List> createActors() async {
    //'--disable-web-security' had to be added for web test
    final response = await post(
      Uri.parse('https://www.infotech.sk/Service/Service.svc/getData'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'APIKey': '1ff7e612-52ec-4bf0-899a-3bb29b07a43c',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log('message');
      var api_response = json.decode(response.body);

      //return (api_response['actors'] as List).map((e)  => LocalDB.db.createActor(Actor.fromJson(e))).toList();
      return (api_response['actors'] as List).map((e){
        LocalDB.db.createActor(Actor.fromJson(e));
      }).toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create actors.');
    }
}

}