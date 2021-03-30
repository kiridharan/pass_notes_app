import 'package:flutter/material.dart';
import 'package:password_app/Pages/FingerAuthPage.dart';

import 'package:password_app/Pages/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Passmanager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FingerAuthPage(),
    );
  }
}
