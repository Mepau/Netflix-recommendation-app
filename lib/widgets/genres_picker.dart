import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import "../models/genre.dart";
import "../providers/requests/rapid_api_req.dart";

class GenresPicker extends StatefulWidget {
  @override
  _GenresPickerState createState() => _GenresPickerState();
}

class _GenresPickerState extends State<GenresPicker> {
  var _items;

  List<Genre> _selectedGenres = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Genre>>(
        future: fetchGenres(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _items = snapshot.data!
                .map((genre) => MultiSelectItem<Genre>(genre, genre.name))
                .toList();
            return Column(
              children: <Widget>[
                //################################################################################################
                // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
                // decoration applied. This allows the ChipDisplay to render inside the same Container.
                //################################################################################################
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: Text("Favorite Genres"),
                        title: Text("Genres"),
                        items: _items,
                        onConfirm: (values) {
                          _selectedGenres = values.cast();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedGenres.remove(value);
                            });
                          },
                        ),
                      ),
                      _selectedGenres.length == 1
                          ? Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "None selected",
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
