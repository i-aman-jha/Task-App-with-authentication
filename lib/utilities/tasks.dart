
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class Tasks extends StatefulWidget {
  final String TaskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
  
  final String date;

  String item1="Edit";
  String item2="Delete";

  Tasks({super.key,
  required this.TaskName,
  required this.taskCompleted,
  required this.date,
  required this.onChanged,
  required this.deleteFunction,
  required this.editFunction,
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
          motion: const StretchMotion(), 
          children: [
            SlidableAction(onPressed: widget.deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(100),
            )
          ]
          ),
        child: Container(
          
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 231, 255),
            borderRadius: BorderRadius.circular(10),
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes the shadow direction
              ),
            ],
            ),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Spacer(),
                  PopupMenuButton(itemBuilder: (context)=>[
                    PopupMenuItem(
                      value: widget.item1,
                      child: Row(
                        children: [
                          Icon(Icons.edit,size: 18,),
                          Text(widget.item1),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: widget.item2,
                      child: Row(
                        children: [
                          Icon(Icons.delete,size: 18,),
                          Text(widget.item2),
                        ],
                      ),
                    ),

                  ],
                  onSelected: (value){
                    if(value==widget.item1){
                      widget.editFunction?.call(context);
                    }
                    else if(value==widget.item2){
                      widget.deleteFunction?.call(context);
                    }
                  },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Text(widget.date)

                ]
              ),
              
            ],
          ),
        ),
      ),
    );
  }
} 