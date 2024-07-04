import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/searcher/searcher.dart';
import 'package:repuestazo/views/products/body.dart';

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
        body: Body());
  }
}
