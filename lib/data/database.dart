
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDatabase {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  List<Map<String, dynamic>> taskList = [];

  Future<void> createInitialData() async {
    taskList = [
      {"title": "Task 1", "completed": false},
      {"title": "Task 2", "completed": false},
    ];

    // Add tasks to Firebase
    for (Map<String, dynamic> task in taskList) {
      await _tasksCollection.add(task);
    }
  }

 Future<void> loadData() async {
  // Fetch tasks from Firebase
  QuerySnapshot querySnapshot = await _tasksCollection.get();

  taskList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}


  Future<void> updateDatabase() async {
    // Update tasks in Firebase
    for (Map<String, dynamic> task in taskList) {
      // Assuming you have a unique identifier for each task
      String taskId = task['taskId']; // replace 'taskId' with your actual identifier

      await _tasksCollection.doc(taskId).update(task);
    }
  }
}
