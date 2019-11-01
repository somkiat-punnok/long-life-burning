library header;

import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part './render.dart';
part './widget.dart';

typedef void RenderStickyHeaderCallback(double stuckAmount);
typedef Widget StickyHeaderWidgetBuilder(BuildContext context, double stuckAmount);
