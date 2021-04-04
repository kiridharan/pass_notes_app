import 'package:flutter/material.dart';
import 'package:password_app/DB/dbhelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_app/animation/constant.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final dbhelper = Databasehelper.instance;
  String type;
  String user;
  String pass;
  var allrows = [];
  bool _secureText = true;
  bool _text = true;

  TextStyle titlestyle = TextStyle(
    fontSize: 18.0,
    fontFamily: "ubuntu",
    color: Colors.white,
  );

  TextStyle subtitlestyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "ubuntu",
    color: Colors.white70,
  );

  String validateempty(_val) {
    if (_val.isEmpty) {
      return "REQUIRED FIELD😎";
    } else {
      return null;
    }
  }

  void insertdata() async {
    Navigator.pop(context);
    Map<String, dynamic> row = {
      Databasehelper.columntype: type,
      Databasehelper.columnUser: user,
      Databasehelper.columnPass: pass,
    };
    final id = await dbhelper.insert(row);
    print(id);
    setState(() {});
  }

  // void updatedata() async {
  //   Navigator.pop(context);
  //   Map<String, dynamic> row = {
  //     Databasehelper.columntype: type,
  //     Databasehelper.columnUser: user,
  //     Databasehelper.columnPass: pass,
  //   };
  //   final id = await dbhelper.update(row);
  //   print(id);
  //   setState(() {});
  // }

  void deleltedata(int id) async {
    dbhelper.deletedata(id);
    setState(() {});
  }

  Future<void> queryall() async {
    allrows = await dbhelper.queryall();
    // allrows.forEach((row) {
    //   print(row);
    // });
    // print(allrows);
  }

  void addpassword() {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: greenc,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              title: Text(
                "Add Data",
                style: titlestyle,
              ),
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formstate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Select Type",
                          labelStyle: subtitlestyle,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        style: titlestyle,
                        validator: validateempty,
                        onChanged: (_val) {
                          type = _val;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Username/Email",
                            labelStyle: subtitlestyle,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          style: titlestyle,
                          validator: validateempty,
                          onChanged: (_val) {
                            user = _val;
                          },
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _secureText
                                  ? Icons.remove_red_eye
                                  : Icons.security_rounded,
                            ),
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
                          labelText: "Enter Password",
                          labelStyle: subtitlestyle,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        style: titlestyle,
                        validator: validateempty,
                        onChanged: (_val) {
                          pass = _val;
                        },
                        obscureText: _secureText,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            if (formstate.currentState.validate()) {
                              // print("Ready To Enter Data");
                              insertdata();
                            }
                          },
                          child: Text(
                            "ADD",
                            style: titlestyle,
                          ),
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: 35.0,
                            vertical: 10.0,
                          ),
                          elevation: 5.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Saved Passwords",
          style: TextStyle(
            fontFamily: "ubuntumedium",
          ),
        ),
        backgroundColor: appbar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addpassword,
        child: FaIcon(FontAwesomeIcons.plus),
        backgroundColor: appbar,
      ),
      backgroundColor: bgcolor,
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData != null) {
            if (allrows.length == 0) {
              return Center(
                child: Text(
                  "No Data Availabe 😶😥\nClick On The Add Button To Enter Some !",
                  style: TextStyle(
                    color: appbar,
                    fontSize: 25.0,
                    fontFamily: "ubuntumedium",
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Center(
                child: Container(
                  decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: ListView.builder(
                    itemCount: allrows.length,
                    itemBuilder: (context, index) {
                      return card(context, index);
                    },
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: queryall(),
      ),
    );
  }

  passCheck(String dataPass, bool b, int index) {
    setState(() {
      _text = !_text;
    });
    if (_text == true) {
      return pass = "${allrows[index]['pass']}";
      // print("${allrows[index]['pass']}");
    } else
      return pass = '${allrows[index]['pass'].replaceAll(RegExp(r"."), "*")}';
    //  ? print('${allrows[index]['pass'].replaceAll(RegExp(r"."), "*")}');
  }

  @override
  void initState() {
    super.initState();
  }

  Container card(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
      ),
      decoration: BoxDecoration(
        color: card2,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    allrows[index]['type'].toString().toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontFamily: "ubuntumedium",
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    deleltedata(allrows[index]['id']);
                  }),
              IconButton(
                  icon: Icon(
                    _text ? FontAwesomeIcons.eye : Icons.security_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      passCheck(allrows[index]['pass'], _text, index);
                    });
                  })
            ],
          ),
          Container(
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.userSecret,
                size: 40.0,
                color: Colors.white,
              ),
              title: Text(
                allrows[index]['user'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appbar,
                ),
              ),
              subtitle: Text(
                // allrows[index]['pass'],
                // _text == true
                //     ? allrows[index]['pass']
                //     : '${allrows[index]['pass'].replaceAll(RegExp(r"."), "*")}',
                pass == null || _text == true
                    ? '${allrows[index]['pass'].replaceAll(RegExp(r"."), "*")}'
                    : allrows[index]['pass'],
                style: subtitlestyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
