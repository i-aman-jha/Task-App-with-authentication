import 'package:hive_flutter/hive_flutter.dart';

class taskDatabase{

  List taskList=[];

  final _myBox=Hive.box('mybox');

  void createInitialData(){
    taskList=[
      ["Task 1",false],
      ["Task 2",false],
    ];
  }

  void loadData(){
    taskList=_myBox.get("TASKLIST");
  }

  void updateDatabase(){
    _myBox.put("TASKLIST", taskList);
  }


}