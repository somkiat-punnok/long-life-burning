import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/utils/providers/all.dart' show Provider, UserProvider;

class SettingPage extends StatefulWidget {
  SettingPage({ Key key }) : super(key: key);
  static const String routeName = '/setting';
  @override
  _SettingPageState createState() => _SettingPageState();
}
class CrudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }
getData() async {
    return await Firestore.instance.collection('users').snapshots();
  }

void updateData(String selectedDoc, newValues) {
    Firestore.instance
        .collection('users')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}

class _SettingPageState extends State<SettingPage> {
  UserProvider userProvider;
  String name;
  String dateOfBirth;
  String height;
  String weight;
  String gender;
  var users;

  DateTime _date = DateTime(2000, 1, 1);
  CrudMedthods crudObj = new CrudMedthods();
 
 Future<void> updateDialog(BuildContext context) async {
     return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Profile', style: TextStyle(fontSize: 15.0)),
            content: Container(
              child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Name'),
                    onChanged: (value) {
                      this.name = value;
                    },
                  ),
                 Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
                  child: GestureDetector(
                    onTap: () async => await showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => _buildBottomPicker(
                        CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: _date,
                          maximumYear: DateTime.now().year - 1,
                          onDateTimeChanged: (DateTime t) {
                            setState(() {
                              _date = t;
                            });
                          },
                        ),
            title: 'Date of Birth',
            context: context,
          ),
        ),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Text(
                DateFormat.yMMMMd().format(_date),
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.inactiveGray,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Height cm.'),
                    onChanged: (value) {
                      this.height = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Weight kg.'),
                    onChanged: (value) {
                      this.weight = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Gender male/female'),
                    onChanged: (value) {
                      this.gender = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              )
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (this.name != null || this._date != null || this.height != null || this.weight != null || this.gender != null) {
                    crudObj.updateData(userProvider.id, {
                      'name': this.name ?? "Anonymus",
                      'dateOfBirth': this._date ?? DateTime.now(),
                      'height': this.height ?? 170,
                      'weight': this.weight ?? 70,
                      'gender': this.gender ?? "male"
                    });
                  }
                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
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
          'Profile',
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
        floatingActionButton:FloatingActionButton(
                  onPressed: () async => await updateDialog(context),
                  child: new Icon(Icons.edit),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     body: Card(
            elevation: 10.0,
            margin: EdgeInsets.all(15.0),
             child: new Container(
               padding: new EdgeInsets.all(14.0),
               child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
            Text('Name:\t'+(userProvider.name ?? ""), style: TextStyle(fontSize: 20.0),),
             Divider(height: 40.0,),
            new Text('Birth Day:\t'+(userProvider.dateOfBirth?.toString() ?? ""), style: TextStyle(fontSize: 20.0),),
            Divider(height: 40.0,),
            new Text('Gender:\t'+(userProvider.gender?.toString() ?? ""), style: TextStyle(fontSize: 20.0),),
            Divider(height: 40.0,),
            new Text('Height:\t'+(userProvider.height?.toString() ?? ""), style: TextStyle(fontSize: 20.0),),
            Divider(height: 40.0,),
            new Text('Weight:\t'+(userProvider.weight?.toString() ?? ""), style: TextStyle(fontSize: 20.0),),
               ],
              )
             )
           ),
    );
  }
}

 Widget _buildBottomPicker(Widget picker,
      {String title, BuildContext context}) {
    return Container(
      height: SizeConfig.setHeight(268.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DefaultTextStyle(
              style: TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 18.0,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
              ),
              child: GestureDetector(
                onTap: () {},
                child: SafeArea(
                  child: picker,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
