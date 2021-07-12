import 'package:http/http.dart' as http;
import 'dart:convert';
import "../../models/show.dart";
import "../../models/genre.dart";
import '../../models/country.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final queryParameters1 = {
  "genrelist": '83, 5505',
  "start_year": '1972',
  "orderby": 'rating',
  "audiosubtitle_andor": 'and',
  "limit": '100',
  "subtitle": 'english',
  "countrylist": '78,46',
  "audio": 'english',
  "country_andorunique": 'unique',
  "offset": '0',
  "end_year": '2021'
};

var queryParameters2 = {
  "genrelist": '11,',
  "orderby": 'rating',
  "audiosubtitle_andor": 'and',
  "country_andorunique": 'and',
  "audio": 'english'
};

Map<String, String> get headers => {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'x-rapidapi-key': dotenv.env["RAPID_API_KEY"]!,
      'x-rapidapi-host': 'unogsng.p.rapidapi.com'
    };

Future<List<Show>> fetchShows(selectedGenres) async {
  print(queryParameters2["genrelist"]);
  queryParameters1["genrelist"] = "5505";
  print(queryParameters2["genrelist"]);

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
