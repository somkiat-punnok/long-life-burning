part of diagnose;

class RadialListViewModel {

  final List<RadialListItemViewModel> items;

  RadialListViewModel({
    this.items = const [],
  });

}

class RadialListItemViewModel {

  final ImageProvider icon;
  final String title;
  final String subtitle;

  RadialListItemViewModel({
    this.icon,
    this.title = '',
    this.subtitle = '',
  });

}
