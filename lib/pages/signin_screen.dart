import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/forgotpassword.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/signup_screen.dart';
import 'package:flutter_application_1/utilities/reusable_func.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/SignInScreen';
  
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController=TextEditingController();
  final TextEditingController _emailTextController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ImageWidget("assets/images/account.png"),
                
                 Text(
                  "SIGN IN",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
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
                textField("Enter Email",Icons.person_outline_rounded,false,_emailTextController),
              
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Password",Icons.password_sharp,true,_passwordTextController),
                const SizedBox(
                  height: 10,
                ),
                forgotOption(),
                const SizedBox(
                  height: 5,
                ),
                Button(context, "Sign In", (){
                  FocusScope.of(context).unfocus();
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text, 
                    password: _passwordTextController.text
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Signed In Successfully...')),
                      );
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()));
                    }).onError((error, stackTrace) {
                      // print("Error ${error.tostring()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Incorrect Email address or Password..')),
                      );
                    });
                }),
                signUpOption(),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

 Row signUpOption(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have account?  ",
        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
        ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUpScreen())));
        },
        child: const Text("Sign Up",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
 }

 Row forgotOption(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => ForgotPassword())));
        },
        child: Padding(
          padding: const EdgeInsets.only(right:6),
          child: const Text("Forgot Password?",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
 }

}
