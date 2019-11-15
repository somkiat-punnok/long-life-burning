import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show Configs;
import 'package:cloud_firestore/cloud_firestore.dart'
  show
    Firestore,
    QuerySnapshot;
import 'package:long_life_burning/modules/notify/notify.dart'
  show
    Notify,
    NotifyWidget;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider;

class NotifyPage extends StatefulWidget {
  NotifyPage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
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
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: provider?.id != null ? Firestore.instance?.collection(Configs.collection_user)?.document(provider?.id ?? "")?.collection("notifications")?.snapshots() : null,
        builder: (context, snapshot) {
          final List<Notify> _notify = <Notify>[];
          if (!snapshot.hasData) {
            return NotifyWidget(
              notify: <Notify>[],
            );
          }
          snapshot.data.documents.forEach((doc) async {
            if (doc?.exists ?? false) {
              _notify.add(Notify.fromMap(doc.data));
            }
          });
          return NotifyWidget(
            notify: _notify ?? <Notify>[],
          );
        }
      ),
    );
  }
}
