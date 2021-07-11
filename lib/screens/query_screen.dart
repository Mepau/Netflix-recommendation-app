import 'package:flutter/material.dart';
import 'package:netflix_recommend_app/widgets/query_form.dart';
import "../models/genre.dart";

class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  List<Genre> _selectedGenres = [];

  set list(List<Genre> value) => setState(() {
        _selectedGenres = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              QueryForm(
                  callback: (val) => setState(() => _selectedGenres = val)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/results",
                      arguments: _selectedGenres);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
