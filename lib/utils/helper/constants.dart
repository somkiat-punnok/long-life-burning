// import 'package:flutter/material.dart';

export 'package:long_life_burning/utils/widgets/platform.dart'
  show
    isMaterial,
    isCupertino;
export 'package:long_life_burning/utils/widgets/size_config.dart';

class Constants {

  Constants._();
  
  static const String appName = 'Long Burn';

  // Key others
  // static final String API_Key = '';

  static const List<String> province = [
    'All Province','Phayao','Chaing Mai','Nan'
  ];

  static const List<String> categories = [
    'All Category','Fun Run','Mini Marathon','Half Marathon','Marathon'
  ];

  // image assets
  static const String image = 'assets/images';
  static const String forestImage = '$image/forest.jpg';
  static const String oceanImage = '$image/ocean.jpg';

  // icon assets
  static const String icon = 'assets/icons';
  static const String burnIcon = '$icon/burn.png';
  static const String distanceIcon = '$icon/distance.png';
  static const String runnerIcon = '$icon/runner.png';

}