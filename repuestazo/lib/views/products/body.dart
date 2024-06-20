import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:repuestazo/models/category.dart";

class Body extends StatefulWidget{
  BodyState createState() => BodyState();
}

class BodyState extends State<Body>{

  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          const Center(
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                Category(nameCategory: "Motores y Componentes", category: "Motor"),
                Category(nameCategory: "Transmision y Embrague", category: "Transmision",),
                Category(nameCategory: "Suspension y Direccion", category: "Suspension"),
                Category(nameCategory: "Sistema de Frenos", category: "Frenos"),
                Category(nameCategory: "Sistema Electrico", category: "Electrico"),
                Category(nameCategory: "Interior ", category: "Interior"),
                Category(nameCategory: "Exterior ", category: "Exterior"),
              ],
            ),
          )
        ],
      ),
    );
  }
}