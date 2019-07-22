import 'package:flutter/widgets.dart';

class SizeConfig {

  static final double width = 411.0;
  static final double height = 683.0;
  // width, height, devicePixelRatio, textScaleFactor
  // 414.0, 896.0, 2.0, 1.0
  // 411.42857142857144, 683.4285714285714, 2.625, 1.0
  // 320.0, 568.0, 2.0, 1.0

  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double pixelRatio;
  static double statusBarHeight;
  static double bottomBarHeight;
  static double textScaleFactor;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double safeAreaHorizontal;
  static double safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double scaleWidth;
  static double scaleHeight;
  
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    statusBarHeight = _mediaQueryData.padding.top;
    bottomBarHeight = _mediaQueryData.padding.bottom;
    textScaleFactor = _mediaQueryData.textScaleFactor;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = statusBarHeight + bottomBarHeight;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
    scaleWidth = screenWidth / width;
    scaleHeight = screenHeight / height;
  }

  static double setWidth(double _width) => _width * scaleWidth;
  static double setHeight(double _height) => _height * scaleHeight;

}