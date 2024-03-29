import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';


class EditPage extends StatefulWidget {
  final int index;
  final VoidCallback onTaskAdded;

  const EditPage({Key? key, required this.index, required this.onTaskAdded})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _myBox = Hive.box('userDataBase');
  @override
  Widget build(BuildContext context) {
    // DateTime startTimeTemp = TodoListScreen.listToDo[widget.index].startDate;
    // DateTime endTimeTemp = TodoListScreen.listToDo[widget.index].endDate;
    // String initialToDoTitle = TodoListScreen.listToDo[widget.index].todos;
    // String initialDesc = TodoListScreen.listToDo[widget.index].desc;
    // bool isPriority = TodoListScreen.listToDo[widget.index].isPriority;
    DateTime startTimeTemp = _myBox.getAt(widget.index).startDate;
    DateTime endTimeTemp = _myBox.getAt(widget.index).endDate;
    String initialToDoTitle = _myBox.getAt(widget.index).todos;
    String initialDesc = _myBox.getAt(widget.index).desc;
    bool isPriority = _myBox.getAt(widget.index).isPriority;

    void showStartDate() {
      showDatePicker(
              context: context,
              initialDate: _myBox.getAt(widget.index).startDate,
              firstDate: DateTime(2024),
              lastDate: DateTime(2050))
          .then((value) {
        if (value != null) {
          setState(() {
            _myBox.getAt(widget.index).startDate = value;
          });
        }
      });
    }

    void showEndDate() {
      showDatePicker(
              context: context,
              initialDate: _myBox.getAt(widget.index).endDate,
              firstDate: DateTime(2024),
              lastDate: DateTime(2050))
          .then((value) {
        if (value != null) {
          setState(() {
            _myBox.getAt(widget.index).endDate = value;
          });
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit task", style: TextStyle(fontFamily: 'Anta')),
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
        padding: const EdgeInsets.all(8.0),
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
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text("Start", style: TextStyle(fontFamily: 'Anta'))),
                Expanded(
                    child: Text("Ends", style: TextStyle(fontFamily: 'Anta')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: showStartDate,
                      style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white
                                .withOpacity(0.2)
                                .withOpacity(0.8) // Background color with opacity
                            ),
                      child: Text(
                        DateFormat('EEE d MMM, yyyy').format(startTimeTemp),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: showEndDate,
                      style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white
                                .withOpacity(0.2)
                                .withOpacity(0.8) // Background color with opacity
                            ),
                      child: Text(
                        DateFormat('EEE d MMM, yyyy').format(endTimeTemp),
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
            TextFormField(
              initialValue: initialToDoTitle,
              onChanged: (value) {
                setState(() {
                  _myBox.getAt(widget.index).todos = value;
                });
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
                      onPressed: () => setState(() => _myBox.getAt(widget.index).isPriority = true),
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
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: ElevatedButton(
                      onPressed: () => setState(() => _myBox.getAt(widget.index).isPriority = false),
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
              padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Description", style: TextStyle(fontFamily: 'Anta'))),
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                scrollPadding: const EdgeInsets.only(bottom: 40),
                controller: null,
                onChanged: (value) {
                  setState(() {
                    _myBox.getAt(widget.index).desc = value;
                  });
                },
                initialValue: initialDesc,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: ElevatedButton(
                onPressed: () {
                  if (endTimeTemp.difference(startTimeTemp).inDays < 0 ||
                      endTimeTemp.difference(DateTime.now()).inDays < 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Date invalid"),
                          content: const Text(
                              "End date cannot be the day before today or the start date"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (initialToDoTitle == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Task title input invalid"),
                          content: const Text("Please input the task title"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    setState(() {
                      widget.onTaskAdded();
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purpleAccent, // This is what you need!
                ),
                child: const Text(
                  "Edit Task",
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
