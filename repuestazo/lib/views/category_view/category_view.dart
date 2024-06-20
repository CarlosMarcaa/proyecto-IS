import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/models/category.dart';
import "package:repuestazo/views/home_page/home_page.dart";
import "package:repuestazo/models/item.dart";

class CategoryView extends StatefulWidget{
  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView>{

  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            height: 35,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search car parts, products and more',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                  fillColor: Color(0xFFF1F1F1),
                  filled: true,
                  focusColor: Color(0xFFF1F1F1),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => {
              Navigator.pop(context)
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Item(
                  name: "Motor de corolla 1.6",
                  brand: "Toyota",
                  Description: "toyota xd",
                  model: "Corolla",
                  partType: "Motor",
                  category: "Motor",
                  price: 1000,
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}