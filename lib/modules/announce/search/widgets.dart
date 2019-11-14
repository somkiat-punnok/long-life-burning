part of search;

class _SuggestionList extends StatelessWidget {

  final List<Event> suggestions;
  final Map<Event, SearchWhere> mapCategory;
  final String query;
  final EventCallback onSelected;

  const _SuggestionList({
    Key key,
    this.suggestions,
    this.mapCategory,
    this.query,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        return EventCard(
          event: suggestions[i],
          onClick: this.onSelected ?? EventCallback,
        );
      },
    );
  }
}
