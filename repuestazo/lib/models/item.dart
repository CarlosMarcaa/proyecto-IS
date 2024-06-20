import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget{
  String name;
  String brand;
  String Description;
  String model;
  String partType;
  String category;
  int price;

  Item({
    required this.name,
    required this.brand,
    required this.Description,
    required this.model,
    required this.partType,
    required this.category,
    required this.price
  });

  ItemState createState() => ItemState();
}

class ItemState extends State<Item>{


  Widget build(BuildContext context){
    return Container(
      height: 150,
      width: 375,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), // Esquina superior izquierda circular
                  topRight: Radius.circular(0), // Esquina superior derecha no circular
                  bottomLeft: Radius.circular(10), // Esquina inferior izquierda no circular
                  bottomRight: Radius.circular(0), // Esquina inferior derecha circular
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text(widget.name + "\nPrecio: " + widget.price.toString() + "\$"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}