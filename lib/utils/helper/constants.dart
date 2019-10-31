library constant;

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;
import 'package:firebase_auth/firebase_auth.dart'
  show
    FirebaseAuth,
    FirebaseUser;
import '../providers/all.dart' show UserProvider;

export '../widgets/platform.dart';
export '../widgets/size_config.dart';

part './fonts.dart';
part './functions.dart';
part './icons.dart';
part './options.dart';

enum Gender {
  MALE,
  FEMALE,
}

const String APPNAME = 'Long Burn';

// Key
// const String API_Key = '';

const List<String> PROVINCE = [
  'All Province',
  'Bangkok',
  'Amnat Charoen',
  'Ang Thong',
  'Bueng Kan',
  'Buriram',
  'Chachoengsao',
  'Chai Nat',
  'Chaiyaphum',
  'Chanthaburi',
  'Chiang Mai',
  'Chiang Rai',
  'Chonburi',
  'Chumphon',
  'Kalasin',
  'Kamphaeng Phet',
  'Kanchanaburi',
  'Khon Kaen',
  'Krabi',
  'Lampang',
  'Lamphun',
  'Loei',
  'Lopburi',
  'Mae Hong Son',
  'Maha Sarakham',
  'Mukdahan',
  'Nakhon Nayok',
  'Nakhon Pathom',
  'Nakhon Phanom',
  'Nakhon Ratchasima',
  'Nakhon Sawan',
  'Nakhon Si Thammarat',
  'Nan',
  'Narathiwat',
  'Nong Bua Lamphu',
  'Nong Khai',
  'Nonthaburi',
  'Pathum Thani',
  'Pattani',
  'Phang Nga',
  'Phatthalung',
  'Phayao',
  'Phetchabun',
  'Phetchaburi',
  'Phichit',
  'Phitsanulok',
  'Phra Nakhon Si Ayutthaya',
  'Phrae',
  'Phuket',
  'Prachinburi',
  'Prachuap Khiri Khan',
  'Ranong',
  'Ratchaburi',
  'Rayong',
  'Roi Et',
  'Sa Kaeo',
  'Sakon Nakhon',
  'Samut Prakan',
  'Samut Sakhon',
  'Samut Songkhram',
  'Saraburi',
  'Satun',
  'Sing Buri',
  'Sisaket',
  'Songkhla',
  'Sukhothai',
  'Suphan Buri',
  'Surat Thani',
  'Surin',
  'Tak',
  'Trang',
  'Trat',
  'Ubon Ratchathani',
  'Udon Thani',
  'Uthai Thani',
  'Uttaradit',
  'Yala',
  'Yasothon',
];

// const List<String> PROVINCE = [
//   'กรุงเทพมหานคร',
//   'อำนาจเจริญ',
//   'อ่างทอง',
//   'บึงกาฬ',
//   'บุรีรัมย์',
//   'ฉะเชิงเทรา',
//   'ชัยนาท',
//   'ชัยภูมิ',
//   'จันทบุรี',
//   'เชียงใหม่',
//   'เชียงราย',
//   'ชลบุรี',
//   'ชุมพร',
//   'กาฬสินธุ์',
//   'กำแพงเพชร',
//   'กาญจนบุรี',
//   'ขอนแก่น',
//   'กระบี่',
//   'ลำปาง',
//   'ลำพูน',
//   'เลย',
//   'ลพบุรี',
//   'แม่ฮ่องสอน',
//   'มหาสารคาม',
//   'มุกดาหาร',
//   'นครนายก',
//   'นครปฐม',
//   'นครพนม',
//   'นครราชสีมา',
//   'นครสวรรค์',
//   'นครศรีธรรมราช',
//   'น่าน',
//   'นราธิวาส',
//   'หนองบัวลำภู',
//   'หนองคาย',
//   'นนทบุรี',
//   'ปทุมธานี',
//   'ปัตตานี',
//   'พังงา',
//   'พัทลุง',
//   'พะเยา',
//   'เพชรบูรณ์',
//   'เพชรบุรี',
//   'พิจิตร',
//   'พิษณุโลก',
//   'พระนครศรีอยุธยา',
//   'แพร่',
//   'ภูเก็ต',
//   'ปราจีนบุรี',
//   'ประจวบคีรีขันธ์',
//   'ระนอง',
//   'ราชบุรี',
//   'ระยอง',
//   'ร้อยเอ็ด',
//   'สระแก้ว',
//   'สกลนคร',
//   'สมุทรปราการ',
//   'สมุทรสาคร',
//   'สมุทรสงคราม',
//   'สระบุรี',
//   'สตูล',
//   'สิงห์บุรี',
//   'ศรีสะเกษ',
//   'สงขลา',
//   'สุโขทัย',
//   'สุพรรณบุรี',
//   'สุราษฎร์ธานี',
//   'สุรินทร์',
//   'ตาก',
//   'ตรัง',
//   'ตราด',
//   'อุบลราชธานี',
//   'อุดรธานี',
//   'อุทัยธานี',
//   'อุตรดิตถ์',
//   'ยะลา',
//   'ยโสธร',
// ];

const List<String> CATEGORIES = [
  'All Category',
  'Fun Run',
  'Mini Marathon',
  'Half Marathon',
  'Marathon'
];

const List<String> GROUP_CATEGORIES = [
  'Other',
  'Football',
  'Basketball',
  'Volaball',
  'Run',
];

// image assets
const String IMAGES = 'assets/images';
const String SIGNINIMAGE = '$IMAGES/77314-OF1N1Y-610.jpg';
const String FORESTIMAGE = '$IMAGES/forest.jpg';
const String OCEANIMAGE = '$IMAGES/ocean.jpg';
const String RUNIMAGE = '$IMAGES/02046.jpg';

// icon assets
const String ICONS = 'assets/icons';
const String BURNICON = '$ICONS/burn.png';
const String DISTANCEICON = '$ICONS/distance.png';
const String RUNNERICON = '$ICONS/runner.png';
