import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repuestazo/views/addproduct/addproduct.dart';
import 'package:repuestazo/views/notification_page.dart';
import 'package:repuestazo/views/products_page.dart';
import 'package:repuestazo/views/profile_page.dart';
import 'package:repuestazo/views/shopping_cart_page.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    ProductsPage(),
    AddProductScreen(),
    ShoppingCartPage(),
    ProfilePage()
  ];

  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    var scaffoldKey = GlobalKey<ScaffoldState>();

    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(),
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
          padding: const EdgeInsets.all(
              20), // margen de 16 píxeles en todos los lados
          child: Image.asset(
            'assets/images/RespuestazoWhiteIcon.png',
            height: screenHeight * 0.08,
            width: screenHeight * 0.08,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.all(
                  10), // margen de 16 píxeles en todos los lados
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, color: Colors.black),
                label: "Productos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colors.black),
                label: "Agregar Producto"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                label: "Carrito de compras"),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black),
              label: "Perfil",
            ),
          ],
          selectedIconTheme: IconThemeData(size: 25)),
    );
  }
}