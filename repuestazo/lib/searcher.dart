import 'package:flutter/material.dart';

import 'API.dart';
import 'Usermodel.dart';

class Searcher extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(icon: Icon(Icons.close), onPressed: (){
      query = "";
    })
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
      Navigator.pop(context);
    } );
  }

  FetchUser _userList = FetchUser();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: FutureBuilder<List<UserList>>(
            future: _userList.getUserList(),
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
                                    fontWeight: FontWeight.bold),
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
                                    fontWeight: FontWeight.w600),
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
            }),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     return Center(
      child: Text('Search car parts, products and more...'),
      );
  }

}