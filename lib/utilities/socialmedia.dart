import 'package:flutter/material.dart';

import 'package:flutter_application_1/utilities/socialiconbutton.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class buildSocialMediaIcons extends StatelessWidget {
  const buildSocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(
                '!!Follow me on social media!!',
                style: GoogleFonts.exo2(
                textStyle: const TextStyle(
                  fontSize: 30,
                  // letterSpacing: 8,
                  fontWeight: FontWeight.w700
                )
              ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  buildSocialIcon(icon: FontAwesomeIcons.solidEnvelope, url: 'mailto:amanjha.7096@gmail.com'),
                  buildSocialIcon(icon :FontAwesomeIcons.linkedin, url: 'https://www.linkedin.com/in/aman-kumar-jha-461409286/'),
                  buildSocialIcon(icon :FontAwesomeIcons.github, url: 'https://github.com/i-aman-jha/i-aman-jha'),
                  buildSocialIcon(icon :FontAwesomeIcons.telegram, url: 'https://www.telegram.me/Aman_Jha_7096'),
                  // buildSocialIcon(icon :FontAwesomeIcons.twitter, url: 'https://twitter.com/',),
                  buildSocialIcon(icon :FontAwesomeIcons.squareInstagram, url: 'https://www.instagram.com/aman_jha.a/'),
                  buildSocialIcon(icon: FontAwesomeIcons.facebook, url: 'https://www.facebook.com/amankumar.jha.9822924',),
                  // Add more social icons as needed
                ],
              ),
            ],
          ),
        ),
      );
}
}