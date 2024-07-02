import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPostsPage extends StatelessWidget {
  final String userId;

  MyPostsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Publicaciones'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay publicaciones.'));
          }

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(product['name']),
                  subtitle: Text(product['description']),
                  trailing: Text('\$${product['price']}'),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => EditProductSheet(
                        productId: products[index].id,
                        initialData: product,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EditProductSheet extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> initialData;

  EditProductSheet({required this.productId, required this.initialData});

  @override
  _EditProductSheetState createState() => _EditProductSheetState();
}

class _EditProductSheetState extends State<EditProductSheet> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData['name']);
    descriptionController =
        TextEditingController(text: widget.initialData['description']);
    priceController =
        TextEditingController(text: widget.initialData['price'].toString());
  }

  Future<void> saveChanges() async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .update({
      'name': nameController.text,
      'description': descriptionController.text,
      'price': int.parse(priceController.text),
    });
    Navigator.pop(context);
  }

  Future<void> deleteProduct() async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Descripción'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Precio'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: deleteProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Eliminar'),
              ),
              ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
