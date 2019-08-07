import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

export 'widgets/lib.dart';

class Settings extends StatelessWidget {
  final List<Widget> items;

  Settings({
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.extraLightBackgroundGray,
      child: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return items[index];
          },
        ),
      ),
    );
  }
}
