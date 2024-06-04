import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/home_page.dart';

class NotificationPage extends StatefulWidget{
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>{


  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          children: [
            Text("Notificaciones"),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text("Volver al homePage"),
            )
          ],
        ),
      );
  }
}