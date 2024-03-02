import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _myProfileBox = Hive.box('profileDataBase');

  void _showBirthdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2024))
        .then((value) {
      setState(() {
        _myProfileBox.put("birthDate", DateFormat('EEE d MMM, yyyy').format(value!).toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Center(
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontFamily: 'Anta',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset('resource/arabCat.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 130,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.blue.shade400),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text("Name", style: TextStyle(fontFamily: 'Anta'))),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
                    .withOpacity(0.5), // Background color with 50% opacity
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextFormField(
                  initialValue: _myProfileBox.get('userName') ?? "",
                  onChanged: (value) {
                    _myProfileBox.put("userName", value);
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text("Major", style: TextStyle(fontFamily: 'Anta'))),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
                    .withOpacity(0.5), // Background color with 50% opacity
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextFormField(
                  initialValue:
                      _myProfileBox.get('major') ?? "",
                  onChanged: (value) {
                    _myProfileBox.put("major", value);
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text("Date of Birth",
                        style: TextStyle(fontFamily: 'Anta'))),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                      .withOpacity(0.2)
                      .withOpacity(0.8) // Background color with opacity
                  ),
              onPressed: _showBirthdate,
              child: Text(
                // _myProfileBox.get('birthDate') ?? "Choose Date",
                "Choose Date",
              ),
            ),
            SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text("Email", style: TextStyle(fontFamily: 'Anta'))),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
                    .withOpacity(0.5), // Background color with 50% opacity
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextFormField(
                  initialValue:
                      _myProfileBox.get('email') ?? "",
                  onChanged: (value) {
                    _myProfileBox.put("email", value);
                    // UserData.userName = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
