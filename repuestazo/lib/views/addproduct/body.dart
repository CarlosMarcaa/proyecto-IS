import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductForm extends StatefulWidget {
  @override
  AddProductFormState createState() => AddProductFormState();
}

class AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? _brand;
  String? _model;
  String? _partType;
  String? _description;
  double? _price;

  final List<String> _classifications = [
    'Motor',
    'Transmisión',
    'Suspensión',
    'Frenos',
    'Eléctrico',
    'Interior',
    'Exterior',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Marca del carro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la marca del carro';
                  }
                  return null;
                },
                onSaved: (value) {
                  _brand = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo del carro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el modelo del carro';
                  }
                  return null;
                },
                onSaved: (value) {
                  _model = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de pieza'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el tipo de pieza';
                  }
                  return null;
                },
                onSaved: (value) {
                  _partType = value;
                },
              ),
              DropdownButtonFormField<String>(
                decoration:
                    InputDecoration(labelText: 'Clasificación del Repuesto'),
                items: _classifications.map((String classification) {
                  return DropdownMenuItem<String>(
                    value: classification,
                    child: Text(classification),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona una clasificación';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _partType = newValue!;
                  });
                },
                onSaved: (value) {
                  _partType = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = value != null ? double.tryParse(value) : null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      await FirebaseFirestore.instance.collection('products').add({
        'brand': _brand,
        'model': _model,
        'partType': _partType,
        'description': _description,
        'price': _price,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado exitosamente')),
      );

      _formKey.currentState?.reset();
    }
  }
}
