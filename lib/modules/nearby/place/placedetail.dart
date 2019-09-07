part of nearby;

class PlaceDetail extends StatelessWidget {

  final ImageProvider image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  PlaceDetail({
    Key key,
    this.image,
    this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            image: DecorationImage(
              image: image,
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
                  shadows: [
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
                  ],
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
