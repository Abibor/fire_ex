import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userSalaryController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserting data'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Inserting data in Firebase Realtime Database',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userAgeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Enter Your Age',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userSalaryController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Salary',
                    hintText: 'Enter Your Salary',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    if (userNameController.text.isEmpty ||
                        userAgeController.text.isEmpty ||
                        userSalaryController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "You have one or more empty fields. Please fill in all",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    ;

                    //if (userAgeController.text.isEmpty) return;
                    //if (userSalaryController.text.isEmpty) return;

                    Map<String, String> students = {
                      'name': userNameController.text,
                      'age': userAgeController.text,
                      'salary': userSalaryController.text
                    };
                    dbRef.push().set(students);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const MyHomePage()));
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 40,
                  child: const Text('Insert Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
