import 'package:flutter/cupertino.dart';

class Content {
  
  // Key others
  //static final String API_Key = '';

  // Routing name
  static final String Index_Page = '/';
  static final String About_Page = '/about';
  static final String Announce_Page = '/announce';
  static final String Chart_Page = '/chart';
  static final String Group_Page = '/group';
  static final String Nearby_Page = '/nearby';
  static final String Notify_Page = '/notify';
  static final String StepCount_Page = '/stepcount';

}

class IconsiOS {

  // Icons on iOS
  static const IconData home = IconData(
    0xf38f,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  static const IconData near_me = IconData(
    0xf474,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  static const IconData marathon = IconData(
    0xf3f4,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  static const IconData view_headline = IconData(
    0xf394,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

}

class IconsAndroid {

  // Icons on Android
  static const IconData marathon = IconData(
    0xe322,
    fontFamily: 'MaterialIcons'
  );

}