import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/local_db.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail of $name"),
        centerTitle: true,
      ),
      body: Center(
        child: _actorDetail(name),
      ),
    );
  }
  
  _actorDetail(String name){
    return FutureBuilder(
        future: LocalDB.db.getActor(name),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (!snapshot.hasData) {
            log('nodata');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
                separatorBuilder: (context, index) =>
                const Divider(
                  color: Colors.black12,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text("${index + 1}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    title: Text("${snapshot.data[index].name}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const DetailScreen(),
                        settings: RouteSettings(
                          arguments: snapshot.data[index].name,
                        ),
                      ),
                      );
                    },
                  );
                });
          }
        });
    }
}