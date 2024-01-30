import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';
import 'package:flutter_application_1/utilities/contactform.dart';
import 'package:flutter_application_1/utilities/footer.dart';
import 'package:flutter_application_1/utilities/socialmedia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = '/contact';


  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String email = user?.email ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CONTACT",
          style: GoogleFonts.chakraPetch(
            textStyle: const TextStyle(
              fontSize: 30,
              letterSpacing: 8,
              fontWeight: FontWeight.w900
            )
          ),
           
          ),
        backgroundColor: Colors.blueAccent,
        elevation: 15,
        shadowColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        // backgroundColor:Color.fromARGB(255, 218, 231, 255),
        child: ListView(
          children: [
            DrawerHeader(
              
              child: Column(
                children: [
                  
                  Icon(Icons.person_pin, size: 100),
                  Text(
                    email,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.home),
              title:
               Text('H O M E',style: GoogleFonts.orbitron(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight:FontWeight.w300
              ),),
              onTap: () {
                // Close the drawer before navigating
                Navigator.of(context).pop(); 

                //Check if the current route is not HomePage, then navigate
                if (ModalRoute.of(context)?.settings.name != HomePage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
            ),

            

            ListTile(
              
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.contact_support),
              title: 
               Text('C O N T A C T  M E',style: GoogleFonts.orbitron(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight:FontWeight.w300
              ),),
              onTap: (){
                // Close the drawer before navigating
                
                Navigator.of(context).pop(); 

                //Check if the current route is not Aboutpage, then navigate
                if (ModalRoute.of(context)?.settings.name != ContactPage.routeName) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                }
              },
            ),  
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.logout_rounded),
              title: Text(
                'L O G  O U T',
                style: GoogleFonts.orbitron(
                    fontSize: 25, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed Out Successfully...')),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              });
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ContactForm(),
            buildSocialMediaIcons(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false, // Set this to false to prevent the body from resizing when the keyboard is open
      bottomNavigationBar: footer(),
      
    );
  }
}