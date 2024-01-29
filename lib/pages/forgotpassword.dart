import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';
import 'package:flutter_application_1/utilities/reusable_func.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailTextController=TextEditingController();
  
  // @override
  // void dispose() {
  //   _passwordTextController.dispose();
  //   _emailTextController.dispose();
  //   _usernameTextController.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 181, 253),
              Color.fromARGB(255, 1, 111, 165),
              Color.fromARGB(255, 88, 119, 135),
              Color.fromARGB(255, 132, 146, 161),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/account.png",
                  fit: BoxFit.fitWidth,
                  width: 80,
                  height: 80,
                  color: Colors.white,
                ),
                // ImageWidget("assets/images/account.png"),
                Text(
                  "FORGOT PASSWORD",
                  style: GoogleFonts.exo2(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  
                  ),
                const SizedBox(
                  height: 30,
                ),
                
                textField("Enter Email",Icons.email,false,_emailTextController),
              
                const SizedBox(
                  height: 20,
                ),

                Button(context, "Forgot Password",(){
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text).then((value) => Navigator.of(context).pop());
                }),
                signInOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signInOption(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Already have account?  ",
        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
        ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => SignInScreen())));
        },
        child: const Text("Sign In",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
 }

 
}