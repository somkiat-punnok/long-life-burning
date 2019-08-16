import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {

  final String name;
  final String unit;
  final String value;
  final void Function() onClick;

  RecordCard({
    Key key,
    @required this.name,
    @required this.unit,
    @required this.value,
    this.onClick,
  }) :  assert(name != null && name != ''),
        assert(unit != null && unit != ''),
        assert(value != null && value != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(
          name.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          value + ' ' + unit,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        onTap: onClick ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}