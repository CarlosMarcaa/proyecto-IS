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
                Category(nameCategory: "Motores y Componentes"),
                Category(nameCategory: "Transmision y Embrague"),
                Category(nameCategory: "Sistema de Frenos"),
                Category(nameCategory: "Suspension y Direccion"),
                Category(nameCategory: "Sistema de Escape"),
                Category(nameCategory: "Sistema Electrico"),
                Category(nameCategory: "Carroceria "),
                Category(nameCategory: "Sistema de Climatización "),
                Category(nameCategory: "Interior del Vehículo "),
                Category(nameCategory: "Accesorios y Otros "),
              ],
            ),
          )
        ],
      ),
    );
  }
}