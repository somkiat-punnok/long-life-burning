import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:long_life_burning/modules/announce/event/events.dart' show Event;
import 'package:long_life_burning/modules/announce/feedback/feedback.dart' show FeedBack;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Configs,
    SizeConfig;
// import 'package:long_life_burning/utils/providers/all.dart'
//   show
//     Provider,
//     UserProvider;

class EventDetailPage extends StatefulWidget {
  EventDetailPage({ Key key }) : super(key: key);
  static const String routeName = '/event';
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  num _rating;
  String _comment;
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    // final UserProvider provider = Provider.of<UserProvider>(context);
    PreferredSizeWidget _appBar = AppBar(
      automaticallyImplyLeading: false,
      brightness: Brightness.dark,
      backgroundColor: Colors.transparent,
      leading: BackButton(),
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
                    decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: _appBar.preferredSize.height + SizeConfig.statusBarHeight),
                          Icon(
                            Icons.directions_car,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          Container(
                            width: 90.0,
                            child: Divider(color: Colors.green),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '${event.title}',
                            style: TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                          Text(
                            '${event.subtitle}',
                            style: TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
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
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${event.detail}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      width: SizeConfig.screenWidth,
                      child: RaisedButton(
                        onPressed: () => _showDialog(event.id),
                        // provider.user != null ? () async {
                        //   final DocumentReference eventRef = Firestore.instance
                        //       .collection(Configs.collection_event)
                        //       .document(event.id);
                        //   final DocumentReference userRef = Firestore.instance
                        //       .collection(Configs.collection_user)
                        //       .document(provider.id)
                        //       .collection("events")
                        //       .document(event.id);
                        //   final DocumentSnapshot doc = await eventRef.get();
                        //   final Map<String, dynamic> data = doc.data;
                        //   if (data["users"]?.isEmpty ?? true) data["users"] = [];
                        //   final List join = data["users"];
                        //   if (!join.contains(provider.user.uid)) join.add(provider.user.uid);
                        //   await eventRef.setData({
                        //     "users": join,
                        //   }, merge: true);
                        //   await userRef.setData({
                        //     "eventId": event.id,
                        //     "date": DateTime.now(),
                        //     "step": 0,
                        //     "calories": 0.0,
                        //     "distance": 0.0,
                        //   }, merge: true);
                        //   await Navigator.of(context).popUntil(ModalRoute.withName('/'));
                        // } : () async => await Navigator.of(context).popUntil(ModalRoute.withName('/')),
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        child: Text(
                          "TAKE THIS LESSON",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String eventId) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => FeedBack(
        title: "Feedback",
        subtitle: "Please send feedback",
        onRating: (double rate) => _rating = rate,
        onComment: (String message) => _comment = message,
        onSend: () async {
          final DocumentReference eventRef = Firestore.instance
              .collection(Configs.collection_event)
              .document(eventId);
          await eventRef.collection("feedback").add({
            "date": DateTime.now(),
            "rate": _rating ?? 0,
            "comment": _comment ?? "",
          });
          await Navigator.of(context).maybePop();
        },
        onCancel: () async => await Navigator.of(context).maybePop(),
      ),
    );
  }
}
