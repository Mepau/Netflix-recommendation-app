import 'package:flutter/material.dart';
import "../widgets/genres_picker.dart";
import "./results_screen.dart";
import "../models/genre.dart";

class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  List<Genre> _selectedGenres = [];

  set list(List<Genre> value) => setState(() => _selectedGenres = value);

  @override
  Widget build(BuildContext context) {
    print(_selectedGenres);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GenresPicker(
                  callback: (val) => setState(() => _selectedGenres = val)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsScreen()),
                  );
                },
                child: Text("Submit"),
              ),
              _selectedGenres.length > 0
                  ? Text(_selectedGenres[0].name)
                  : Text("hello"),
            ],
          ),
        ),
      ),
    );
  }
}

//class QueryScreen extends StatelessWidget {
//  const QueryScreen({Key? key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    print(key);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Hello"),
//      ),
//      body: SingleChildScrollView(
//        child: Container(
//          child: Column(
//            children: [
//              GenresPicker(),
//              ElevatedButton(
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ResultsScreen()),
//                  );
//                },
//                child: Text("Submit"),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
