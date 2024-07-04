import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repuestazo/views/product_view/product_view.dart'; // Importa la vista del producto

class CartView extends StatefulWidget {
  CartViewState createState() => CartViewState();
}

class CartViewState extends State<CartView> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    User? user = auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .get();
      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    }
    return [];
  }

  Future<void> removeFromCart(String docId, int quantityToRemove) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('cart').doc(docId).get();
    int currentQuantity = doc['quantity'];

    if (currentQuantity <= quantityToRemove) {
      await FirebaseFirestore.instance.collection('cart').doc(docId).delete();
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(docId).update({
        'quantity': currentQuantity - quantityToRemove,
      });
    }

    setState(() {}); // Refresh the cart view immediately
  }

  void _showDeleteConfirmationDialog(String docId, int currentQuantity) {
    int quantityToRemove = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Confirmación'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('¿Cuántos deseas eliminar del carrito?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantityToRemove > 1) quantityToRemove--;
                          });
                        },
                      ),
                      Text('$quantityToRemove'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (quantityToRemove < currentQuantity)
                              quantityToRemove++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Eliminar'),
                  onPressed: () async {
                    await removeFromCart(docId, quantityToRemove);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Producto eliminado del carrito')),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void initiatePurchase() {
    // Implementar la lógica para iniciar la compra
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCartItems(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error al obtener datos de Firestore: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty) {
          return Center(child: Text('No hay productos en el carrito'));
        } else {
          // Calcular el costo total del carrito
          double totalCost = snapshot.data!.fold(0.0, (sum, item) {
            return sum + (item['price'] * item['quantity']);
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];
                    return ListTile(
                      title: Text('${item['name']} x ${item['quantity']}'),
                      subtitle: Text(
                          'Marca: ${item['brand']}\nModelo: ${item['model']}\nPrecio: ${item['price']}\$'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                              item['id'], item['quantity']);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductView(
                              brand: item['brand'],
                              category: item['category'],
                              description: item['description'],
                              model: item['model'],
                              name: item['name'],
                              price: item['price'],
                              userId: item['userId'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Costo total: $totalCost\$'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: initiatePurchase,
                  child: Text('Iniciar compra'),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
