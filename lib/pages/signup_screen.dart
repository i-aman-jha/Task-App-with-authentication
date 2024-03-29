import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';
import 'package:flutter_application_1/utilities/reusable_func.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController=TextEditingController();
  final TextEditingController _emailTextController=TextEditingController();
  final TextEditingController _usernameTextController=TextEditingController();

  

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
              Color.fromARGB(255, 0, 0, 0),
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
                  "SIGN UP",
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

                textField("Enter Username",Icons.person_4,false,_usernameTextController),
              
                const SizedBox(
                  height: 20,
                ),
                
                textField("Enter Email",Icons.email,false,_emailTextController),
              
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Password",Icons.password_sharp,true,_passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                Button(context, "Sign Up", (){
                  FocusScope.of(context).unfocus();
                  
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account created successfully...')),
                      );
                      print("created new account");
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const SignInScreen()));
                    }).onError((error, stackTrace) {
                      // print("Error ${error.tostring()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error...')),
                      );
                    });
                    
                  


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
          Navigator.push(context, MaterialPageRoute(builder: ((context) => const SignInScreen())));
        },
        child: const Text("Sign In",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
 }

 
}