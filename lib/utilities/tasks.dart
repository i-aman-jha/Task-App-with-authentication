import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_fonts/google_fonts.dart';

class Tasks extends StatefulWidget {
  final String TaskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  Tasks({super.key,
  required this.TaskName,
  required this.taskCompleted,
  required this.onChanged,
  required this.deleteFunction,
  });

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(onPressed: widget.deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(100),
            )
          ]
          ),
        child: Container(
          
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 218, 231, 255),
            borderRadius: BorderRadius.circular(10),
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 3), // changes the shadow direction
              ),
            ],
            ),
          child: Row(
            children: [
        
              Checkbox(
                value: widget.taskCompleted, 
                onChanged: widget.onChanged,
                activeColor: Colors.black87,
                ),
              Text(widget.TaskName,
              style: GoogleFonts.kalam(
                textStyle: TextStyle(
                  decoration: widget.taskCompleted? TextDecoration.lineThrough : TextDecoration.none,
                  fontSize: 20,
                  ),
              )
              
              ),
            ],
          ),
        ),
      ),
    );
  }
} 