import 'package:flutter/material.dart';
import "./genres_picker.dart";
import "./countries_picker.dart";

class QueryForm extends StatefulWidget {
  final ListGenreCallback setGenres;
  final ListCountriesCallback setCountries;
  QueryForm({required this.setGenres, required this.setCountries});

  @override
  _QueryFormState createState() =>
      _QueryFormState(setGenres: setGenres, setCountries: setCountries);
}

class _QueryFormState extends State<QueryForm> {
  final ListGenreCallback setGenres;
  final ListCountriesCallback setCountries;
  _QueryFormState({required this.setGenres, required this.setCountries});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GenresPicker(callback: setGenres),
          CountriesPicker(callback: setCountries),
        ],
      ),
    );
  }
}
