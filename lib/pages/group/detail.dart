import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:long_life_burning/utils/providers/all.dart';

class DetailGroup extends StatefulWidget {
  DetailGroup({ Key key }) : super(key: key);
  static const String routeName = '/detail';
  @override
  _DetailGroupState createState() => _DetailGroupState();
}

class Todo {
  final String id;
  final String groupname;
  final String location;
  final String time;
  final String category;
  final String date;
  final List users;

  Todo({ this.id, this.groupname, this.location, this.time, this.category,this.date,this.users });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final Todo data = Todo.fromJson(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      key: scaffoldKey,
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
        actions: (data.users[0] == userProvider.user?.uid ?? 0) ? <Widget>[
          IconButton(
            icon: Icon(Icons.close),
              onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext _) {
                          return AlertDialog(
                            title: Text("Delete group."),
                            content: Text("Will you confirm to delete this group?"),
                            actions: [
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed:  () async => await Navigator.of(_).maybePop(),
                              ),
                              FlatButton(
                                child: Text("Accept"),
                                onPressed: () async {
                                     await Firestore.instance.collection('group').document(data.id).delete().catchError((e){
                                        print(e);
                                     });
                                    await Navigator.of(_).maybePop();
                                    await Navigator.of(context).popUntil(ModalRoute.withName('/'));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                ),
        ] : null,
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
                    new Text('Time: ${data?.time ?? 0}',
                  style: TextStyle(
                    fontSize:15.0),
                    ),
              ]
            ),
             new Text(data?.groupname ?? 0,
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
               new Text('Date : ${data?.date ?? 0}',
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
              Divider(height: 40.0,),
             new Text('Category : '+data?.category ?? 0,
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
              Divider(height: 40.0,),
               new Text('Users join :${data?.users?.length ?? 0} ',
            style: TextStyle(
              fontSize: 15.0
            ),
             ),
            ] 
          )
       )
      ),
      floatingActionButton:FloatingActionButton(
                 onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext _) {
                          return AlertDialog(
                            title: Text("join the group."),
                            content: Text("Will you confirm to join this group?"),
                            actions: [
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed:  () async => await Navigator.of(_).maybePop(),
                              ),
                              FlatButton(
                                child: Text("Accept"),
                                onPressed: () async {
                                  if(!data.users.contains(userProvider.user.uid)){
                                        List _users = data.users.toList();
                                      _users.add(userProvider.user?.uid ?? "join");
                                      await Firestore.instance.collection('group').document(data.id).updateData(
                                        {
                                        "users" :_users,
                                        }
                                      );
                                     await Navigator.of(_).maybePop();
                                    await Navigator.of(context).popUntil(ModalRoute.withName('/'));
                                      }
                                  else{
                                     await Navigator.of(_).maybePop();
                                     scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Your ID have joined.',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.red,
                                          )
                                        );
                                        print("Please choose another group");
                                     }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                  child: new Icon(Icons.check),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
