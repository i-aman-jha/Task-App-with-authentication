import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class footer extends StatelessWidget {
  const footer({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      color: Colors.blueAccent,
      child: Row(
        children: [
          Text(
            '© 2024 All Rights Reserved.',
            textAlign: TextAlign.left,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Spacer(),
          Text(
            '@ Aman Jha',
            textAlign: TextAlign.right,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          
        ],
      ),
    );
  }
}