
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/utils/providers/all.dart' show Provider, UserProvider;
import 'package:long_life_burning/utils/helper/constants.dart'
    show GROUP_CATEGORIES, SizeConfig;
import 'package:long_life_burning/modules/announce/setting/settings.dart';
import 'package:long_life_burning/utils/helper/constants.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({ Key key }) : super(key: key);
  static const String routeName = '/create';
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  int category = 0;
  DateTime time = DateTime.now();
  UserProvider userProvider;
  GlobalKey<FormState> _key = new GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String groupname;
  String location;
  DateTime _date = DateTime.now();

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      CollectionReference ref = Firestore.instance.collection('group');
      var data = {
        "groupname": groupname,
        "location": location,
        "category": GROUP_CATEGORIES[category],
        "date":_date,
        "time": "${time.hour}:${time.minute}",
        "users": [
          userProvider.user?.uid ?? "",
        ],
      };
      ref.add(data).then((v) {
        _key.currentState.reset();
        Navigator.of(context).maybePop();
      });
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  String validateGroupName(String val) {
    return val.length == 0 ? "Enter Name First" : null;
  }

  String validateLocation(String val) {
    return val.length == 0 ? "Enter Location First" : null;
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Create Group",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              color: Colors.white,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.setWidth(10.0)),
            child: Center(),
          ),
          Divider(
            height: 30.0,
          ),
          SingleChildScrollView(
            child: new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Form(
                key: _key,
                autovalidate: _autovalidate,
                child: FormUI(),
              ),
            ),
          ),
        ]));
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                decoration: new InputDecoration(hintText: 'Groupname'),
                validator: validateGroupName,
                onSaved: (val) {
                  groupname = val;
                },
                maxLength: 32,
              ),
            ),
          ],
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Location and Comment'),
          onSaved: (val) {
            location = val;
          },
          validator: validateLocation,
          maxLines: 5,
          maxLength: 256,
        ),
        DatePicker(
          title: 'Date',
          currentDate: _date,
          onSelect: (DateTime t) {
            setState(() {
              _date = t;
            });
          },
        ),
        Divider(
          height: 30.0,
        ),
        TimePicker(
          title: 'Time',
          currentTime: time,
          onSelect: (DateTime t) {
            setState(() {
              time = t;
            });
          },
        ),
        Divider(
          height: 30.0,
        ),
        CusttomPicker(
          title: 'Category',
          items: GROUP_CATEGORIES,
          currentIndex: category,
          onSelect: (int i) {
            setState(() {
              category = i;
            });
          },
        ),
        Divider(
          height: 30.0,
        ),
        Container(
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.blue,
                  onPressed: _sendToServer,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Create",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
