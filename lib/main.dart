// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'add_task_page.dart';
import 'edit_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'datatodo.dart';
// import 'package:flutter_learn_the_basics/datatodo.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DataToDoAdapter());

  var box = await Hive.openBox('userDataBase');
  var boxP = await Hive.openBox('profileDataBase');

  // box1.deleteFromDisk();
  // box2.deleteFromDisk();

  // int nextIndex = box.values.length;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int currentIndex = 0;
  final _myBox = Hive.box('userDataBase');
  int getDayRemaining(int index) {
    return _myBox.getAt(index).endDate.difference(DateTime.now()).inDays;
  }

  @override
  void didUpdateWidget(TodoListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      // Refresh the UI when returning from NextPage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDolizer",
          style: TextStyle(
            fontFamily: 'Anta',
          ),
        ),
        shadowColor: Colors.black,
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
      body: currentIndex == 0
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade200,
                    Colors.green.shade200,
                    Colors.blue.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Welcome, ${_myBox.get('userName') == "" ? "User" : _myBox.get('userName') ?? "User"}!",
                    style: TextStyle(
                      fontFamily: 'Anta',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Text("Do you have any plan today?",
                      style: TextStyle(
                        fontFamily: 'Anta',
                        color: Colors.black54,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daily Task",
                        style: TextStyle(
                          fontFamily: 'Anta',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => TaskPage(
                                onTaskAdded: () {
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Add Task",
                          style: TextStyle(
                            fontFamily: 'Anta',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _myBox.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    _myBox.deleteAt(index);
                                  });
                                },
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                icon: Icons.delete,
                                backgroundColor: Colors.red.shade400,
                              )
                            ],
                          ),
                          child: Card(
                            // color: _myBox.getAt(index).isPriority
                            color: _myBox.getAt(index).isPriority
                                ? Colors.purple.shade200
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Set border radius
                              // side: _myBox.getAt(index).isPriority
                              side: _myBox.getAt(index).isPriority
                                  ? BorderSide(
                                      color: Colors.purple.shade500, width: 4.0)
                                  : BorderSide(
                                      color: Colors.purple.shade500,
                                      width: 0), // Set border color and width
                            ),
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => EditPage(
                                      index: index,
                                      onTaskAdded: () {
                                        setState(
                                            () {}); // Trigger a rebuild of TodoListScreen
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  _myBox.getAt(index).todos,
                                  style: TextStyle(
                                      decoration:
                                          _myBox.getAt(index).isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                      fontFamily: 'Anta',
                                      fontSize: 18,
                                      color: _myBox.getAt(index).isCompleted
                                          ? Colors.deepPurple
                                          : Colors.black),
                                ),
                                subtitle: Text(getDayRemaining(index) == 0
                                    ? "Final day!"
                                    : "${getDayRemaining(index)} day(s) remaining"),
                                textColor: getDayRemaining(index) == 0
                                    ? Colors.red
                                    : Colors.black,
                                trailing: Wrap(
                                  spacing: 3, // space between two icons
                                  children: <Widget>[
                                    Checkbox(
                                        // value: _myBox.getAt(index).isCompleted,
                                        value: _myBox.getAt(index).isCompleted,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            _myBox.getAt(index).isCompleted =
                                                !_myBox
                                                    .getAt(index)
                                                    .isCompleted;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_filled,
              color: Colors.lightBlue,
              size: 24.0,
              semanticLabel: "To play a music",
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_box),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
