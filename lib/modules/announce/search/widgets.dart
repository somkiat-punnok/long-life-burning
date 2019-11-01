part of search;

class _SuggestionList extends StatelessWidget {

  const _SuggestionList({
    this.suggestions,
    this.mapCategory,
    this.query,
    this.onSelected,
  });

  final List<Event> suggestions;
  final Map<Event, SearchWhere> mapCategory;
  final String query;
  final EventCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final Event suggestion = suggestions[i];
        return Card(
          elevation: 4.0,
          shape: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: ListTile(
            title: mapCategory[suggestion] == SearchWhere.title
              ? RichText(
                  text: TextSpan(
                    text: suggestion.title.substring(0, query.length),
                    style: theme.textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: suggestion.title.substring(query.length),
                        style: theme.textTheme.subhead,
                      ),
                    ],
                  ),
                )
              : Text(suggestion.title.toString()),
            subtitle: mapCategory[suggestion] == SearchWhere.subtitle
              ? RichText(
                  text: TextSpan(
                    text: suggestion.subtitle.substring(0, query.length),
                    style: theme.textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: suggestion.subtitle.substring(query.length),
                        style: theme.textTheme.subhead,
                      ),
                    ],
                  ),
                )
              : Text(suggestion.subtitle.toString()),
            onTap: () => this.onSelected != null ? onSelected(suggestion) : () {},
          ),
        );
      },
    );
  }

}
