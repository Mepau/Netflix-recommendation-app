import 'package:flutter/material.dart';
import "./genres_picker.dart";

class QueryForm extends StatefulWidget {
  final ListCallback callback;
  QueryForm({required this.callback});

  @override
  _QueryFormState createState() => _QueryFormState(callback: callback);
}

class _QueryFormState extends State<QueryForm> {
  final ListCallback callback;
  _QueryFormState({required this.callback});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GenresPicker(callback: callback),
        ],
      ),
    );
  }
}
