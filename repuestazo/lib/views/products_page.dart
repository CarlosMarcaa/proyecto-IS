import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/models/category.dart';
import 'package:repuestazo/searcher.dart';

class ProductsPage extends StatefulWidget {
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: Searcher());
        },
        child: Icon(Icons.search),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Center(
            //   child: Container(
            //     width: screenWidth * 0.8,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey),
            //         borderRadius: BorderRadius.circular(30)),
            //     child: const TextField(
            //       decoration: InputDecoration(
            //           border: InputBorder.none,
            //           labelText: "   Buscar repuestos, productos y mas...",
            //           labelStyle: TextStyle(fontSize: 12)),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}