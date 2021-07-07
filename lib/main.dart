import 'package:flutter/material.dart';
import "./widgets/show_lister.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:developer';
import 'dart:convert';

Future main() async {
  await dotenv.load(fileName: "../.env");
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
