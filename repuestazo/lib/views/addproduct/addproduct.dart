import 'package:flutter/material.dart';
import 'body.dart'; // Asegúrate de tener esta importación

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: AddProductForm(),
    );
  }
}
