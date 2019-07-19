import 'package:flutter/material.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';
import 'package:long_life_burning/modules/nearby/nearby.dart';
import 'package:long_life_burning/modules/nearby/map.dart';

class NearbyPage extends StatefulWidget {
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with TickerProviderStateMixin {

  final double _panelHeightClosed = 200.0;
  final double _initRadius = 20.0;
  double _radius;

  @override
  Widget build(BuildContext context) {

    final double _panelHeightOpen = MediaQuery.of(context).size.height;
    final double _initFabHeight = _panelHeightClosed + _initRadius;

    List<Widget> bodyStack = [
      MapView(),
      Positioned(
        right: 20.0,
        bottom: _initFabHeight,
        child: FloatingActionButton(
          child: Icon(
            Icons.gps_fixed,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
          backgroundColor: Colors.white,
        ),
      ),
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: PlatformAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          android: (_) => MaterialAppBarData(
            brightness: Brightness.light,
            elevation: 0.0,
          ),
          ios: (_) => CupertinoNavigationBarData(
            actionsForegroundColor: Colors.transparent,
            border: Border.all(
              color: Colors.transparent,
              width: 0.0,
              style: BorderStyle.none
            ),
          ),
        ),
      ),
      Positioned(
        top: 42.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          child: Text(
            "SlidingUpPanel",
            style: TextStyle(
              fontWeight: FontWeight.w500
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 16.0
              ),
            ],
          ),
        ),
      ),
      SlidePanel(
        panelHeightOpen: _panelHeightOpen,
        panelHeightClosed: _panelHeightClosed,
        radius: _radius ?? _initRadius,
        onPanelSlide: (value) {
          setState(() {
            _radius = _initRadius * (1 - value);
          });
        },
      ),
    ];

    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
      ),
      ios: (_) => CupertinoPageScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomInsetTab: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: bodyStack,
      ),
    );
    
  }

}
