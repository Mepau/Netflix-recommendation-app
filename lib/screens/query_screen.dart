import 'package:flutter/material.dart';
import 'package:netflix_recommend_app/widgets/query_form.dart';
import "../models/genre.dart";
import "../models/country.dart";

class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  List<Genre> _selectedGenres = [];
  List<Country> _selectedCountries = [];

  set genrelist(List<Genre> value) => setState(() {
        _selectedGenres = value;
      });

  set coutrylist(List<Country> value) => setState(() {
        _selectedCountries = value;
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
                setGenres: (val) => setState(() => _selectedGenres = val),
                setCountries: (val) => setState(() => _selectedCountries = val),
              ),
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
