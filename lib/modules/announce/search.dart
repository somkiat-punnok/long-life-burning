import 'package:flutter/material.dart';
import 'package:long_life_burning/pages/announce/detail_page.dart';

class SearchEventDelegate extends SearchDelegate<String> {

  final List<String> _data = List<String>.generate(100001, (int i) => i.toString()).reversed.toList();
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
        child: Text(
          '"$query"\nIsn\'t a valid string between 0 and 100,000.\nSearch try again.',
          textAlign: TextAlign.center,
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

}

class _ResultCard extends StatelessWidget {

  const _ResultCard({
    this.string,
    this.title,
    this.searchDelegate,

  });

  final String string;
  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () async => await Navigator.of(context).pushNamed(EventDetailPage.routeName),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$string',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _SuggestionList extends StatelessWidget {
  
  const _SuggestionList({
    this.suggestions,
    this.history,
    this.query,
    this.onSelected,
  });

  final List<String> suggestions;
  final List<String> history;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: (query.isEmpty || history.indexOf(suggestion) >= 0) ? Icon(Icons.history) : Icon(Icons.event),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: theme.textTheme.subhead.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () async => onSelected(suggestion),
        );
      },
    );
  }

}
