import 'package:flutter/material.dart';
import 'package:password_app/Pages/Notes.dart';
import 'package:password_app/Pages/PasswordManagerPage.dart';
import 'package:password_app/Widget/CustomCard.dart';
import 'package:password_app/animation/constant.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "MainPage",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: appbar,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomCard(
                data: "password manager",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordPage(),
                    ),
                  );
                },
                icon: Icons.lock_outlined,
                color: card2,
                splashColor: Colors.pink.withAlpha(50),
              ),
              CustomCard(
                data: "Todo",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notes(),
                    ),
                  );
                },
                icon: Icons.note_add_outlined,
                color: greenc,
                splashColor: Colors.blue.withAlpha(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
