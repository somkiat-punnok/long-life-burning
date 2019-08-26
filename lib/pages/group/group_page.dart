import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Group',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[

               Icon(                 
                  Icons.search,
                  color: Colors.white,
                  size: 30.0,
                ),
                
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('Name event'),
                        subtitle: Text('Detail event'),
                      ),
                      ButtonTheme.bar( 
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Join'),
                              onPressed: () { /* ... */ },
                            ),
                            FlatButton(
                              child: const Text('close'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('Name event'),
                        subtitle: Text('Detail event'),
                      ),
                      ButtonTheme.bar( 
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Join'),
                              onPressed: () { /* ... */ },
                            ),
                            FlatButton(
                              child: const Text('close'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('Name event'),
                        subtitle: Text('Detail event'),
                      ),
                      ButtonTheme.bar( 
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Join'),
                              onPressed: () { /* ... */ },
                            ),
                            FlatButton(
                              child: const Text('close'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('Name event'),
                        subtitle: Text('Detail event'),
                      ),
                      ButtonTheme.bar( 
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Join'),
                              onPressed: () { /* ... */ },
                            ),
                            FlatButton(
                              child: const Text('close'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('Name event'),
                        subtitle: Text('Detail event'),
                      ),
                      ButtonTheme.bar( 
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Join'),
                              onPressed: () { /* ... */ },
                            ),
                            FlatButton(
                              child: const Text('close'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 150.0,
              bottom: 10.0,
              child: CupertinoButton(
                color: Colors.blueGrey,
                disabledColor: Colors.grey,
                padding: EdgeInsets.all(8.0),
                onPressed: () =>gotoCreate(),
                child: Text(
                  "Create group",
                  style: TextStyle(fontSize: 15.0),                                   
                ),
              ),
            ),      
          ],          
        ),
      ),
    );
  }

}

gotoCreate() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
   PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);