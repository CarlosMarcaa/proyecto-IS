import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:repuestazo/views/profile/body.dart ";

class ProfilePage extends StatefulWidget{
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{


  Widget build(BuildContext context){
    return Scaffold(
      body: Body(),
    );
  }
}