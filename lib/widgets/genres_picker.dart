import 'package:flutter/material.dart';
import 'package:netflix_recommend_app/widgets/grid_picker.dart';
import "../models/genre.dart";
import "../providers/requests/rapid_api_req.dart";

typedef void ListCallback(List<Genre> val);

class GenresPicker extends StatefulWidget {
  final ListCallback callback;
  GenresPicker({required this.callback});

  @override
  _GenresPickerState createState() => _GenresPickerState(callback: callback);
}

class _GenresPickerState extends State<GenresPicker> {
  final ListCallback callback;
  _GenresPickerState({required this.callback});

  List<Genre> _selectedGenres = [];

  @override
  void initState() {
    super.initState();
  }

  addGenre(genre) {
    setState(() {
      _selectedGenres.add(genre);
    });
  }

  static String _displayStringForOption(Genre option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Genre>>(
        future: fetchGenres(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StatefulBuilder(builder: (context, setOuterState) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.blue[100],
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[50],
                          onPrimary: Colors.grey[900],
                          textStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setInnerState) {
                                  return Column(
                                    children: <Widget>[
                                      Autocomplete<Genre>(
                                        displayStringForOption:
                                            _displayStringForOption,
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          if (textEditingValue.text == "") {
                                            return const Iterable<
                                                Genre>.empty();
                                          }
                                          setInnerState(() {
                                            snapshot.data!
                                                .where((Genre option) {
                                              return option.name
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()) ||
                                                  option.name
                                                      .toLowerCase()
                                                      .startsWith(
                                                          textEditingValue
                                                              .text);
                                            }).toList();
                                          });
                                          return snapshot.data!.where(
                                            (Genre option) {
                                              return option.name
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()) ||
                                                  option.name
                                                      .toLowerCase()
                                                      .startsWith(
                                                          textEditingValue
                                                              .text);
                                            },
                                          );
                                        },
                                        onSelected: (Genre selection) {
                                          setInnerState(() {
                                            _selectedGenres.add(selection);
                                          });
                                          setOuterState(() {});
                                          callback(_selectedGenres);
                                        },
                                      ),
                                      Text("Selected Genres:"),
                                      SizedBox(
                                        height: 60,
                                        child: GridPicker(
                                          options: _selectedGenres,
                                          addCallback: (val) =>
                                              setInnerState(() => {}),
                                          removeCallback: (val) =>
                                              setInnerState(() =>
                                                  _selectedGenres.remove(val)),
                                          refreshOuterState: () =>
                                              setOuterState(() => {}),
                                          selectedOptions: _selectedGenres,
                                        ),
                                      ),
                                      Text("Genres:"),
                                      Expanded(
                                        child: GridPicker(
                                          options: snapshot.data!,
                                          addCallback: (val) => setInnerState(
                                              () => _selectedGenres.add(val)),
                                          removeCallback: (val) =>
                                              setInnerState(() =>
                                                  _selectedGenres.remove(val)),
                                          refreshOuterState: () =>
                                              setOuterState(() => {}),
                                          selectedOptions: _selectedGenres,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Select Genres',
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,
                                  childAspectRatio: 4 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: _selectedGenres.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(_selectedGenres[index].name),
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
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
