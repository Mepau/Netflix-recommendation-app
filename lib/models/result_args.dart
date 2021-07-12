import "./country.dart";
import "./genre.dart";

class ResultArgs {
  final List<Genre> genreList;
  final List<Country> countryList;

  ResultArgs({required this.genreList, required this.countryList});
}
