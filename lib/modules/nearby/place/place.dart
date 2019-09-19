part of nearby;

class Place extends StatefulWidget {
  
  final String title;
  final bool fullscreen;
  final LocateCallback onTapLocate;

  Place({
    Key key,
    @required this.title,
    this.fullscreen,
    this.onTapLocate,
  }) :  assert(title != null && title != ''),
        super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: widget.fullscreen ? SizeConfig.statusBarHeight + 20.0 : 40.0,
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
            aspectRatio: SizeConfig.aspectRatio * 1.3,
            autoPlay: false,
            enlargeCenterPage: false,
            items: mapItem([
              {
                "image": [
                  "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80",
                  "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                  "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                ],
                "name": "อ่างหลวง มหาวิทยาลัยพะเยา",
                "distence": 0.5,
                "lat": 19.026038,
                "long": 99.897562,
                "detail": "Pittsburgh is a city in the Commonwealth of Pennsylvania "
                  + "in the United States, and is the county seat of Allegheny County. "
                  + "As of 2017, a population of 305,704 lives within the city limits, "
                  + "making it the 63rd-largest city in the U.S. The metropolitan population "
                  + "of 2,353,045 is the largest in both the Ohio Valley and Appalachia, "
                  + "the second-largest in Pennsylvania (behind Philadelphia), "
                  + "and the 26th-largest in the U.S.  Pittsburgh is located in the "
                  + "south west of the state, at the confluence of the Allegheny, "
                  + "Monongahela, and Ohio rivers, Pittsburgh is known both as 'the Steel City' "
                  + "for its more than 300 steel-related businesses and as the 'City of Bridges' "
                  + "for its 446 bridges. The city features 30 skyscrapers, two inclined railways, "
                  + "a pre-revolutionary fortification and the Point State Park at the "
                  + "confluence of the rivers. The city developed as a vital link of "
                  + "the Atlantic coast and Midwest, as the mineral-rich Allegheny "
                  + "Mountains made the area coveted by the French and British "
                  + "empires, Virginians, Whiskey Rebels, and Civil War raiders.",
              },
              {
                "image": [
                  "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
                  "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                  "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                ],
                "name": "ลานฮอ มหาวิทยาลัยพะเยา",
                "distence": 1,
                "lat": 19.033918,
                "long": 99.890882,
                "detail": "Pittsburgh is a city in the Commonwealth of Pennsylvania "
                  + "in the United States, and is the county seat of Allegheny County. "
                  + "As of 2017, a population of 305,704 lives within the city limits, "
                  + "making it the 63rd-largest city in the U.S. The metropolitan population "
                  + "of 2,353,045 is the largest in both the Ohio Valley and Appalachia, "
                  + "the second-largest in Pennsylvania (behind Philadelphia), "
                  + "and the 26th-largest in the U.S.  Pittsburgh is located in the "
                  + "south west of the state, at the confluence of the Allegheny, "
                  + "Monongahela, and Ohio rivers, Pittsburgh is known both as 'the Steel City' "
                  + "for its more than 300 steel-related businesses and as the 'City of Bridges' "
                  + "for its 446 bridges. The city features 30 skyscrapers, two inclined railways, "
                  + "a pre-revolutionary fortification and the Point State Park at the "
                  + "confluence of the rivers. The city developed as a vital link of "
                  + "the Atlantic coast and Midwest, as the mineral-rich Allegheny "
                  + "Mountains made the area coveted by the French and British "
                  + "empires, Virginians, Whiskey Rebels, and Civil War raiders.",
              },
              {
                "image": [
                  "https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80",
                  "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                  "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                ],
                "name": "สวนสุขภาพ กว๊านพะเยา",
                "distence": 16,
                "lat": 19.159111,
                "long": 99.912461,
                "detail": "Pittsburgh is a city in the Commonwealth of Pennsylvania "
                  + "in the United States, and is the county seat of Allegheny County. "
                  + "As of 2017, a population of 305,704 lives within the city limits, "
                  + "making it the 63rd-largest city in the U.S. The metropolitan population "
                  + "of 2,353,045 is the largest in both the Ohio Valley and Appalachia, "
                  + "the second-largest in Pennsylvania (behind Philadelphia), "
                  + "and the 26th-largest in the U.S.  Pittsburgh is located in the "
                  + "south west of the state, at the confluence of the Allegheny, "
                  + "Monongahela, and Ohio rivers, Pittsburgh is known both as 'the Steel City' "
                  + "for its more than 300 steel-related businesses and as the 'City of Bridges' "
                  + "for its 446 bridges. The city features 30 skyscrapers, two inclined railways, "
                  + "a pre-revolutionary fortification and the Point State Park at the "
                  + "confluence of the rivers. The city developed as a vital link of "
                  + "the Atlantic coast and Midwest, as the mineral-rich Allegheny "
                  + "Mountains made the area coveted by the French and British "
                  + "empires, Virginians, Whiskey Rebels, and Civil War raiders.",
              },
              {
                "image": [
                  "https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80",
                  "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                  "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                ],
                "name": "ลานสุขภาพ กว๊านพะเยา",
                "distence": 18,
                "lat": 19.1636727,
                "long": 99.9026471,
                "detail": "Pittsburgh is a city in the Commonwealth of Pennsylvania "
                  + "in the United States, and is the county seat of Allegheny County. "
                  + "As of 2017, a population of 305,704 lives within the city limits, "
                  + "making it the 63rd-largest city in the U.S. The metropolitan population "
                  + "of 2,353,045 is the largest in both the Ohio Valley and Appalachia, "
                  + "the second-largest in Pennsylvania (behind Philadelphia), "
                  + "and the 26th-largest in the U.S.  Pittsburgh is located in the "
                  + "south west of the state, at the confluence of the Allegheny, "
                  + "Monongahela, and Ohio rivers, Pittsburgh is known both as 'the Steel City' "
                  + "for its more than 300 steel-related businesses and as the 'City of Bridges' "
                  + "for its 446 bridges. The city features 30 skyscrapers, two inclined railways, "
                  + "a pre-revolutionary fortification and the Point State Park at the "
                  + "confluence of the rivers. The city developed as a vital link of "
                  + "the Atlantic coast and Midwest, as the mineral-rich Allegheny "
                  + "Mountains made the area coveted by the French and British "
                  + "empires, Virginians, Whiskey Rebels, and Civil War raiders.",
              },
            ]),
          ),
        ],
      ),
    );
  }

  List<Widget> mapItem(List<Map<String, dynamic>> list) {
    List<Widget> result = [];
    list.forEach((l) {
      result.add(
        PlaceDetail(
          image: l['image'],
          title: l['name'],
          subtitle: 'ระยะทาง: ${l['distence']} กิโลเมตร',
          detail: l['detail'],
          onTap: widget.onTapLocate != null ? () => widget.onTapLocate(l['lat'], l['long']) : () {},
        )
      );
    });
    return result;
  }

}
