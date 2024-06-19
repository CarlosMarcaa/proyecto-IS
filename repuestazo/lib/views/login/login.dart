import 'package:flutter/material.dart';
import 'package:repuestazo/views/login/body.dart';
import 'package:repuestazo/views/home_page/home_page.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: const Text("Holi"),
        ),
      ),
    );
  }
}

