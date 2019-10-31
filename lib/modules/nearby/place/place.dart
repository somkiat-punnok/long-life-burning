part of nearby;

class Place extends StatefulWidget {

  final String title;
  final bool fullscreen;
  final LatLng userLocation;
  final LocateCallback onTapLocate;

  Place({
    Key key,
    @required this.title,
    this.fullscreen,
    this.userLocation,
    this.onTapLocate,
  }) :  assert(title != null && title != ''),
        super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  List<Widget> items;

  void init(List<DocumentSnapshot> list) async {
    try {
      items = await mapItem(list);
    } catch (e) {
      print('Error: $e');
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Map").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        init(snapshot.data.documents);
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.statusBarHeight + 20.0,
                  bottom: 20.0,
                ),
                child: Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              CarouselCard(
                viewportFraction: 1.0,
                aspectRatio: SizeConfig.aspectRatio * 1.25,
                autoPlay: false,
                enlargeCenterPage: false,
                items: (items != null && items.isNotEmpty)
                    ? items
                    : [
                      Container(
                        child: Center(
                          child: Text('Hasn\'t place.'),
                        ),
                      ),
                    ],
              ),
            ],
          ),
        );
      }
    );
  }

  Future<List<Widget>> mapItem(List<DocumentSnapshot> list) async {
    List<Widget> result = <Widget>[];
    list.forEach((l) async {
      final Map<String, dynamic> data = l.data;
      data["id"] = l.documentID;
      data["image"] = "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80";
      final PlaceModel p = PlaceModel.fromMap(data);
      final Geoflutterfire geo = Geoflutterfire();
      final double dist = geo
        .point(
          latitude: widget.userLocation?.latitude,
          longitude: widget.userLocation?.longitude,
        )
        .distance(
          lat: p.lat,
          lng: p.long,
        );
      result.add(
        PlaceDetail(
          item: p,
          distance: dist,
          fullscreen: widget.fullscreen,
          onTap: widget.onTapLocate != null
              ? () => widget.onTapLocate(p.lat, p.long)
              : () {},
        )
      );
    });
    return result;
  }

}
