import 'package:flutter/material.dart';

Image ImageWidget(String imagename) {
    return Image.asset(
      imagename,
      fit: BoxFit.fitWidth,
      width: 200,
      height: 200,
      color: Colors.white,
    );
}

TextField textField(String text,IconData icon,bool isPasswordType,TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: const BorderSide(width: 0,style: BorderStyle.none))
    ),
    keyboardType: isPasswordType? TextInputType.visiblePassword:TextInputType.emailAddress,
  );
}

Container Button(BuildContext context,String title,Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90)
    ),
    child: ElevatedButton(
      onPressed: (){onTap();},
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return states.contains(MaterialState.pressed) ? const Color.fromARGB(255, 0, 181, 253) : Colors.white;
        }),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      child: Text(title,
      style: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17
      ),
      ),
    ),
  );
}


