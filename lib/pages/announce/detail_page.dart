import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
  show
    Firestore,
    DocumentSnapshot,
    DocumentReference,
    CollectionReference;
import 'package:long_life_burning/pages/announce/record_event_page.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Configs,
    SizeConfig,
    showNotification;
import 'package:long_life_burning/modules/announce/event/events.dart' show Event;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider;

class EventDetailPage extends StatefulWidget {
  EventDetailPage({ Key key }) : super(key: key);
  static const String routeName = '/event';
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    final UserProvider provider = Provider.of<UserProvider>(context);
    final DateTime _now = DateTime.now();
    PreferredSizeWidget _appBar = AppBar(
      automaticallyImplyLeading: false,
      brightness: Brightness.dark,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const BackButtonIcon(),
        color: Colors.white,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () async => await Navigator.of(context).popUntil(ModalRoute.withName('/')),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: _appBar.preferredSize.height + SizeConfig.statusBarHeight,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${event.title}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              '${event.subtitle}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: _appBar,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 24.0,
                bottom: 48.0,
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${event.detail}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ((0 < (event?.date?.difference(_now)?.inMinutes ?? 0)) && (provider.user != null)) ? _ButtonWidget(
        user: provider,
        event: event,
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _ButtonWidget extends StatelessWidget {

  final Event event;
  final UserProvider user;
  final ValueChanged<bool> onLoad;

  const _ButtonWidget({
    Key key,
    this.event,
    this.user,
    this.onLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user?.events?.contains(event?.id) ?? false) {
      return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 2.0,
                bottom: 2.0,
              ),
              child: RaisedButton(
                onPressed: () async {
                  final CollectionReference _ref = Firestore.instance
                      .collection(Configs.collection_user)
                      .document(user.id)
                      .collection("events");
                  await showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Cancel join event"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "You\'re sure cancel join this event.",
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text('YES'),
                          onPressed: () async {
                            if (this.onLoad != null) this.onLoad(true);
                            showNotification(
                              action: "cancel",
                              payload: event.id,
                            );
                            final DocumentReference eventRef = Firestore.instance
                                .collection(Configs.collection_event)
                                .document(event.id);
                            final DocumentReference userRef = Firestore.instance
                                .collection(Configs.collection_user)
                                .document(user.id)
                                .collection("events")
                                .document(event.id);
                            final DocumentSnapshot eventDoc = await eventRef.get();
                            if (eventDoc?.exists ?? false) {
                              final Map<String, dynamic> data = eventDoc.data;
                              if (data["users"]?.isEmpty ?? true) data["users"] = [];
                              final List join = List.of(data["users"] ?? []);
                              if (join?.remove(user.user.uid) ?? false) {
                                await eventRef.setData({
                                  "users": join,
                                }, merge: true);
                              }
                            }
                            final DocumentSnapshot userDoc = await userRef.get();
                            if (userDoc?.exists ?? false) {
                              await userRef.delete();
                            }
                            if (this.onLoad != null) this.onLoad(false);
                            await Navigator.of(context).maybePop();
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: Text('NO'),
                          onPressed: () async {
                            await Navigator.of(context).maybePop();
                          },
                        ),
                      ],
                    ),
                  );
                  final List<String> _e = <String>[];
                  await Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  await _ref
                    .getDocuments()
                    .then((snap) async {
                      snap.documents.forEach((d) {
                        if (d.exists) _e.add(d.documentID);
                      });
                      user.events = _e;
                    });
                },
                color: Colors.red,
                child: Text(
                  "cancel join".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 2.0,
                bottom: 2.0,
              ),
              child: OutlineButton(
                color: Colors.green,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    top: 2.0,
                    bottom: 2.0,
                  ),
                  child: Text("record".toUpperCase()),
                ),
                onPressed: () async => await Navigator.of(Configs.index_context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => RecordEventPage(
                      eventId: event.id,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 2.0,
              bottom: 2.0,
            ),
            child: RaisedButton(
              onPressed: () async {
                if (this.onLoad != null) this.onLoad(true);
                showNotification(
                  action: "join",
                  payload: event.id,
                );
                final DocumentReference eventRef = Firestore.instance
                    .collection(Configs.collection_event)
                    .document(event.id);
                final DocumentReference userRef = Firestore.instance
                    .collection(Configs.collection_user)
                    .document(user.id)
                    .collection("events")
                    .document(event.id);
                final CollectionReference _ref = Firestore.instance
                    .collection(Configs.collection_user)
                    .document(user.id)
                    .collection("events");
                final DocumentSnapshot eventDoc = await eventRef.get();
                if (eventDoc.exists) {
                  final Map<String, dynamic> data = eventDoc.data;
                  if (data["users"]?.isEmpty ?? true) data["users"] = [];
                  final List join = List.of(data["users"] ?? []);
                  if (!(join?.contains(user.user.uid) ?? true)) {
                    join.add(user.user.uid);
                    await eventRef.setData({
                      "users": join,
                    }, merge: true);
                  }
                }
                final DocumentSnapshot userDoc = await userRef.get();
                if (!userDoc.exists) {
                  await userRef.setData({
                    "eventId": event.id,
                    "date": DateTime.now(),
                    "duration": {
                      "hour": 0,
                      "minute": 0,
                      "second": 0,
                    },
                    "avgpace": {
                      "hour": 0,
                      "minute": 0,
                      "second": 0,
                    },
                    "calories": 0.0,
                    "distance": 0.0,
                  }, merge: true);
                }
                if (this.onLoad != null) this.onLoad(false);
                final List<String> _e = <String>[];
                await Navigator.of(context).popUntil(ModalRoute.withName('/'));
                await _ref
                  .getDocuments()
                  .then((snap) async {
                    snap.documents.forEach((d) {
                      if (d.exists) _e.add(d.documentID);
                    });
                    user.events = _e;
                  });
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                "join this event".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
