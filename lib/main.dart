import 'package:flutter/material.dart';
import "./requests/rapid_api_req.dart";
import "./models/show.dart";
import 'dart:developer';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Show>> futureShowList;

  @override
  void initState() {
    super.initState();
    futureShowList = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Hello"),
          ),
          body: Center(
            child: FutureBuilder<List<Show>>(
                future: futureShowList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data![0]);
                    return ListView(
                      children: List.generate(
                          snapshot.data!.length,
                          (index) => Card(
                                child: ListTile(
                                    title: Text(snapshot.data![index].title),
                                    leading: Image.network(
                                        snapshot.data![index].poster)),
                              )),
                    );
                    return Text(snapshot.data![0].title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                }),
          )),
    );
  }
}
