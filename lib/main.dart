import 'package:flutter/material.dart';
import 'package:password_generator_flutter/description_card.dart';

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
            child: DescriptionWidget(),
          ),
          Expanded(
            flex: 7,
            child: PasswordGenerationWidget(),
          ),
        ],
      ),
    );
  }
}

// Left side's view
class DescriptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF9FBCFF),
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Manual",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          DescriptionCards(storage: DescriptionStorage()),
        ],
      ),
    );
  }
}

// Right side's view
class PasswordGenerationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF74A0FF),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Password Converter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
