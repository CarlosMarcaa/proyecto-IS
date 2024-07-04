import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/addproduct/addproduct.dart';
import 'package:repuestazo/views/home_page/body.dart';
import 'package:repuestazo/views/login/login.dart';
import 'package:repuestazo/views/products/products.dart';
import 'package:repuestazo/views/profile/profile.dart';
import 'package:repuestazo/views/shoppingcart/shopping_cart.dart';
import 'package:repuestazo/views/workshop_list/workshop_list.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String userType = '';
  bool isLoading = true;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _getUserType();
  }

  Future<void> _getUserType() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userType = userDoc['userType'];
        isLoading = false;

        if (userType == 'Client') {
          pages = [
            ProductsPage(),
            ShoppingCartPage(),
            WorkshopListPage(),
            ProfilePage()
          ];
        } else if (userType == 'Workshop') {
          pages = [ProductsPage(), AddProductScreen(), ProfilePage()];
        }
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    var scaffoldKey = GlobalKey<ScaffoldState>();

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout"),
              onTap: () => _logout(context),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/images/RespuestazoWhiteIcon.png',
            height: screenHeight * 0.08,
            width: screenHeight * 0.08,
          ),
        ),
        centerTitle: true,
      ),
      body: Body(currentIndex: currentIndex, pages: pages),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.black,
          items: userType == 'Client'
              ? const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag, color: Colors.black),
                      label: "Productos"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart, color: Colors.black),
                      label: "Carrito de compras"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.build, color: Colors.black),
                      label: "Talleres"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, color: Colors.black),
                    label: "Perfil",
                  ),
                ]
              : const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag, color: Colors.black),
                      label: "Productos"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add, color: Colors.black),
                      label: "Agregar Producto"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, color: Colors.black),
                    label: "Perfil",
                  ),
                ],
          selectedIconTheme: IconThemeData(size: 25)),
    );
  }
}
