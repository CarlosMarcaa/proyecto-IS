import 'package:flutter/material.dart';
import 'package:repuestazo/views/workshop_list/body.dart';

class WorkshopListPage extends StatefulWidget {
  @override
  WorkshopListPageState createState() => WorkshopListPageState();
}

class WorkshopListPageState extends State<WorkshopListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        category: 'Servicio',
      ),
    );
  }
}
