part of diagnose;

class BackgroundWithRings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double radius = SizeConfig.setWidth(140.0);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(RUNIMAGE),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomPaint(
          painter: WhiteCircleCutoutPainter(
            centerOffset: Offset(SizeConfig.setWidth(40.0), 0.0),
            circles: [
              Circle(radius: radius, alpha: 0x10),
              Circle(radius: radius + SizeConfig.setWidth(15.0), alpha: 0x28),
              Circle(radius: radius + SizeConfig.setWidth(30.0), alpha: 0x38),
              Circle(radius: radius + SizeConfig.setWidth(75.0), alpha: 0x50),
            ]
          ),
          child: Container(),
        ),
      ],
    );
  }
}
