part of diagnose;

class WhiteCircleCutoutPainter extends CustomPainter {

  final Color overlayColor = isMaterial ? Colors.grey : CupertinoColors.inactiveGray;
  final List<Circle> circles;
  final Offset centerOffset;
  final Paint whitePaint;
  final Paint borderPaint;

  WhiteCircleCutoutPainter({
    this.circles = const [],
    this.centerOffset = const Offset(0.0, 0.0),
  }) :  whitePaint = Paint(),
        borderPaint = Paint() {
          borderPaint
            ..color = Color(0x10FFFFFF)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.0;
          }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 1; i < circles.length; i++) {
      _maskCircle(canvas, size, circles[i-1].radius);
      whitePaint.color = overlayColor.withAlpha(circles[i-1].alpha);
      canvas.drawCircle(
        Offset(0.0, size.height / 2) + centerOffset,
        circles[i].radius,
        whitePaint,
      );
      canvas.drawCircle(
        Offset(0.0, size.height / 2) + centerOffset,
        circles[i - 1].radius,
        borderPaint,
      );
    }
    _maskCircle(canvas, size, circles.last.radius);
    whitePaint.color = overlayColor.withAlpha(circles.last.alpha);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      whitePaint,
    );
    canvas.drawCircle(
      Offset(0.0, size.height / 2) + centerOffset,
      circles.last.radius,
      borderPaint,
    );
  }

  _maskCircle(Canvas canvas, Size size, double radius) {
    Path clippedCircle = Path();
    clippedCircle.fillType = PathFillType.evenOdd;
    clippedCircle.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    clippedCircle.addOval(
      Rect.fromCircle(
        center: Offset(0.0, size.height / 2) + centerOffset,
        radius: radius,
      ),
    );
    canvas.clipPath(clippedCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class Circle {

  final double radius;
  final int alpha;

  Circle({
    this.radius,
    this.alpha = 0xFF,
  });
  
}

class CircleClipper extends CustomClipper<Rect> {

  final double radius;
  final Offset offset;

  CircleClipper({
    this.radius,
    this.offset = const Offset(0.0, 0.0),
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(0.0, size.height / 2) + offset,
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}
