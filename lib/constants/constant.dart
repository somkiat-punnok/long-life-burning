export 'package:long_life_burning/widgets/platform.dart'
  show
    isMaterial,
    isCupertino;
export 'package:long_life_burning/widgets/size_config.dart';

class Constants {

  Constants._();
  
  static const String appName = 'Long Burn';

  // Key others
  //static final String API_Key = '';

  // Routing name
  static const String indexRoute = '/index';
  static const String aboutRoute = '/about';
  static const String announceRoute = '/announce';
  static const String yearsRoute = '/year';
  static const String chartRoute = '/chart';
  static const String groupRoute = '/group';
  static const String nearbyRoute = '/nearby';
  static const String notifyRoute = '/notify';
  static const String stepCountRoute = '/stepcount';
  static const String recordRoute = '/record';

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
