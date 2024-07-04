import 'package:flutter/material.dart';
import 'package:repuestazo/views/product_view/product_view.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductView(
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
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Marca: ${widget.brand}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Modelo: ${widget.model}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Precio: ${widget.price}\$",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.car_repair,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
