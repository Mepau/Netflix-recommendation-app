import 'package:flutter/material.dart';
import "../providers/requests/rapid_api_req.dart";
import "../models/show.dart";
import "./show_card.dart";

class ShowLister extends StatefulWidget {
  const ShowLister({Key? key}) : super(key: key);

  @override
  _ShowListerState createState() => _ShowListerState();
}

class _ShowListerState extends State<ShowLister> {
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
          body: Container(
            child: FutureBuilder<List<Show>>(
                future: futureShowList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data![0]);
                    return ListView(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => ShowCard(snapshot.data![index]),
                      ),
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
