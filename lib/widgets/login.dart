import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:math';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var color = false;
  var loading = false;
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // credentials storage
  final _storage = const FlutterSecureStorage();

  final TextEditingController usernameController = TextEditingController(text: "");
  final TextEditingController passwordController = TextEditingController(text: "");


  //save credentials after login
   _onFormSubmit() async{
    if(_formKey.currentState?.validate() ?? false){
      setState(() {
        loading = true;
      });
      await _storage.write(key: "USERNAME", value: usernameController.text);
      await _storage.write(key: "PASSWORD", value: passwordController.text);

      //TODO make the button unklickable after click
      await Future.delayed(Duration(seconds: 2));

      _onValidated();
    }
}

  _onValidated(){
    setState(() {
      loading = false;
    });
    Navigator.pushNamed(context, 'master');
  }
  _onTest(){
    Navigator.pushNamed(context, 'detail');
  }

  //read from storage to check if fields can be autofilled, otherwise ''
  Future<void> _fromStorage() async{
    usernameController.text = await _storage.read(key: "USERNAME") ?? '';
    passwordController.text = await _storage.read(key: "PASSWORD") ?? '';
  }

  @override
  void initState(){
    super.initState();
    _fromStorage();
}

  Color _randomColor(){
     setState(() {
       color = false;
     });
     return Color(Random().nextInt(0xffffffff));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: !color ? const Color(0xFFFFFFFF) : _randomColor(),
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Login"),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.color_lens),
                onPressed:(){
                  setState(() {
                    color = true;
                  });
                },
              ),
            )
          ],
      ),
      body: !loading ?
      SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "username",
                  ),
                  controller: usernameController,
                  validator: (value){
                    if( value!.isEmpty){
                      return "Requiered";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "password",
                  ),
                  controller: passwordController,
                  obscureText: true,
                  validator: (value){
                    if( value!.isEmpty){
                      return "Requiered";
                    }
                    return null;
                  },
                ),
                ElevatedButton(onPressed: _onFormSubmit, child: const Text("Log In"))
              ]
            ),
          ),
        )
      ) : const Center(
        child: CircularProgressIndicator(),
      ),


    );
  }}
