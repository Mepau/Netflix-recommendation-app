import 'package:flutter/material.dart';
import "../providers/requests/rapid_api_req.dart";
import "../models/show.dart";

class ShowCard extends StatelessWidget {
  const ShowCard(this.show);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.white70,
            width: 1,
          ),
        ),
        color: Colors.grey[200],
        elevation: 4,
        child: Column(
          children: [
            Image.network(show.poster),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("IMDB Rating"),
                      Icon(Icons.favorite),
                      Text(show.imdbrating.toString())
                    ],
                  ),
                  Column(
                    children: [
                      Text("Avg. Rating"),
                      Icon(Icons.favorite),
                      Text(show.avgrating.toString())
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(show.title),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(show.synopsis),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
