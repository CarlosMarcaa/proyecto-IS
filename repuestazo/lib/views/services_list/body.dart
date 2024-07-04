import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/models/item_service.dart';

class Body extends StatefulWidget {
  final String category;

  Body({Key? key, required this.category}) : super(key: key);

  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  late String category;

  void initState() {
    category = widget.category;
  }

  Future<List<Item>> fetchDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: category)
        .get();
    List<Item> products = [];
    querySnapshot.docs.forEach((doc) {
      print(doc["category"]);
      products.add(Item(
        brand: doc["brand"],
        category: doc["category"],
        description: doc["description"],
        model: doc["model"],
        name: doc["name"],
        price: doc["price"],
        userId: doc["userId"],
      ));
    });
    return products;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchDocuments(),
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Animación de carga
        } else if (snapshot.hasError) {
          return Text('Error al obtener datos de Firestore: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Item item = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.all(
                    16.0), // Define el relleno en todos los lados
                child: item, // Widget al que se le aplica el relleno
              );
            },
          );
        }
      },
    );
  }
}
