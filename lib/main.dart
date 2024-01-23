// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/home_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Hive.initFlutter();

  var box=await Hive.openBox('mybox');


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _HomPageState();
}

class _HomPageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
      theme: ThemeData(primaryColor: Colors.blueAccent),
    );
  }
}