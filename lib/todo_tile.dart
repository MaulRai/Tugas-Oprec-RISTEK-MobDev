import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class PassDataDemo extends StatefulWidget {
  const PassDataDemo({Key? key}) : super(key: key);
  @override
  State<PassDataDemo> createState() => _PassDataDemoState();
}
class _PassDataDemoState extends State<PassDataDemo> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TextField(
            controller: myController,
            decoration: InputDecoration(labelText: 'Enter Fruit Name'),
          ),
          // Step 1 <-- SEE HERE
          ElevatedButton(
            onPressed: () {
              // Step 3 <-- SEE HERE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(title: myController.text),
                ),
              );
            },
            child: const Text(
              'Pass Data To Next Screen',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
class DetailScreen extends StatefulWidget {
  // In the constructor, require a Todo.
  const DetailScreen({Key? key, required this.title}) : super(key: key);
  // Step 2 <-- SEE HERE
  final String title;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 4 <-- SEE HERE
            Text(
              '${widget.title}',
              style: TextStyle(fontSize: 54),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'next_page.dart';

// // import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyAppExt(),
//     );
//   }
// }

// class MyAppExt extends StatefulWidget {
//   const MyAppExt({super.key});

//   @override
//   State<MyAppExt> createState() => _MyAppExtState();
// }

// class _MyAppExtState extends State<MyAppExt> {
//   String buttonName = 'Click!';
//   int currentIndex = 0;
//   bool _isClicked = false;

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "ToDorizer",
//           // style: GoogleFonts.lato(),
//         ),
//         backgroundColor: Colors.purple,
//       ),
//       body: Center(
//         child: currentIndex == 0
//             ? Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 padding: EdgeInsets.all(10),
//                 color: Color.fromARGB(255, 119, 212, 255),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Welcome, User!",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                     const Text("Apakah Anda memiliki rencana hari ini?",
//                         style: TextStyle(
//                           color: Colors.black54,
//                         )),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Daily Task",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     const NextPage(),
//                               ),
//                             );
//                           },
//                           child: const Text("Add Task"),
//                         ),
//                       ],
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange),
//                       onPressed: () {
//                         setState(() {
//                           buttonName = 'Clicked';
//                         });
//                       },
//                       child: Text(buttonName),
//                     ),
//                   ],
//                 ),
//               )
//             : GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isClicked = !_isClicked;
//                   });
//                 },
//                 child: _isClicked
//                     ? Image.asset('resource/uniga.jpg')
//                     : Image.asset('resource/shoe.png'),
//               ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             label: "Home",
//             icon: Icon(
//               Icons.home_filled,
//               color: Colors.lightBlue,
//               size: 24.0,
//               semanticLabel: "To play a music",
//             ),
//           ),
//           BottomNavigationBarItem(
//             label: "Profile",
//             icon: Icon(Icons.account_box),
//           ),
//         ],
//         currentIndex: currentIndex,
//         onTap: (int index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
