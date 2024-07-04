import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CheckoutView({required this.cartItems});

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _paymentMethod = '';
  String _shippingMethod = '';
  double _totalCost = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalCost();
  }

  void _calculateTotalCost() {
    _totalCost = widget.cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  Future<void> _placeOrder() async {
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    // Simulate order creation
    await firestore.collection('orders').add({
      'userId': auth.currentUser!.uid,
      'items': widget.cartItems,
      'totalCost': _totalCost,
      'paymentMethod': _paymentMethod,
      'shippingMethod': _shippingMethod,
    });

    // Clear cart
    await firestore
        .collection('cart')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pedido realizado con éxito')),
    );

    // Navigate back to cart
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Resumen de la orden'),
            SizedBox(height: 16),
            Text('Costo total: $_totalCost\$'),
            SizedBox(height: 16),
            Text('Método de pago:'),
            RadioListTile(
              title: Text('Tarjeta de crédito'),
              value: 'credit_card',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value as String;
                });
              },
            ),
            RadioListTile(
              title: Text('PayPal'),
              value: 'paypal',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value as String;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Método de envío:'),
            RadioListTile(
              title: Text('Envío estándar'),
              value: 'standard_shipping',
              groupValue: _shippingMethod,
              onChanged: (value) {
                setState(() {
                  _shippingMethod = value as String;
                });
              },
            ),
            RadioListTile(
              title: Text('Envío express'),
              value: 'express_shipping',
              groupValue: _shippingMethod,
              onChanged: (value) {
                setState(() {
                  _shippingMethod = value as String;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _placeOrder,
              child: Text('Realizar pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
