import 'package:flutter/material.dart';
import 'package:password_app/animation/constant.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text('NOTES'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NOTES',
        ),
      ),
    );
  }
}
