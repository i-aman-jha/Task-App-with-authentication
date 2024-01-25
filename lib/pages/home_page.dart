// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';

import 'package:flutter_application_1/pages/contact.dart';

import 'package:flutter_application_1/utilities/dialogBox.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utilities/tasks.dart';


class HomePage extends StatefulWidget {

  static const String routeName = '/homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox=Hive.box('mybox');
  taskDatabase db=taskDatabase();

  @override
  void initState() {
    if(_myBox.get("TASKLIST")==null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

  final _controller=TextEditingController();

  // List taskList=[
  //     ["Task 1",false],
  //     ["Task 2",false],
  //   ];
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.taskList[index][1]= !db.taskList[index][1];
    });
    db.updateDatabase();

  }

  void saveNewTask(){
    setState(() {
      db.taskList.add([_controller.text,false]);
      _controller .clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color.fromARGB(247, 158, 158, 158),
              content: Text('Task Added...'),
            ),
          );
    Navigator.of(context).pop();
    db.updateDatabase();
  }


  void createNewTask(){
    showDialog(context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=>Navigator.of(context).pop(),
      );
    }
    );
  }

  void deleteTask(int index){
    setState(() {
      db.taskList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color.fromARGB(247, 158, 158, 158),
              content: Text('Task Deleted...'),
            ),
          );
    db.updateDatabase();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "TASKS",
          style: GoogleFonts.rubikBurned(
            textStyle: TextStyle(
              fontSize: 30,
              letterSpacing: 8,
              fontWeight: FontWeight.w900
            )
          ),
           
          ),
        backgroundColor: Colors.blueAccent,
        elevation: 15,
        shadowColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        // backgroundColor:Color.fromARGB(255, 218, 231, 255),
        child: ListView(
          children: [
            const DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.blueAccent
              // ),
              child: Column(
                children: [
                  Icon(Icons.task,size: 100,),
                  Text('T A S K S',
                  style: TextStyle(fontSize: 20,letterSpacing: 6),
                  ),
                ],
              ),
            
            ),
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.home),
              title:
               Text('H O M E',style: GoogleFonts.orbitron(
                fontSize: 25,
                fontWeight:FontWeight.w300
              ),),
              onTap: () {
                // Close the drawer before navigating
                Navigator.of(context).pop(); 

                //Check if the current route is not HomePage, then navigate
                if (ModalRoute.of(context)?.settings.name != HomePage.routeName) {
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
              title: 
               Text('C O N T A C T  M E',style: GoogleFonts.orbitron(
                fontSize: 25,
                fontWeight:FontWeight.w300
              ),),
              onTap: (){
                // Close the drawer before navigating
                
                Navigator.of(context).pop(); 
        
                //Check if the current route is not Aboutpage, then navigate
                if (ModalRoute.of(context)?.settings.name != ContactPage.routeName) {
                  
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                }
              },
            ),  
            // ListTile(
              
            //   contentPadding: EdgeInsets.all(15),
            //   leading: Icon(Icons.contact_support),
            //   title: 
            //    Text('Register',style: GoogleFonts.orbitron(
            //     fontSize: 25,
            //     fontWeight:FontWeight.w300
            //   ),),
            //   onTap: (){
            //     // Close the drawer before navigating
                
            //     Navigator.of(context).pop(); 
        
            //     //Check if the current route is not Aboutpage, then navigate
            //     if (ModalRoute.of(context)?.settings.name != SignInScreen.routeName) {
                  
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => SignInScreen()),
            //       );
            //     }
            //   },
            // ),  
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: createNewTask,
        child: Icon(Icons.add,size: 30,),
        backgroundColor: Color.fromARGB(255, 185, 223, 255),
        ),
      body: ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context, index) {
          return Tasks(
            TaskName: db.taskList[index][0], 
            taskCompleted: db.taskList[index][1],
             onChanged: (value) => checkBoxChanged(value,index),
             deleteFunction: (context) => deleteTask(index),
             );
        },
      ),
    );
  }
}