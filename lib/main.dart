import 'package:flutter/material.dart';
import "./widgets/show_lister.dart";
import 'dart:developer';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShowLister(),
    );
  }
}
