import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/announce/event/events.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/nearby/nearby.dart'
  show
    MapView,
    Marker,
    MarkerId,
    InfoWindow,
    BitmapDescriptor;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider,
    EventProvider;

class CheckPointPage extends StatefulWidget {
  CheckPointPage({ Key key }) : super(key: key);
  static const String routeName = '/marking';
  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            markers: Set<Marker>.of(_buildMarker(context)),
            mapToolbarEnabled: false,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            top: SizeConfig.statusBarHeight,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Text(
                "Check Point",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 16.0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 8.0,
            top: SizeConfig.statusBarHeight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () async => await Navigator.of(context).maybePop(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Marker> _buildMarker(BuildContext context) {
    final EventProvider _event = Provider.of<EventProvider>(context);
    final UserProvider _user = Provider.of<UserProvider>(context);
    final List<Event> _mark = _event.events.where((e) => _user.events.contains(e.id)).toList();
    return Iterable<Marker>.generate(_mark.length, (i) => Marker(
        markerId: MarkerId("mark-${i+1}"),
        position: _mark[i].location,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: _mark[i].title,
          snippet: _mark[i].subtitle,
        ),
      ),
    );
  }
}
