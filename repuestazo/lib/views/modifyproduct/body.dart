import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModifyProductForm extends StatefulWidget {
  @override
  _ModifyProductFormState createState() => _ModifyProductFormState();
}

class _ModifyProductFormState extends State<ModifyProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _categories = [
    'Motor',
    'Transmisión',
    'Suspensión',
    'Frenos',
    'Eléctrico',
    'Interior',
    'Exterior'
  ];

  Future<void> _modifyProduct() async {
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
                .update({
              'name': _nameController.text,
              'price': double.parse(_priceController.text),
              'description': _descriptionController.text,
              'brand': _brandController.text,
              'model': _modelController.text,
              'category': _selectedCategory,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Producto modificado exitosamente')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('No tienes permiso para modificar este producto')),
            );
          }
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al modificar producto: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _productIdController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    super.dispose();
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
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese un precio';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Marca del Carro'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese la marca del carro';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Modelo del Carro'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese el modelo del carro';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Clasificación'),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor seleccione una clasificación';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _modifyProduct,
                    child: Text('Modificar Producto'),
                  ),
          ],
        ),
      ),
    );
  }
}
