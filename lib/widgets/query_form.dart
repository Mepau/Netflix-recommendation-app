import 'package:flutter/material.dart';
import "./genres_picker.dart";

class QueryForm extends StatefulWidget {
  @override
  _QueryFormState createState() => _QueryFormState();
}

class _QueryFormState extends State<QueryForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GenresPicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
