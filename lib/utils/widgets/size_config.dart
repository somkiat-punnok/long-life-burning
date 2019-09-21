import 'package:flutter/widgets.dart';

class SizeConfig {

  static double screenWidth;
  static double screenHeight;
  static double aspectRatio;
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
  static double scaleSize;
  
  static void init(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final double width = 411.42857142857144;
    final double height = 683.4285714285714;
    // width, height, devicePixelRatio, textScaleFactor
    // iPhoneXr 414.0, 896.0, 2.0, 1.0
    // 411.42857142857144, 683.4285714285714, 2.625, 1.0
    // 360.0, 592.0, 3.0, 1.0
    // 320.0, 568.0, 2.0, 1.0
    // iPhoneXs Width: 375.0, Height: 812.0, Scale: (0.9114583333333333, 1.1881270903010033), Safe: (top: 44.0, bottom: 34.0)
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    aspectRatio = _mediaQueryData.size.aspectRatio;
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
    scaleSize = ((screenWidth * screenHeight) / (width * height));
    // print("$screenWidth, $screenHeight, $pixelRatio, $textScaleFactor");
  }

  static double setWidth(double _width) => _width * scaleWidth;
  static double setHeight(double _height) => _height * scaleHeight;
  static double setSize(double _size) => _size * scaleSize;

  static String printData() {
    return 'Width: $screenWidth, Height: $screenHeight, Scale: ($scaleWidth, $scaleHeight), Safe: (top: $statusBarHeight, bottom: $bottomBarHeight)';
  }

}
