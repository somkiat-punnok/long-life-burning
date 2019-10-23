library search;

import 'package:flutter/material.dart';
import 'package:long_life_burning/pages/announce/detail_page.dart';

part './widgets.dart';

class SearchEventDelegate extends SearchDelegate<String> {

  SearchEventDelegate({
    String searchFieldLabel,
    TextInputType keyboardType,
    TextInputAction textInputAction,
  }) : super(
    searchFieldLabel: searchFieldLabel,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  final List<String> _data = List<String>.generate(1001, (int i) => i.toString()).toList();
  final List<String> _history = <String>[];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () async => close(context, null),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
        ? IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async => showResults(context),
          )
        : IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear),
            onPressed: () async {
              query = '';
              showSuggestions(context);
            },
          ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _data.where((String i) => '$i'.startsWith(query));

    return _SuggestionList(
      query: query,
      history: _history,
      suggestions: suggestions.map<String>((String i) => '$i').toList(),
      onSelected: (String suggestion) async {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query.toString();
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 100.0,
            ),
            Text(
              'No Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Try a more general keyword.\nSearch try again.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
    else {
      if (_history.indexOf(searched) < 0) _history.add(searched);
    }

    return ListView(
      children: <Widget>[
        _ResultCard(
          title: 'This String',
          string: searched,
          searchDelegate: this,
        ),
      ],
    );
  }

}
