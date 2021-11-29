import 'package:flutter/material.dart';

import 'CallApiTimerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINE RMX Official Timer Tools',
      initialRoute: '/timer',
      routes: {
        '/timer': (context) => CallApiTimerScreen(),
      },
    );
  }
}
