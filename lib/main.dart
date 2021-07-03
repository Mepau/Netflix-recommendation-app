import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "./http_response.dart";
import 'dart:developer';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Hello"),
          ),
          body: Center(
            child: Text("Hello World"),
          )),
    );
  }
}

final queryParameters = {
  "start_year": '1972',
  "orderby": 'rating',
  "audiosubtitle_andor": 'and',
  "limit": '100',
  "subtitle": 'english',
  "countrylist": '78,46',
  "audio": 'english',
  "country_andorunique": 'unique',
  "offset": '0',
  "end_year": '2019'
};

Map<String, String> get headers => {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'x-rapidapi-key': '9263455e1dmshaef3d2ac8e5d156p1698d5jsn74890100eeae',
      'x-rapidapi-host': 'unogsng.p.rapidapi.com'
    };

Future<http.Response> fetchAlbum() async {
  var url = Uri.https("unogsng.p.rapidapi.com", '/search', queryParameters);
  var response = await http.get(url, headers: headers);
  print(response.body);
  return response;
}
