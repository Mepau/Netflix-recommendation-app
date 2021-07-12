import 'package:flutter/material.dart';
import "../providers/requests/rapid_api_req.dart";
import "../models/show.dart";
import "./show_card.dart";
import "../models/genre.dart";
import "../models/country.dart";

class ShowLister extends StatefulWidget {
  final List<Genre> selectedGenres;
  final List<Country> selectedCountries;
  ShowLister(
      {Key? key, required this.selectedGenres, required this.selectedCountries})
      : super(key: key);

  @override
  _ShowListerState createState() =>
      _ShowListerState(selectedGenres, selectedCountries);
}

class _ShowListerState extends State<ShowLister> {
  late Future<List<Show>> futureShowList;
  final List<Genre> _selectedGenres;
  final List<Country> _selectedCountries;
  _ShowListerState(this._selectedGenres, this._selectedCountries);

  @override
  void initState() {
    super.initState();

    futureShowList = fetchShows(_selectedGenres, _selectedCountries);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Show>>(
        future: futureShowList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: List.generate(
                snapshot.data!.length,
                (index) => ShowCard(snapshot.data![index]),
              ),
            );
            return Text(snapshot.data![0].title);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
