part of diagnose;

class RadialListItem extends StatelessWidget {

  final RadialListItemViewModel listItem;
  final VoidCallback onTap;

  RadialListItem({
    this.listItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(-30.0, -30.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            height: SizeConfig.setHeight(58.0),
            width: SizeConfig.setWidth(58.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: SizeConfig.setWidth(2.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.setWidth(8.0)),
              child: Image(
                image: listItem.icon,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.setWidth(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  listItem.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  listItem.subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
