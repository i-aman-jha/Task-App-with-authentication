import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';

import 'package:flutter_application_1/pages/contact.dart';

import 'package:flutter_application_1/utilities/dialogBox.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import '../utilities/tasks.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TaskDatabase db = TaskDatabase();

  @override
  void initState() {
    User? user = _auth.currentUser;
    if (user != null) {
      db.loadData(user.uid);
    }
    super.initState();
  }

  void saveNewTask() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('tasks').add({
          'taskName': _controller.text,
          'taskCompleted': false,
        });
        db.loadData(user.uid);
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(247, 158, 158, 158),
          content: Text('Task Added..'),
          )
        );
      }
    } catch (e) {
      print('Error adding task: $e');
    }

    _controller.clear();
    Navigator.of(context).pop();
  }

void checkBoxChanged(bool? value, String taskId) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'taskCompleted': value,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(247, 158, 158, 158),
          content: Text('Task Done..'),
        ),
      );
    }
  } catch (e) {
    print('Error updating task: $e');
  }
}
void deleteTask(String taskId) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(247, 158, 158, 158),
          content: Text('Task Deleted...'),
        ),
      );
    }
  } catch (e) {
    print('Error deleting task: $e');
  }
}

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "TASKS",
          style: GoogleFonts.rubikBurned(
            textStyle: const TextStyle(
                fontSize: 30, letterSpacing: 8, fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          // logout button
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.black),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed Out Successfully...')),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              });
            },
          ),
        ],
        backgroundColor: Colors.blueAccent,
        elevation: 15,
        shadowColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Column(
                children: [
                  Icon(Icons.task, size: 100),
                  Text(
                    'T A S K S',
                    style: TextStyle(fontSize: 20, letterSpacing: 6),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.home),
              title: Text(
                'H O M E',
                style: GoogleFonts.orbitron(
                    fontSize: 25, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pop();

                if (ModalRoute.of(context)?.settings.name !=
                    HomePage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.contact_support),
              title: Text(
                'C O N T A C T  M E',
                style: GoogleFonts.orbitron(
                    fontSize: 25, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pop();

                if (ModalRoute.of(context)?.settings.name !=
                    ContactPage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: createNewTask,
        child: Icon(Icons.add, size: 30),
        backgroundColor: Color.fromARGB(255, 185, 223, 255),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(_auth.currentUser?.uid).collection('tasks').snapshots(),
        builder: (context, snapshot) {

           if (snapshot.hasData) {
            var tasks = snapshot.data!.docs;
          

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              var taskId = task.id;

              return Tasks(
                TaskName: task['taskName'],
                taskCompleted: task['taskCompleted'],
                onChanged: (value) => checkBoxChanged(value, taskId),
                deleteFunction: (context) => deleteTask(taskId),
              );
            },
          );
           }
           else {
            return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: Center(
           child: CircularProgressIndicator(),
            ),
        );
          }

        },
      ),
    );
  }
}