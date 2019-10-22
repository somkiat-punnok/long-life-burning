
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:long_life_burning/utils/helper/constants.dart' show UserOptions;

import './create_group.dart';
import './detail.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key}) : super(key: key);
  static const String routeName = '/';
  @override
  _GroupPageState createState() => _GroupPageState();
}

class MyData {
  String groupname, location, time , category;
  Animation animation;
  AnimationController controller;
  final GlobalKey<dynamic> key = GlobalKey();
  int state = 0;
  bool isPressed = false, animatingReveal = false;
  MyData(this.groupname, this.location, this.time, this.category);
}
    
class _GroupPageState extends State<GroupPage> {
      List<MyData> allData = [];

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Group',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () =>
                    Navigator.of(context).pushNamed(CreateGroup.routeName),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: FirebaseDatabase.instance.reference().child("GROUP").once().asStream(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var KEYS = snapshot.data?.value?.keys;
              if (KEYS == null) return Container();
              var DATA = snapshot.data?.value;
              allData.clear();
              for(var individualKey in KEYS)
              {
                MyData data = new MyData(
                  DATA[individualKey]['groupname'],
                  DATA[individualKey]['location'],
                  DATA[individualKey]['time'],
                  DATA[individualKey]['category'],
                );
                allData.add(data);
              }
              return allData.length == 0 ? new Text("No Data available") : new ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index)
                {
                  return ListData(
                    data: allData[index],
                    contexts: context,
                  );
                }
              );
            },
          ),
          );
      }
}

class ListData extends StatefulWidget {
  final MyData data;
  final BuildContext contexts;
  ListData({
    this.data,
    this.contexts,
  });
  @override
  _ListDataState createState() => _ListDataState();
  void callback() {}
}

class _ListDataState extends State<ListData> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  new Text
            (widget.data.groupname ?? "",style: Theme.of(context).textTheme.subtitle,
            textAlign:TextAlign.center,
            ),
            new Text
            (widget.data.time ?? "",style: Theme.of(context).textTheme.subtitle,
            textAlign:TextAlign.center,
            ),
            IconButton(
            icon: Icon(Icons.list,
            color: Colors.red,
            ),
            onPressed:() => Navigator.of(widget.contexts).pushNamed(
              DetailGroup.routeName,
              arguments: {
                "groupname": widget.data.groupname,
                "category": widget.data.category,
                "location": widget.data.location,
                "time": widget.data.time,
              }),
            ),
                RaisedButton(
                  elevation: 4.0,
                  child: buildButtonChild(),
                  key: widget.data.key,
                  color: widget.data.state == 2 ? Colors.green : Colors.grey,
                  onPressed: (){
                    DatabaseReference groupRef = FirebaseDatabase.instance.reference().child("GROUP");
                    groupRef.child("id").child("users").push().set({
                      UserOptions.user.uid:UserOptions.user.uid
                    });
                  },
                  onHighlightChanged: (isPressed){
                    setState(() {
                      widget.data.isPressed = isPressed;
                      if (widget.data.state == 0) {
                        animateButton();
                      }
                    });
                  }
              ),
              ],
            ),
            SizedBox(height: 10.0,),
                new Text
            (widget.data.category ?? "",style: Theme.of(context).textTheme.subtitle,
            textAlign:TextAlign.start,
            ),
            new Text
              (widget.data.location ?? "",style: Theme.of(context).textTheme.subtitle,
            textAlign:TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void animateButton() {
    double initialWidth = widget.data.key.currentContext.size.width;
    widget.data.controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    widget.data.animation = Tween(begin: 0.0, end: 1.0).animate(widget.data.controller)
    ..addListener((){
      setState((){
        initialWidth = ((initialWidth - 48.0) * widget.data.animation.value);
      });
    });

    widget.data.controller.forward();

    setState(() {
      widget.data.state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        widget.data.state = 2;
      });
      widget.data.controller.dispose();
    });

    Timer(Duration(milliseconds: 3600), () {
      widget.data.animatingReveal = true;
      widget.callback();
    });
  }

Widget buildButtonChild() {
if (widget.data.state == 1) {
return SizedBox(
  height: 30.0,
  width: 30.0,
  child: CircularProgressIndicator(
    value: null,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ),
);
} else if (widget.data.state == 2) {
return Icon(Icons.check, color: Colors.white);
} else {
return Text(
  'join',
  style: TextStyle(color: Colors.white, fontSize: 16.0),
);
}
}
double calculateElevation(MyData data) {
if (data.animatingReveal) {
return 0.0;
} else {
return data.isPressed ? 6.0 : 4.0;
}
}

void reset(MyData data) {
double.infinity;
data.animatingReveal = false;
data.state = 0;
}
}



