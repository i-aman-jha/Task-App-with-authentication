import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';

import 'package:flutter_application_1/pages/contact.dart';

import 'package:flutter_application_1/utilities/dialogBox.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utilities/tasks.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      
      if (user != null && _controller.text.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).collection('tasks').add({
          'taskName': _controller.text,
          'taskCompleted': false,
          'timestamp': DateFormat('MMM d, h:mm a').format(DateTime.now()),
        });
        db.loadData(user.uid);
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(247, 158, 158, 158),
          content: Text('Task Added..'),
          )
        );
        _controller.clear();
      }
      else if(_controller.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(247, 158, 158, 158),
          content: Text('Task Field Empty'),
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
        const SnackBar(
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
        const SnackBar(
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
          title: "Add Task",
          controller: _controller,
          onSave: saveNewTask,
        );
      },
    );
  }

  void editTask(String taskId, String currentTaskName) {
  TextEditingController editController = TextEditingController();
  editController.text = currentTaskName;

  showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        title: "Edit Task",
        controller: editController, 
        onSave: () async {
          Navigator.of(context).pop(); // Close the dialog

          try {
            User? user = _auth.currentUser;
            if (user != null) {
              await _firestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('tasks')
                  .doc(taskId)
                  .update({
                'taskName': editController.text,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor:
                      Color.fromARGB(247, 158, 158, 158),
                  content: Text('Task Updated..'),
                ),
              );
            }
          } catch (e) {
            print('Error updating task: $e');
          }
        }
        );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String email = user?.email ?? '';
  
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
            icon: const Icon(Icons.logout_outlined, color: Colors.black),
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
            DrawerHeader(
              
              child: Column(
                children: [
                  
                  const Icon(Icons.person_pin, size: 100),
                  Text(
                    email,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.home),
              title: Text(
                'H O M E',
                style: GoogleFonts.orbitron(
                    fontSize: MediaQuery.of(context).size.width * 0.06, 
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pop();

                if (ModalRoute.of(context)?.settings.name !=
                    HomePage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.contact_support),
              title: Text(
                'C O N T A C T  M E',
                style: GoogleFonts.orbitron(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pop();

                if (ModalRoute.of(context)?.settings.name !=
                    ContactPage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.logout_rounded),
              title: Text(
                'L O G  O U T',
                style: GoogleFonts.orbitron(
                    fontSize: MediaQuery.of(context).size.width * 0.06, 
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(255, 185, 223, 255),
        child: const Icon(Icons.add, size: 30),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(_auth.currentUser?.uid).collection('tasks').orderBy('timestamp', descending: true).snapshots(),
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
                date: task['timestamp'],
                onChanged: (value) => checkBoxChanged(value, taskId),
                deleteFunction: (context) => deleteTask(taskId),
                editFunction: (context) => editTask(taskId,task['taskName']),
              );
            },
          );
           }
           else {
            return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
          }

        },
      ),
    );
  }
}