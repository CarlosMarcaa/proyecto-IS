import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:repuestazo/views/login/login.dart';
import 'firebase_options.dart';
import "package:repuestazo/views/home_page/home_page.dart";

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repuestazo',
      home: const Login(),
    );
  }
}
