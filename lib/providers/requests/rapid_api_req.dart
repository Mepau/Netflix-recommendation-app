import 'package:http/http.dart' as http;
import 'dart:convert';
import "../../models/show.dart";
import "../../models/genre.dart";
import '../../models/country.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final queryParameters1 = {
  "genrelist": '',
  "start_year": '1972',
  "orderby": 'rating',
  "audiosubtitle_andor": 'and',
  "limit": '100',
  "subtitle": 'english',
  "countrylist": '',
  "audio": 'english',
  "country_andorunique": 'unique',
  "offset": '0',
  "end_year": '2021'
};

var queryParameters2 = {
  "genrelist": '',
  "orderby": 'rating',
  "audiosubtitle_andor": 'and',
  "country_andorunique": 'and',
  "audio": 'english',
  "countrylist": '',
};

Map<String, String> get headers => {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'x-rapidapi-key': dotenv.env["RAPID_API_KEY"]!,
      'x-rapidapi-host': 'unogsng.p.rapidapi.com'
    };

Future<List<Show>> fetchShows(
    List<Genre> selectedGenres, List<Country> selectedCountries) async {
  queryParameters1["genrelist"] = "";
  queryParameters1["countrylist"] = "";
  List.generate(selectedGenres.length, (index) {
    queryParameters1["genrelist"] =
        queryParameters1["genrelist"]! + selectedGenres[index].id.toString();
    index < selectedGenres.length - 1
        ? queryParameters1["genrelist"] = queryParameters1["genrelist"]! + ","
        : null;
  });

  List.generate(selectedCountries.length, (index) {
    queryParameters1["countrylist"] = queryParameters1["countrylist"]! +
        selectedCountries[index].id.toString();
    index < selectedCountries.length - 1
        ? queryParameters1["countrylist"] =
            queryParameters1["countrylist"]! + ","
        : null;
  });

  print(queryParameters1);

  var url = Uri.https("unogsng.p.rapidapi.com", '/search', queryParameters1);
  var response = await http.get(url, headers: headers);
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List<Show> showList = [];
    for (var show in jsonResponse["results"]) {
      showList.add(Show.fromJson(show));
    }
    return showList;
  } else {
    throw Exception("Unable to load shows from rapid api");
  }
}

Future<List<Genre>> fetchGenres() async {
  var url = Uri.https("unogsng.p.rapidapi.com", '/genres');
  var response = await http.get(url, headers: headers);
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List<Genre> genresList = [];
    for (var genre in jsonResponse["results"]) {
      genresList.add(Genre.fromJson(genre));
    }
    return genresList;
  } else {
    throw Exception("Unable to load genres from rapid api");
  }
}

Future<List<Country>> fetchCountries() async {
  var url = Uri.https("unogsng.p.rapidapi.com", '/countries');
  var response = await http.get(url, headers: headers);
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List<Country> countriesList = [];
    for (var country in jsonResponse["results"]) {
      countriesList.add(Country.fromJson(country));
    }
    return countriesList;
  } else {
    throw Exception("Unable to load countries from rapid api");
  }
}
