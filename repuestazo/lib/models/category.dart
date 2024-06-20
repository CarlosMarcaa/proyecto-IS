import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/category_view/category_view.dart';

//Clase para crear Categorias en la pagina principal (Stateful)
class Category extends StatefulWidget{
  final String nameCategory;

  const Category({Key? key, required this.nameCategory}) : super(key: key);

  CategoryState createState() => CategoryState();
}

//Clase para el manejo del estado de Category
class CategoryState extends State<Category>{
  late String nameCategory;

  void initState(){
    super.initState();
    nameCategory = widget.nameCategory;
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryView())
        );
      },
      child: Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        child: Text(nameCategory, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );

  }
}