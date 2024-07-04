import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceView extends StatefulWidget {
  final String brand;
  final String category;
  final String description;
  final String model;
  final String name;
  final int price;
  final String userId;

  ServiceView(
      {Key? key,
      required this.brand,
      required this.category,
      required this.description,
      required this.model,
      required this.name,
      required this.price,
      required this.userId})
      : super(key: key);

  ServiceViewState createState() => ServiceViewState();
}

class ServiceViewState extends State<ServiceView> {
  late String brand;
  late String category;
  late String description;
  late String model;
  late String name;
  late int price;
  late String userId;
  int quantity = 1;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    brand = widget.brand;
    category = widget.category;
    description = widget.description;
    model = widget.model;
    name = widget.name;
    price = widget.price;
    userId = widget.userId;
  }

  Future<bool> isCustomer() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['userType'] == 'Client';
    }
    return false;
  }

  Future<void> addToCart() async {
    User? user = auth.currentUser;
    if (user != null) {
      QuerySnapshot existingProduct = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .where('name', isEqualTo: name)
          .get();

      if (existingProduct.docs.isNotEmpty) {
        // Producto ya existe en el carrito, sumar la cantidad
        DocumentSnapshot productDoc = existingProduct.docs.first;
        int newQuantity = productDoc['quantity'] + quantity;
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(productDoc.id)
            .update({'quantity': newQuantity});
      } else {
        // Producto no existe en el carrito, añadir nuevo
        await FirebaseFirestore.instance.collection('cart').add({
          'userId': user.uid,
          'brand': brand,
          'category': category,
          'description': description,
          'model': model,
          'name': name,
          'price': price,
          'quantity': quantity,
        });
      }
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content:
              Text('¿Estás seguro que deseas añadir este producto al carrito?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Añadir'),
              onPressed: () async {
                await addToCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Producto añadido al carrito')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                title: Text('SERVICIO: $name'),
              ),
              ListTile(
                title: Text('Brand: $brand'),
              ),
              ListTile(
                title: Text('Description: $description'),
              ),
              ListTile(
                title: Text('Model: $model'),
              ),
              ListTile(
                title: Text('Price: $price'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              FutureBuilder(
                future: isCustomer(),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data!) {
                    return Center(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Añadir al carrito'),
                        onPressed: _showConfirmationDialog,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
