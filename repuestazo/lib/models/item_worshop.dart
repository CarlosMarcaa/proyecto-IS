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
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.car_repair,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Taller: ${widget.brand}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Modelo: ${widget.model}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Precio: \$${widget.price}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
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
