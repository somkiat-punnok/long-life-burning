part of search;

class _ResultCard extends StatelessWidget {

  _ResultCard({
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
          padding: EdgeInsets.all(8.0),
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
