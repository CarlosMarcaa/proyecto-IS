import 'package:flutter/material.dart';
import 'body.dart'; // Importar el archivo body.dart

class DeleteProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Producto'),
      ),
      body: DeleteProductForm(),
    );
  }
}
