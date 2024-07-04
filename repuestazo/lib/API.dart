import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repuestazo/Usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchUser {
  var data = [];
  List<UserList> results = [];
  String fetchurl = "https://digimon-api.vercel.app/api/digimon";
  Future<List<UserList>> getUserList({String? query}) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => UserList.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('Error en la API');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
