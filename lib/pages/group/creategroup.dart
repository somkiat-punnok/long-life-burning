import 'package:flutter/material.dart';
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Constants,
    SizeConfig;
import 'package:long_life_burning/modules/announce/setting/settings.dart';

class CreateGroup extends StatefulWidget {

  CreateGroup({
    Key key,
  }) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  int category = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Group", style: TextStyle(color: Colors.white)),
           actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Index(),
                  )
                ),
              ),
            ],
        ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.setWidth(10.0)),
            child: Center(             
            ),
          ),
        
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 30),
                  child: Text(
                    "GROUP NAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 10.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 0.0, right: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'AVENGER',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),      
           Divider(
            height: 24.0,
          ),  
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "LOCATION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
         
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 10.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 0.0, right: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'เจอกันที่รถเมล์ PKY รอบอ่างหลวง ม.พะเยา',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 30.0,
          ),
          SettingTimePicker(),
          Divider(
            height: 30.0,
          ),
          SettingPicker(
            title: 'Category',
            items: Constants.group_categories,
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
                    onPressed: () => {},
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
      ),
    );
  }
  
}


 