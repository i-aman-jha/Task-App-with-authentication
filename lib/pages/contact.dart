import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/utilities/contactform.dart';
import 'package:flutter_application_1/utilities/footer.dart';
import 'package:flutter_application_1/utilities/socialmedia.dart';

import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = '/contact';


  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CONTACT",
          style: GoogleFonts.chakraPetch(
            textStyle: TextStyle(
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
            const DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.blueAccent
              // ),
              child: Column(
                children: [
                  Icon(Icons.task,size: 100,),
                  Text('T A S K S',
                  style: TextStyle(fontSize: 20,letterSpacing: 6),
                  ),
                ],
              ),
            
            ),
            ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.home),
              title:
               Text('H O M E',style: GoogleFonts.orbitron(
                fontSize: 25,
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
                fontSize: 25,
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