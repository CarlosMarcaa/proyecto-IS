import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/category_view/body.dart';

class Body extends StatefulWidget {
  final String brand;
  final String category;
  final String description;
  final String model;
  final String name;
  final int price;
  final String userId;

  Body(
      {Key? key,
      required this.brand,
      required this.category,
      required this.description,
      required this.model,
      required this.name,
      required this.price,
      required this.userId})
      : super(key: key);

  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  late String brand;
  late String category;
  late String description;
  late String model;
  late String name;
  late int price;
  late String userId;

  void initState() {
    brand = widget.brand;
    category = widget.category;
    description = widget.description;
    model = widget.model;
    name = widget.name;
    price = widget.price;
    userId = widget.userId;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: ListView(
        children: [
          ListTile(
            title: Text('Name: $name'),
          ),
          ListTile(
            title: Text('Brand: $brand'),
          ),
          ListTile(
            title: Text('Description: $description'),
          ),
          ListTile(
            title: Text('Model: $model'),
          ),
          ListTile(
            title: Text('Price: $price'),
          ),
          Center(
            child: TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black),
              icon: Icon(Icons.add),
              label: Text('Añadir al carrito'),
              onPressed: () {},
            ),
          ),
        ],
      )),
    );
  }
}
