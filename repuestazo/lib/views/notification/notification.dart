import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:repuestazo/views/notification/body.dart";

class NotificationPage extends StatefulWidget{
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>{


  Widget build(BuildContext context){
    return Scaffold(
        body: Body()
      );
  }
}