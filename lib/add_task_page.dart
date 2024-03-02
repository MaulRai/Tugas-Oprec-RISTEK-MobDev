import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';


@HiveType(typeId: 0)
class DataToDo extends HiveObject {
  @HiveField(0)
  String todos = "";

  @HiveField(1)
  String startDateFormatted = "";

  @HiveField(2)
  String endDateFormatted = "";

  @HiveField(3)
  bool isCompleted = false;

  @HiveField(4)
  bool isPriority = false;

  @HiveField(5)
  String desc = "";
  
  DataToDo(this.todos, this.startDateFormatted, this.endDateFormatted, this.isCompleted,
      this.isPriority, this.desc);
}

// class DataToDo {
//   String todos = "";
//   DateTime startDate = DateTime.now();
//   DateTime endDate = DateTime.now();
//   bool isCompleted = false;
//   bool isPriority = false;
//   String desc = "";

//   DataToDo(this.todos, this.startDate, this.endDate, this.isCompleted,
//       this.isPriority, this.desc);
// }

class TaskPage extends StatefulWidget {
  final VoidCallback onTaskAdded; // Define a callback
  
  const TaskPage({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final List<DataToDo> boxList;

  _TaskPageState() {
    boxList = Hive.box('toDoDataBase').values.toList().cast<DataToDo>();
  }
  
  // final _myBox = Hive.box('toDoDataBase');
  DateTime? startTime;
  DateTime? endTime;
  String newTodo = "";
  String newDesc = "";
  bool isPriority = false;

  void _showStartDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        startTime = value!;
      });
    });
  }

  void _showEndDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        endTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add task"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade500,
                Colors.purple.shade300,
                Colors.purple.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade100,
              Colors.green.shade100,
              Colors.blue.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Text(startTime.toString())
                Expanded(child: Text("Start:", style: TextStyle(fontFamily: 'Anta'))),
                Expanded(child: Text("Ends:", style: TextStyle(fontFamily: 'Anta')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: _showStartDate,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2)
                              .withOpacity(0.8) // Background color with opacity
                          ),
                      child: Text(
                        startTime == null
                            ? 'Choose date'
                            : DateFormat('EEE d MMM, yyyy').format(startTime!),
                        style: TextStyle(fontFamily: 'Anta'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: _showEndDate,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2)
                              .withOpacity(0.8) // Background color with opacity
                          ),
                      child: Text(
                        endTime == null
                            ? 'Choose date'
                            : DateFormat('EEE d MMM, yyyy').format(endTime!),
                        style: TextStyle(fontFamily: 'Anta'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("Title", style: TextStyle(fontFamily: 'Anta'))),
              ],
            ),
            TextField(
              onChanged: (value) {
                newTodo = value;
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Category", style: TextStyle(fontFamily: 'Anta'))),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: () => setState(() => isPriority = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isPriority ? Colors.purpleAccent : Colors.transparent,
                      ),
                      child: const Text(
                        "Priority Task",
                        style: TextStyle(color: Colors.white, fontFamily: 'Anta'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
                    child: ElevatedButton(
                      onPressed: () => setState(() => isPriority = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isPriority ? Colors.transparent : Colors.purpleAccent,
                      ),
                      child: const Text(
                        "Daily Task",
                        style: TextStyle(color: Colors.white, fontFamily: 'Anta'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Description", style: TextStyle(fontFamily: 'Anta') )),
                ],
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                  textAlignVertical: TextAlignVertical.top,
                  scrollPadding: EdgeInsets.only(bottom: 40),
                  autofocus: true,
                  onChanged: (value) {
                    newDesc = value;
                  },
                  expands: true,
                  maxLines: null,
                  placeholder: "Add description",
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)
                          )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: ElevatedButton(
                onPressed: () {
                  if (startTime == null || endTime == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Date invalid"),
                          content:
                              Text("Please choose start date and end date"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (endTime!.difference(startTime!).inDays < 0 ||
                      endTime!.difference(DateTime.now()).inDays < 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Date invalid"),
                          content: Text(
                              "End date cannot be the day before today or the start date"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (newTodo == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Task title input invalid"),
                          content: Text("Please input the task title"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    setState(() {
                      if (newTodo.isNotEmpty) {
                        boxList.add(DataToDo(newTodo,
                            DateFormat('EEE d MMM, yyyy').format(startTime!), DateFormat('EEE d MMM, yyyy').format(endTime!), false, isPriority, newDesc));
                        // _myBox.put('listToDo', TodoListScreen.listToDo);

                        widget.onTaskAdded(); // Call the callback function
                      }
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purpleAccent, // This is what you need!
                ),
                child: const Text(
                  "Create Task",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800, fontFamily: 'Anta'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
