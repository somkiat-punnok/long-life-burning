library header;

import 'dart:math' show min, max;
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part './widget.dart';
part './render.dart';

/// Called every layout to provide the amount of stickyness a header is in.
/// This lets the widgets animate their content and provide feedback.
///
typedef void RenderStickyHeaderCallback(double stuckAmount);

/// Builder called during layout to allow the header's content to be animated or styled based
/// on the amount of stickyness the header has.
///
/// [context] for your build operation.
///
/// [stuckAmount] will have the value of:
/// ```
///   0.0 <= value <= 1.0: about to be stuck
///          0.0 == value: at top
///  -1.0 >= value >= 0.0: past stuck
/// ```
///
typedef Widget StickyHeaderWidgetBuilder(BuildContext context, double stuckAmount);
