import 'package:flutter/material.dart';
import "../widgets/genres_picker.dart";
import "./results_screen.dart";

class QueryScreen extends StatelessWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(key);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GenresPicker(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsScreen()),
                  );
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
