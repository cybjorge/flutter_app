import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/detail.dart';

import 'widgets/login.dart';
import 'widgets/master.dart';
//debug
import 'api/models/actor_model.dart';
import 'api/api_controller.dart';
import 'dart:developer';
import 'db/local_db.dart';

void main() {
  runApp(const MyApp());
  /*
  LocalDB.db.db_init();
  ApiController api = new ApiController();
  var lst= api.createActors();
  log(lst.toString());
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
      routes: {
          'master': (context)=> const MasterScreen(),
          'detail' : (context)=> const DetailScreen(),
      },
    );
  }

}

