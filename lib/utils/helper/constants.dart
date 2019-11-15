library constant;

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import '../widgets/platform.dart' show isMaterial;
import '../providers/all.dart'
  show
    UserProvider,
    EventRecordUser;

export '../widgets/platform.dart';
export '../widgets/size_config.dart';

part './enums.dart';
part './fonts.dart';
part './functions.dart';
part './icons.dart';
part './options.dart';

const String APPNAME = 'Long Burn';

// Key AIzaSyApxB8Xjrg0m-ayriRwcXQpNVz0ONsXlGE
String Map_API_Key = isMaterial ? 'AIzaSyCngcsFoAznocj_aRI9CRwdtE6_gRAINGc' : 'AIzaSyApxB8Xjrg0m-ayriRwcXQpNVz0ONsXlGE';

const String Prefix_KEY = 'long_burn_';

const Map<String, String> MAP_PROVINCE = {
  '': '',
  'All Province': '',
  'Bangkok': 'กรุงเทพมหานคร',
  'Amnat Charoen': 'อำนาจเจริญ',
  'Ang Thong': 'อ่างทอง',
  'Bueng Kan': 'บึงกาฬ',
  'Buriram': 'บุรีรัมย์',
  'Chachoengsao': 'ฉะเชิงเทรา',
  'Chai Nat': 'ชัยนาท',
  'Chaiyaphum': 'ชัยภูมิ',
  'Chanthaburi': 'จันทบุรี',
  'Chiang Mai': 'เชียงใหม่',
  'Chiang Rai': 'เชียงราย',
  'Chonburi': 'ชลบุรี',
  'Chumphon': 'ชุมพร',
  'Kalasin': 'กาฬสินธุ์',
  'Kamphaeng Phet': 'กำแพงเพชร',
  'Kanchanaburi': 'กาญจนบุรี',
  'Khon Kaen': 'ขอนแก่น',
  'Krabi': 'กระบี่',
  'Lampang': 'ลำปาง',
  'Lamphun': 'ลำพูน',
  'Loei': 'เลย',
  'Lopburi': 'ลพบุรี',
  'Mae Hong Son': 'แม่ฮ่องสอน',
  'Maha Sarakham': 'มหาสารคาม',
  'Mukdahan': 'มุกดาหาร',
  'Nakhon Nayok': 'นครนายก',
  'Nakhon Pathom': 'นครปฐม',
  'Nakhon Phanom': 'นครพนม',
  'Nakhon Ratchasima': 'นครราชสีมา',
  'Nakhon Sawan': 'นครสวรรค์',
  'Nakhon Si Thammarat': 'นครศรีธรรมราช',
  'Nan': 'น่าน',
  'Narathiwat': 'นราธิวาส',
  'Nong Bua Lamphu': 'หนองบัวลำภู',
  'Nong Khai': 'หนองคาย',
  'Nonthaburi': 'นนทบุรี',
  'Pathum Thani': 'ปทุมธานี',
  'Pattani': 'ปัตตานี',
  'Phang Nga': 'พังงา',
  'Phatthalung': 'พัทลุง',
  'Phayao': 'พะเยา',
  'Phetchabun': 'เพชรบูรณ์',
  'Phetchaburi': 'เพชรบุรี',
  'Phichit': 'พิจิตร',
  'Phitsanulok': 'พิษณุโลก',
  'Phra Nakhon Si Ayutthaya': 'พระนครศรีอยุธยา',
  'Phrae': 'แพร่',
  'Phuket': 'ภูเก็ต',
  'Prachinburi': 'ปราจีนบุรี',
  'Prachuap Khiri Khan': 'ประจวบคีรีขันธ์',
  'Ranong': 'ระนอง',
  'Ratchaburi': 'ราชบุรี',
  'Rayong': 'ระยอง',
  'Roi Et': 'ร้อยเอ็ด',
  'Sa Kaeo': 'สระแก้ว',
  'Sakon Nakhon': 'สกลนคร',
  'Samut Prakan': 'สมุทรปราการ',
  'Samut Sakhon': 'สมุทรสาคร',
  'Samut Songkhram': 'สมุทรสงคราม',
  'Saraburi': 'สระบุรี',
  'Satun': 'สตูล',
  'Sing Buri': 'สิงห์บุรี',
  'Sisaket': 'ศรีสะเกษ',
  'Songkhla': 'สงขลา',
  'Sukhothai': 'สุโขทัย',
  'Suphan Buri': 'สุพรรณบุรี',
  'Surat Thani': 'สุราษฎร์ธานี',
  'Surin': 'สุรินทร์',
  'Tak': 'ตาก',
  'Trang': 'ตรัง',
  'Trat': 'ตราด',
  'Ubon Ratchathani': 'อุบลราชธานี',
  'Udon Thani': 'อุดรธานี',
  'Uthai Thani': 'อุทัยธานี',
  'Uttaradit': 'อุตรดิตถ์',
  'Yala': 'ยะลา',
  'Yasothon': 'ยโสธร',
};

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

const Map<String, String> MAP_CATEGORIES = {
  '': '',
  'All Category': '',
  'Fun Run': 'funrun',
  'Mini Marathon': 'minimarathon',
  'Half Marathon': 'halfmarathon',
  'Marathon': 'marathon',
};

const List<String> CATEGORIES = [
  'All Category',
  'Fun Run',
  'Mini Marathon',
  'Half Marathon',
  'Marathon',
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
