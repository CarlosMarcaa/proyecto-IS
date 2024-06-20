import 'package:flutter/material.dart';
import 'body.dart'; // Importar el archivo body.dart

class ModifyProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Producto'),
      ),
      body: ModifyProductForm(),
    );
  }
}
