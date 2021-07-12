import 'package:flutter/material.dart';
import "../widgets/show_lister.dart";
import "../models/result_args.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ResultArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: ShowLister(
            selectedGenres: args.genreList,
            selectedCountries: args.countryList),
      ),
    );
  }
}
