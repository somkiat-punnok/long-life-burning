import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/announce/record/record.dart';
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    MultiProvider,
    ChangeNotifierProvider,
    UserProvider,
    StepCountProvider,
    StopWatchProvider;

class RecordEventPage extends StatelessWidget {
  RecordEventPage({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StepCountProvider>(
          builder: (_) => StepCountProvider(
            user: user,
          ),
        ),
        ChangeNotifierProvider<StopWatchProvider>(builder: (_) => StopWatchProvider(),),
      ],
      child: RecordEvent(),
    );
  }
}
