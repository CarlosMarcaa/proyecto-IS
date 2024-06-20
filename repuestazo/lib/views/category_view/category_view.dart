import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/category_view/body.dart';

class CategoryView extends StatefulWidget{
  final String category;

  const CategoryView({Key? key, required this.category}) : super(key: key);

  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView>{
  late String category;

  void initState(){
    super.initState();
    category = widget.category;
  }


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
        body: Body(category: category)
      ),
    );
  }
}