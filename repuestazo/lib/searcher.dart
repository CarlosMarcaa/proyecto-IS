import 'package:flutter/material.dart';

import 'API.dart';
import 'Usermodel.dart';

class Searcher extends SearchDelegate {
  String? selectedLevel;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  FetchUser _userList = FetchUser();

  @override
  Widget buildResults(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: FutureBuilder<List<UserList>>(
            future: _userList.getUserList(query: query),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  if (selectedLevel != null &&
                      data![index].level != selectedLevel) {
                    return Container(); // Hide the item
                  }
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'ID',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data?[index].name}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('${data?[index].level}'),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              print('¡Botón flotante presionado!');
            },
            child: const Icon(Icons.filter_alt),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text('Search car parts, products and more...'),
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

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
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
                  DropdownButton<String>(
                    value: selectedLevel,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'in Training',
                        child: Text('in Training'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Rookie',
                        child: Text('Rookie'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Champion',
                        child: Text('Champion'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Ultimate',
                        child: Text('Ultimate'),
                      ),
                    ],
                    onChanged: (newLevel) {
                      selectedLevel = newLevel;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Apply filter based on selected level
                          if (selectedLevel != null) {
                            // Update your search query with the selected level
                            query = 'level:$selectedLevel';
                          }
                          Navigator.pop(context); // Close the popup
                        },
                        child: const Text('Filtrar'),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Reset selection and close the popup

                          query = 'level:$selectedLevel';

                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
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





/*void showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Filtros',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'This is the popup content. You can add more widgets, text, or custom UI elements here.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Yes button pressed!');
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        print('No button pressed!');
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
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
}*/
