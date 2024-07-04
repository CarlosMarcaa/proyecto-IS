import 'package:flutter/material.dart';
import 'package:repuestazo/views/services_list/body.dart';

class ServiceListPage extends StatefulWidget {
  @override
  ServiceListPageState createState() => ServiceListPageState();
}

class ServiceListPageState extends State<ServiceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        category: 'Servicio',
      ),
    );
  }
}
