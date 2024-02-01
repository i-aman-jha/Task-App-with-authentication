
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TaskDatabase {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  List<Map<String, dynamic>> taskList = [];

  Future<void> createInitialData(String userId) async {
    // Create a subcollection for each user
    CollectionReference userTasksCollection =
        FirebaseFirestore.instance.collection('users').doc(userId).collection('tasks');

    taskList = [
      {"taskName": "Task 1", "taskCompleted": false,"timestamp":DateFormat('MMM d, h:mm a').format(DateTime.now())},
      {"taskName": "Task 2", "taskCompleted": false,"timestamp":DateFormat('MMM d, h:mm a').format(DateTime.now())},
    ];

    // Add tasks to the user-specific subcollection
    for (Map<String, dynamic> task in taskList) {
      await userTasksCollection.add(task);
    }
  }


 Future<void> loadData(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      taskList = querySnapshot.docs
          .map((doc) => {
                "taskName": doc['taskName'],
                "taskCompleted": doc['taskCompleted'],
                "timestamp":doc['timestamp'],
                "taskId": doc.id,
              })
          .toList();
          
    } catch (e) {
      print('Error loading data from Firestore: $e');
    }
  }


  Future<void> updateDatabase() async {
    // Update tasks in Firebase
    for (Map<String, dynamic> task in taskList) {
    
      String taskId = task['taskId'];

      await _tasksCollection.doc(taskId).update(task);
    }
  }
}