import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:long_life_burning/pages/all.dart';
// import 'package:long_life_burning/utils/helper/constants.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);
  static const String routeName = '/setting';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

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
       child:Padding(
         padding: const EdgeInsets.all(15.0),
       child: Material(
         elevation: 7.0,
         borderRadius: BorderRadius.circular(15.0),
         child: Container(
           height: 500.0,
           padding: EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Text('Proflie',
               style: TextStyle(
                 fontSize: 20.0
               ),
               ),
               SizedBox(height: 10.0),
               Container(
                 height: 0.5,
                 width: double.infinity,
                 color: Colors.black,
               ),
               SizedBox(
                 height: 15.0,
               ),
               Text('data',
               style: TextStyle(fontSize: 15.0),
               ),
               SizedBox(height: 45.0,),
             ],
           ),
         ),
       ),
       )
       ),
    );
  }
}
