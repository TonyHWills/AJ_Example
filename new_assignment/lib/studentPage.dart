import 'package:new_assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'editStudent.dart';
import 'api.dart';

class studentPage extends StatefulWidget {
  studentPage({super.key, required this.courseName, required this.id});
  final String courseName;
  final String id;

  final CoursesApi api = CoursesApi();

  @override
  State<studentPage> createState() => _studentPageState();
}

class _studentPageState extends State<studentPage> {
  List studentList = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        studentList = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () => {
                                widget.api
                                    .deleteCourses(widget.id)
                                    .then((value) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyHomePage(title: 'Home Page')));
                                })
                              },
                          child: Text("Delete This Course")),
                    ),
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("First Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text("Last Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text("Student ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text("         ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ],
                            ),
                            ...studentList.map<Widget>((student) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(student["fname"],
                                        textAlign: TextAlign.left),
                                    Text(student["lname"],
                                        textAlign: TextAlign.center),
                                    Text(student["studentID"],
                                        textAlign: TextAlign.left),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditStudentClass(
                                                          student["_id"],
                                                          student["fname"],
                                                          widget.courseName,
                                                          widget.id))));
                                        },
                                        child: Text("Edit")),
                                  ],
                                ))
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
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
