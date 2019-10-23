part of nearby;

class PlaceDetail extends StatelessWidget {

  final PlaceModel item;
  final num distance;
  final VoidCallback onTap;
  final bool fullscreen;

  PlaceDetail({
    Key key,
    @required this.item,
    this.distance,
    this.fullscreen,
    this.onTap,
  }) :  assert(item != null),
        super(key: key);

  final List<Shadow> borderText = <Shadow>[
    Shadow(
      offset: Offset(-1.5, -1.5),
      color: Colors.black,
      blurRadius: 2.0,
    ),
    Shadow(
      offset: Offset(1.5, -1.5),
      color: Colors.black,
      blurRadius: 2.0,
    ),
    Shadow(
      offset: Offset(1.5, 1.5),
      color: Colors.black,
      blurRadius: 2.0,
    ),
    Shadow(
      offset: Offset(-1.5, 1.5),
      color: Colors.black,
      blurRadius: 2.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: StickyHeaderBuilder(
        builder: (context, stuckAmount) => Container(
          color: Colors.white.withOpacity(1.0 - stuckAmount.clamp(0.0, 1.0)),
          padding: EdgeInsets.zero,
          child: Card(
            elevation: 0.0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  image: DecorationImage(
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: ListTile(
                    title: Text(
                      item.title,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        shadows: borderText,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                      ),
                      child: Text(
                        distance * 1000 < 1000
                          ? 'ระยะทาง: ${NumberFormat('#,###.##', 'en_US').format(distance * 1000)} เมตร'
                          : 'ระยะทาง: ${NumberFormat('#,###.##', 'en_US').format(distance)} กิโลเมตร',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          shadows: borderText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        content: Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(24.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.only(bottom: 12.0),
              //         child: Text(
              //           "Images",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: List.generate(
              //           item.image.length,
              //           (int i) => CachedNetworkImage(
              //             imageUrl: item.image[i],
              //             height: 160.0,
              //             width: (SizeConfig.screenWidth - 48) / item.image.length - item.image.length,
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        "About",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(
                        item.detail,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
