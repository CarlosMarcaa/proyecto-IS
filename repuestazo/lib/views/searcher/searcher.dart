import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repuestazo/models/item.dart';

class Searcher extends SearchDelegate {
  String? selectedBrand;
  String? selectedCategory;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var results = snapshot.data!.docs.where((doc) {
          var product = doc.data() as Map<String, dynamic>;
          bool matchesQuery = query.isEmpty ||
              product['name'].toLowerCase().contains(query.toLowerCase()) ||
              product['brand'].toLowerCase().contains(query.toLowerCase()) ||
              product['model'].toLowerCase().contains(query.toLowerCase());
          bool matchesBrand =
              selectedBrand == null || product['brand'] == selectedBrand;
          bool matchesCategory = selectedCategory == null ||
              product['category'] == selectedCategory;
          return matchesQuery && matchesBrand && matchesCategory;
        }).toList();

        if (results.isEmpty) {
          return Center(
            child: Text('No se encontraron productos'),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            var product = results[index].data() as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Item(
                brand: product['brand'],
                category: product['category'],
                description: product['description'],
                model: product['model'],
                name: product['name'],
                price: product['price'],
                userId: product['userId'],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text('Buscar productos...'),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              showPopup(context);
            },
            child: const Icon(Icons.filter_alt),
          ),
        ),
      ],
    );
  }

  @override
  Widget? showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Filtros',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),

                  // Filtro marca
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Marca:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 10.0),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          var brands = snapshot.data!.docs
                              .map((doc) => doc['brand'].toString())
                              .toSet()
                              .toList();
                          return DropdownButton<String>(
                            value: selectedBrand,
                            items: brands
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newBrand) {
                              selectedBrand = newBrand;
                              Navigator.pop(context);
                              showPopup(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),

                  // Filtro categoría
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Categoría:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 10.0),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          var categories = snapshot.data!.docs
                              .map((doc) => doc['category'].toString())
                              .toSet()
                              .toList();
                          return DropdownButton<String>(
                            value: selectedCategory,
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newCategory) {
                              selectedCategory = newCategory;
                              Navigator.pop(context);
                              showPopup(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Filtrar'),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          selectedBrand = null;
                          selectedCategory = null;
                          Navigator.pop(context);
                        },
                        child: const Text('Borrar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
