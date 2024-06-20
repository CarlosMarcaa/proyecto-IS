import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteProductForm extends StatefulWidget {
  @override
  _DeleteProductFormState createState() => _DeleteProductFormState();
}

class _DeleteProductFormState extends State<DeleteProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  bool _isLoading = false;

  Future<void> _deleteProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection('products')
              .doc(_productIdController.text)
              .get();

          if (doc.exists && doc['userId'] == user.uid) {
            await FirebaseFirestore.instance
                .collection('products')
                .doc(_productIdController.text)
                .delete();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Producto eliminado exitosamente')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('No tienes permiso para eliminar este producto')),
            );
          }
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar producto: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _productIdController,
              decoration: InputDecoration(labelText: 'ID del Producto'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese el ID del producto';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _deleteProduct,
                    child: Text('Eliminar Producto'),
                  ),
          ],
        ),
      ),
    );
  }
}
