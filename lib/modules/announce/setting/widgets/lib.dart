library settings;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/utils/widgets/size_config.dart';

part 'button.dart';
part 'control.dart';
part 'header.dart';
part 'link.dart';
part 'picker.dart';
part 'selection.dart';
part 'widget.dart';

const double SETTING_ITEM_HEIGHT = 50.0;
const Color SETTING_HEADER_COLOR = Color(0xFFEEEEF3);
const Color SETTING_BORDER_COLOR = Colors.black12;
const Color SETTING_TEXT_COLOR = Colors.black;
const Color SETTING_HEADER_TEXT_COLOR = Colors.black54;
const EdgeInsets SETTING_ITEM_PADDING = EdgeInsets.only(left: 8.0, right: 8.0);
const double SETTING_HEADER_FONT_SIZE = 14.0;
const double SETTING_ITEM_NAME_SIZE = 15.0;
const EdgeInsets SETTING_ICON_PADDING = EdgeInsets.only(right: 8.0);
const Color SETTING_CHECK_COLOR = Colors.blue;
const double SETTING_CHECK_SIZE = 16.0;
const SettingWidgetStyle DEFAULT_STYLE = SettingWidgetStyle();

double _kPickerSheetHeight = SizeConfig.setHeight(268.0);
double _kPickerItemHeight = SizeConfig.setHeight(42.0);

typedef void SelectionCallback(int selected);
typedef void TimerCallback(Duration timer);
typedef void DateCallback(DateTime date);
