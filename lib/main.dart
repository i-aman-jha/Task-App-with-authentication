// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    );

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
      home:SignInScreen(),
      theme: ThemeData(primaryColor: Colors.blueAccent),
    );
  }
}