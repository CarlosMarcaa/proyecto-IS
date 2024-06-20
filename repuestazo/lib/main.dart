import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repuestazo/views/client_home_page/client_home_page.dart';
import 'package:repuestazo/views/home_page/home_page.dart';
import 'package:repuestazo/views/login/login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Repuestazo',
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Algo salió mal'));
        } else if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data!.uid)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasError) {
                return Center(child: Text('Algo salió mal'));
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                final data = userSnapshot.data!.data() as Map<String, dynamic>;
                if (data.containsKey('userType')) {
                  final userType = data['userType'];
                  print('UserType: $userType'); // Log for debugging
                  if (userType == 'Client') {
                    return ClientHomePage();
                  } else if (userType == 'Workshop') {
                    return HomePage();
                  } else {
                    print('UserType no reconocido: $userType');
                    return Login(); // Default case if userType is not recognized
                  }
                } else {
                  print('Campo userType no encontrado');
                  return Login(); // Default case if userType field doesn't exist
                }
              } else {
                print('Datos del usuario no existen');
                return Login(); // Default case if user data doesn't exist
              }
            },
          );
        } else {
          return Login();
        }
      },
    );
  }
}
