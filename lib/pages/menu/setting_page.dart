// import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:long_life_burning/utils/helper/constants.dart';
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);
  static const String routeName = '/setting';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // static Future<void> _getDataUserFromFirestore(user) async {
  //   CollectionReference ref = Firestore.instance.collection('User');
  //   QuerySnapshot userQuery = await ref
  //   .where(
  //         UserOptions.uid_field,
  //         isEqualTo: user.uid,
  //       )
  //     .getDocuments();

  //   HashMap<String, UserOptions> userHashmap = new HashMap<String, UserOptions>();

  //   userQuery.documents.forEach((document){
  //     userHashmap.putIfAbsent(document['user'],() => UserOptions(
  //       dateOfBirth : document['dateOfBirth'],
  //       gender : document['gender'],
  //       height : document['height'],
  //       weight : document['weight'],
  //       name : document['name'],
  //   )
  //   );
  //   }
  //   );
  //     return userHashmap.values.toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Setting',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Exit',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Setting Page',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
