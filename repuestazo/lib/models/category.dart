import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/category_view/category_view.dart';

class Category extends StatefulWidget {
  final String nameCategory;
  final String category;

  const Category({Key? key, required this.nameCategory, required this.category})
      : super(key: key);

  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  late String nameCategory;
  late String category;

  @override
  void initState() {
    super.initState();
    nameCategory = widget.nameCategory;
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryView(category: category),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          child: Text(
            nameCategory,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[800], // Color gris oscuro
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2), // Bordes negros
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
