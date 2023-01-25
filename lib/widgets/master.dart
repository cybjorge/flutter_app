import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/local_db.dart';
import 'package:flutter_app/api/api_controller.dart';
import 'package:flutter_app/widgets/detail.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});


  @override
  _MasterPageState createState()=> _MasterPageState();
}
class _MasterPageState extends State<MasterScreen>{
  var loading = false;

  @override
  Widget build(BuildContext context) {
    _loadDataFromApi();
    return Scaffold(
        appBar: AppBar(
          title: Text('Actors'),
          centerTitle: true,
        ),
        body: loading ? const Center(
          child: CircularProgressIndicator(),
        ) : _actorListView(),
      );
  }

  _loadDataFromApi() async{
    setState(() {
      loading = true;
    });

    var api = ApiController();
    await api.createActors();

    setState(() {
      loading = false;
    });
  }

  _actorListView(){

    return FutureBuilder(
        future: LocalDB.db.getAllActors(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            log('nodata');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
                  return ListTile(
                  leading: Text("${index+1}",
                  style: const TextStyle(fontSize: 20),
                    ),
                      title: Text("${snapshot.data[index].name}"),
                      subtitle: Text("${snapshot.data[index].description}"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> const DetailScreen(),
                        settings: RouteSettings(
                          arguments: snapshot.data[index].name,
                        ),
                      ),
                    );
                  },
                );
            });
          }
        },
    );
  }

}