import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class buildSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  const buildSocialIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launch(url)) {
          print('Could not launch $url');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $url'),
            ),
          );
        }
      },
      child: Icon(icon, size: MediaQuery.of(context).size.width * 0.09, color: Colors.blue),
    );
  }
}