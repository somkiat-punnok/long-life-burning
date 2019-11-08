import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'
  show
    CupertinoColors,
    DefaultCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
  show
    GlobalMaterialLocalizations,
    GlobalCupertinoLocalizations,
    GlobalWidgetsLocalizations;
import 'package:cloud_firestore/cloud_firestore.dart'
  show
    Firestore,
    QuerySnapshot;
import 'package:firebase_auth/firebase_auth.dart'
  show
    FirebaseAuth,
    FirebaseUser;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    APPNAME,
    Configs,
    isMaterial;
import 'package:long_life_burning/utils/providers/all.dart';

import './index.dart';

class App extends StatelessWidget {
  App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingProvider>(builder: (_) => SettingProvider(),),
        ChangeNotifierProvider<NavBarProvider>(builder: (_) => NavBarProvider(),),
        ChangeNotifierProvider<UserProvider>(builder: (_) => UserProvider(),),
        FutureProvider<SharedPreferences>(
          builder: (_) async => await SharedPreferences.getInstance(),
          catchError: (_, err) {
            print(err);
            return null;
          },
        ),
        StreamProvider<QuerySnapshot>(
          builder: (_) => Firestore.instance
            .collection(Configs.collection_event)
            .orderBy("date", descending: true)
            .snapshots(),
          catchError: (_, err) {
            print(err);
            return null;
          },
        ),
        StreamProvider<FirebaseUser>(
          builder: (_) => FirebaseAuth.instance.currentUser().asStream(),
          catchError: (_, err) {
            print(err);
            return null;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APPNAME,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
          disabledColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
          dividerColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
          textTheme: TextTheme(
            display1: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
            ),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
          ),
        ),
        home: Index(),
        localizationsDelegates: <LocalizationsDelegate>[
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: <Locale>[
          Locale("en", "US"),
        ],
      ),
    );
  }
}
