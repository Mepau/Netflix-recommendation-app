import 'package:http/http.dart' as http;
import 'dart:convert';
import "../../models/show.dart";
import "../../models/genre.dart";

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

Future<List<Show>> fetchShows() async {
  var url = Uri.https("unogsng.p.rapidapi.com", '/search', queryParameters);
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
