import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content:Container(
          // alignment: ,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "A D D  N E W  T A S K",
                  hintFadeDuration: Durations.medium2,
                  ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 10,),

                MyButton(text: "Cancel", onPressed: onCancel),
              ],)


            ],
          ),
          ),
      
    );
  }
}