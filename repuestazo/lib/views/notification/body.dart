import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:repuestazo/views/home_page/home_page.dart";

class Body extends StatefulWidget{
  BodyState createState() => BodyState();
}

class BodyState extends State<Body>{


  Widget build(BuildContext context){
    return Column(
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
    );
  }
}