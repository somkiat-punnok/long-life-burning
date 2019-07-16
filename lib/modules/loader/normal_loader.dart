import 'dart:async';
import 'package:flutter/material.dart';

class NormalLoader extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;

  NormalLoader({
    this.colors,
    this.duration,
  });

  @override
  _NormalLoaderState createState() => _NormalLoaderState();
}

class _NormalLoaderState extends State<NormalLoader> with SingleTickerProviderStateMixin {

  Timer timer;
  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  AnimationController controller;
  List<Animation<Color>> colorAnimations = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    for (int i = 0; i < widget.colors.length - 1; i++) {
      tweenAnimations.add(
        ColorTween(
          begin: widget.colors[i],
          end: widget.colors[i + 1],
        )
      );
    }
    tweenAnimations.add(
      ColorTween(
        begin: widget.colors[widget.colors.length - 1],
        end: widget.colors[0],
      )
    );
    for (int i = 0; i < widget.colors.length; i++) {
      Animation<Color> animation = tweenAnimations[i].animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            (1 / widget.colors.length) * (i + 1) - 0.05,
            (1 / widget.colors.length) * (i + 1),
            curve: Curves.linear,
          ),
        )
      );
      colorAnimations.add(animation);
    }
    tweenIndex = 0;
    timer = Timer.periodic(widget.duration, (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % widget.colors.length;
      });
    });
    controller.forward();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: colorAnimations[tweenIndex],
        ),
      ),
    );
  }

}
