import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator_flutter/description_card.dart';
// import 'description_card.dart';
// import 'description.dart';

void main() {
  runApp(MaterialApp(
    home: PasswordGenerator(),
  ));
}

class PasswordGenerator extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00FFFFF0),
        title: Text(
          "Safe Password Generator",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFF9FBCFF),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    "Manual"
                  ),
                  Container(
                    child: DescriptionCards(storage: DescriptionStorage()),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: const Color(0xFF74A0FF),
              child: Column(
                children: [
                  Text(
                    "Password Converter"
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}