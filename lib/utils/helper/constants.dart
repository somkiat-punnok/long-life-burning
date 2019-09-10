export 'package:long_life_burning/utils/widgets/platform.dart'
  show
    isMaterial,
    isCupertino;
export 'package:long_life_burning/utils/widgets/size_config.dart';
export './options.dart';

enum Gender {
  MALE,
  FEMALE,
}

const String APPNAME = 'Long Burn';

// Key others
// const String API_Key = '';

const List<String> PROVINCE = [
  'All Province','Phayao','Chaing Mai','Nan'
];

const List<String> CATEGORIES = [
  'All Category','Fun Run','Mini Marathon','Half Marathon','Marathon'
];

const List<String> GROUP_CATEGORIES = [
  'All Category','Football','Basketball','Volaball'
];

// image assets
const String IMAGES = 'assets/images';
const String SIGNINIMAGE = '$IMAGES/77314-OF1N1Y-610.jpg';
const String FORESTIMAGE = '$IMAGES/forest.jpg';
const String OCEANIMAGE = '$IMAGES/ocean.jpg';

// icon assets
const String ICONS = 'assets/icons';
const String BURNICON = '$ICONS/burn.png';
const String DISTANCEICON = '$ICONS/distance.png';
const String RUNNERICON = '$ICONS/runner.png';
