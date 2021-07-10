import 'package:flutter/material.dart';
import "../widgets/show_lister.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: ShowLister(),
      ),
    );
  }
}
