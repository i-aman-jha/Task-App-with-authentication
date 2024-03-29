import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/signin_screen.dart';
import 'package:flutter_application_1/utilities/contactform.dart';
import 'package:flutter_application_1/utilities/footer.dart';
import 'package:flutter_application_1/utilities/socialmedia.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = '/contact';


  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String item1="Logout";

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
          actions: [
          PopupMenuButton(
            elevation: 20,
            icon: const Icon(Icons.account_circle_outlined,size: 40, color: Colors.black,),
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: item1,
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    Text(item1),
                  ],
                ),
              ),
            ],
            onSelected: (value){
              if(value==item1){
                FirebaseAuth.instance.signOut().then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signed Out Successfully...')),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                });
              }
            },
          )
        ],
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
                  
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 51,
                    child: CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 60,
                    ),

                    )
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.home),
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
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
                // else{
                //   Navigator.of(context).pop(); 
                // }
              },
            ),

            

            ListTile(
              
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.contact_support),
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
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                }
              },
            ),  
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(Icons.logout_rounded),
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

      body: const SingleChildScrollView(
        child: Column(
          children: [
            ContactForm(),
            buildSocialMediaIcons(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false, // Set this to false to prevent the body from resizing when the keyboard is open
      bottomNavigationBar: const footer(),
      
    );
  }
}