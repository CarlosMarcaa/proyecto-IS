import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/product_view/body.dart';
import 'package:repuestazo/models/item.dart';

class ProductView extends StatefulWidget{
  final String brand;
  final String category;
  final String description;
  final String model;
  final String name;
  final int price;
  final String userId;

  ProductView({Key? key,
    required this.brand,
    required this.category,
    required this.description,
    required this.model,
    required this.name,
    required this.price,
    required this.userId
  }) : super(key: key);

  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends State<ProductView>{
  late String brand;
  late String category;
  late String description;
  late String model;
  late String name;
  late int price;
  late String userId;

  void initState(){
    brand = widget.brand;
    category = widget.category;
    description = widget.description;
    model = widget.model;
    name = widget.name;
    price = widget.price;
    userId = widget.userId;
  }

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => {
              Navigator.pop(context)
            },
          ),
        ),
        body: Body(
          brand: brand,
          category: category,
          description: description,
          model: model,
          name: name,
          price: price,
          userId: userId,
        )
      ),
    );
  }
}