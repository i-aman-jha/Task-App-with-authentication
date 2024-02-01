import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final controller;
  VoidCallback onSave;

  DialogBox({
    super.key,
    required this.title,
    required this.controller,
    required this.onSave,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Add New Task" ,
            labelStyle: TextStyle(color: Colors.black),
            hintFadeDuration: Durations.medium2,
            focusedBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: Color.fromARGB(255, 28, 111, 255)),
            ),
            enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: Color.fromARGB(255, 28, 111, 255)),
            )
            ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel',style: TextStyle(color: Color.fromARGB(255, 28, 111, 255)),),
          ),
          TextButton(
            onPressed: onSave,
            child: const Text('Save', style: TextStyle(color: Color.fromARGB(255, 28, 111, 255)),),
          ),
        ],
      );
    
  }
}