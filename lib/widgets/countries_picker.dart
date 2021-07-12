import 'package:flutter/material.dart';
import 'package:netflix_recommend_app/widgets/grid_picker.dart';
import "../models/country.dart";
import "../providers/requests/rapid_api_req.dart";

typedef void ListCountriesCallback(List<Country> val);

class CountriesPicker extends StatefulWidget {
  final ListCountriesCallback callback;
  CountriesPicker({required this.callback});

  @override
  _CountriesPickerState createState() =>
      _CountriesPickerState(callback: callback);
}

class _CountriesPickerState extends State<CountriesPicker> {
  final ListCountriesCallback callback;
  _CountriesPickerState({required this.callback});

  List<Country> _selectedCountries = [];

  @override
  void initState() {
    super.initState();
  }

  addGenre(genre) {
    setState(() {
      _selectedCountries.add(genre);
    });
  }

  static String _displayStringForOption(Country option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Country>>(
        future: fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StatefulBuilder(
              builder: (context, setOuterState) {
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
                                        Autocomplete<Country>(
                                          displayStringForOption:
                                              _displayStringForOption,
                                          optionsBuilder: (TextEditingValue
                                              textEditingValue) {
                                            if (textEditingValue.text == "") {
                                              return const Iterable<
                                                  Country>.empty();
                                            }
                                            setInnerState(() {
                                              snapshot.data!
                                                  .where((Country option) {
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
                                              (Country option) {
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
                                          onSelected: (Country selection) {
                                            setInnerState(() {
                                              _selectedCountries.add(selection);
                                            });
                                            setOuterState(() {});
                                            callback(_selectedCountries);
                                          },
                                        ),
                                        Text("Selected Countries:"),
                                        SizedBox(
                                          height: 60,
                                          child: GridPicker(
                                            options: _selectedCountries,
                                            addCallback: (val) =>
                                                setInnerState(() => {}),
                                            removeCallback: (val) =>
                                                setInnerState(() =>
                                                    _selectedCountries
                                                        .remove(val)),
                                            refreshOuterState: () =>
                                                setOuterState(() => {}),
                                            selectedOptions: _selectedCountries,
                                          ),
                                        ),
                                        Text("Countries:"),
                                        Expanded(
                                          child: GridPicker(
                                            options: snapshot.data!,
                                            addCallback: (val) => setInnerState(
                                                () => _selectedCountries
                                                    .add(val)),
                                            removeCallback: (val) =>
                                                setInnerState(() =>
                                                    _selectedCountries
                                                        .remove(val)),
                                            refreshOuterState: () =>
                                                setOuterState(() => {}),
                                            selectedOptions: _selectedCountries,
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
                            'Select Countries',
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
                            itemCount: _selectedCountries.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(_selectedCountries[index].name),
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
              },
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
