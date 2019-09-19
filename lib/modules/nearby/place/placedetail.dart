part of nearby;

class PlaceDetail extends StatelessWidget {

  final List<String> image;
  final String title;
  final String subtitle;
  final String detail;
  final VoidCallback onTap;

  PlaceDetail({
    Key key,
    this.image,
    this.title,
    this.subtitle,
    this.detail,
    this.onTap,
  }) : super(key: key);

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
    return ListView.builder(
      itemCount: 1,
      padding: EdgeInsets.zero,
      itemBuilder: (context, i) {
        return StickyHeader(
          header: Card(
            elevation: 0.0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  image: DecorationImage(
                    image: NetworkImage(image[0]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        shadows: borderText,
                      ),
                    ),
                    subtitle: Text(
                      subtitle,
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
          content: Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Images",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: image[0],
                            height: 120.0,
                            width: (MediaQuery.of(context).size.width - 48) / 3 - 3,
                            fit: BoxFit.cover,
                          ),
                          CachedNetworkImage(
                            imageUrl: image[1],
                            width: (MediaQuery.of(context).size.width - 48) / 3 - 3,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                          CachedNetworkImage(
                            imageUrl: image[2],
                            width: (MediaQuery.of(context).size.width - 48) / 3 - 3,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.zero,
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
                          detail,
                          maxLines: 25,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
}
