import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _message = '';
  Color _defaultLabelColor = Colors.blueAccent;

  void _submitForm() {

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      
      // Save data to Firestore
      FirebaseFirestore.instance.collection('contacts').add({
        'name': _name,
        'email': _email,
        'message': _message,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted..')),
      );
    // Here, you can use _name, _email, and _message for further actions like sending an email
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: Center(
              child: Text(
                'CONTACT FORM',
                style: GoogleFonts.exo(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
                )
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 8,right: 8,bottom: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                
                floatingLabelStyle: TextStyle(color: Colors.black),
                
                contentPadding: EdgeInsets.all(10)
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                floatingLabelStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.all(10)
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              // keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _email = value!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                floatingLabelStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.all(10)
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
              onSaved: (value) => _message = value!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  elevation: MaterialStateProperty.all(20),
                  
                ),
                onPressed: _submitForm,
                child: const Text('Submit',style: TextStyle(color: Colors.black),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
