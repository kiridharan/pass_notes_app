import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_app/DB/NoteDBhelper.dart';
import 'package:password_app/animation/constant.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  GlobalKey<FormState> formStateTodo = GlobalKey<FormState>();

  final dbhelperTodo = DatabasehelperDb.instance;
  String cate;
  String head;
  String note;
  var allrowTodo = [];

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
      return "Required Field😐";
    } else {
      return null;
    }
  }

  void insertdataTodo() async {
    Navigator.pop(context);
    Map<String, dynamic> row = {
      DatabasehelperDb.columnHead: head,
      DatabasehelperDb.columnNote: note,
      DatabasehelperDb.columnCat: cate,
    };
    final id = await dbhelperTodo.insert(row);
    print(id);
    setState(() {});
  }

  void deletedataTodo(int id) async {
    dbhelperTodo.deletedata(id);
    setState(() {});
  }

  Future<void> queryallTodo() async {
    allrowTodo = await dbhelperTodo.queryall();
  }

  void addTodo() {
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
                  key: formStateTodo,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Select Category",
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
                          cate = _val;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter YOUR TODO",
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
                            head = _val;
                          },
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Note You Wanna ADD",
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
                          note = _val;
                        },
                        obscureText: false,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            if (formStateTodo.currentState.validate()) {
                              // print("Ready To Enter Data");
                              insertdataTodo();
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
        backgroundColor: appbar,
        title: Text('NOTES'),
        centerTitle: true,
      ),
      backgroundColor: bgcolor,
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: FaIcon(FontAwesomeIcons.plus),
        backgroundColor: appbar,
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData != null) {
            if (allrowTodo.length == 0) {
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
                    itemCount: allrowTodo.length,
                    itemBuilder: (context, index) {
                      return cardTodo(context, index);
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
        future: queryallTodo(),
      ),
    );
  }

  Container cardTodo(BuildContext context, int index) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    allrowTodo[index]['Cate'],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "ubuntumedium",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    deletedataTodo(allrowTodo[index]['id']);
                  }),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                allrowTodo[index]['head'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                allrowTodo[index]['note'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
