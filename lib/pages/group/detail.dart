import 'package:flutter/material.dart';

class DetailGroup extends StatefulWidget {
  DetailGroup({ Key key }) : super(key: key);
  static const String routeName = '/detail';
  @override
  _DetailGroupState createState() => _DetailGroupState();
}

class Todo {
  final String groupname;
  final String location;
  final String time;
  final String category;
  final String date;
  final String users;

  Todo( {this.groupname, this.location, this.time, this.category,this.date,this.users});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      groupname: json['groupname'],
      category: json['category'],
      location: json['location'],
      time: json['time'],
      date: json['date'],
      users: json['users'],
    );
  }
}
class _DetailGroupState extends State<DetailGroup> {

  @override
  Widget build(BuildContext context) {
    final Todo data = Todo.fromJson(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
       body: Card( 
        elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
               mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                    new Text('Time: ${data.time}',
                  style: TextStyle(
                    fontSize:15.0),
                    ),
              ]
            ),
             new Text(data.groupname,
                  style: TextStyle(
                    fontSize:30.0),
                    ),
                    Divider(height: 40.0,),
            new Text(data.location,
            style: TextStyle(
              fontSize: 17.0
            ),
            ),
             Divider(height: 40.0,),
               new Text('Date : ${data.date}',
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
              Divider(height: 40.0,),
             new Text('Category : '+data.category,
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
              Divider(height: 40.0,),
               new Text('Users join :${data.users} ',
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
            ] 
          )
       )
      )
    );
  }
}
