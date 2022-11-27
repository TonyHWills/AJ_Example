import 'package:new_assignment/studentPage.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditStudentClass extends StatefulWidget {
  final String id, fname;
  final String courseName, courseID;

  final CoursesApi api = CoursesApi();

  EditStudentClass(this.id, this.fname, this.courseName, this.courseID);

  @override
  _EditStudentClassState createState() => _EditStudentClassState();
}

class _EditStudentClassState extends State<EditStudentClass> {
  void _changeStudentName(id, fname) {
    setState(() {
      widget.api.changeFname(id, fname).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => studentPage(
                    courseName: widget.courseName, id: widget.courseID)));
      });
    });
  }

  TextEditingController fnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fname),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  "Enter New Name for " + widget.fname,
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: fnameController,
                ),
                ElevatedButton(
                  onPressed: () => {
                    _changeStudentName(widget.id, fnameController.text),
                  },
                  child: Text("Change First Name"),
                )
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: 'Home Page',
                      ))),
        },
      ),
    );
  }
}
