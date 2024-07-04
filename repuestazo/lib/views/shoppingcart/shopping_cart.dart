import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/shoppingcart/body.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CartView(),
    );
  }
}
