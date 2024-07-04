import 'package:flutter/material.dart';
import 'package:repuestazo/views/workshops_view/worshop_view.dart';

// ignore: must_be_immutable
class Item extends StatefulWidget {
  String brand;
  String category;
  String description;
  String model;
  String name;
  int price;
  String userId;

  Item(
      {super.key,
      required this.brand,
      required this.category,
      required this.description,
      required this.model,
      required this.name,
      required this.price,
      required this.userId});

  ItemState createState() => ItemState();
}

class ItemState extends State<Item> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorshopView(
                    brand: widget.brand,
                    category: widget.category,
                    description: widget.description,
                    model: widget.model,
                    name: widget.name,
                    price: widget.price,
                    userId: widget.userId)))
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 150,
          width: 375,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                      "${widget.name}\nTALLER: ${widget.brand}\nModelo: ${widget.model}\nPrecio: ${widget.price}\$"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
