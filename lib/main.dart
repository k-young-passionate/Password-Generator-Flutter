import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class PasswordGenerationWidget extends StatefulWidget {
  @override
  _PasswordGenerationWidgetState createState() =>
      _PasswordGenerationWidgetState();
}

class _PasswordGenerationWidgetState extends State<PasswordGenerationWidget> {
  final _pwKey = GlobalKey<FormState>();
  bool pwobscure = true;
  bool ewobscure = true;
  bool _includeSpecialCharacter = true;
  String newPassword = "sample password";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF74A0FF),
      child: ListView(
        shrinkWrap: true,
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
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Materials for a new password")),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Form(
                          key: _pwKey,
                          child: Column(
                            children: [
                              Container(
                                width: 300.0,
                                child: Row(children: [
                                  SizedBox(width: 80, child: Text("Password")),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      obscureText: pwobscure,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        this.pwobscure = !this.pwobscure;
                                      });
                                    },
                                  )
                                ]),
                              ),
                              Container(
                                width: 300.0,
                                child: Row(children: [
                                  SizedBox(
                                      width: 80, child: Text("Easy words")),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      obscureText: ewobscure,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        this.ewobscure = !this.ewobscure;
                                      });
                                    },
                                  )
                                ]),
                              ),
                              Container(
                                width: 300,
                                child: Row(children: [
                                  SizedBox(width: 80, child: Text("Length")),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                  )
                                ]),
                              ),
                              Container(
                                width: 300,
                                child: Row(children: [
                                  SizedBox(
                                      width: 80,
                                      child: Text("Special Characters")),
                                  Column(children: [
                                    SizedBox(
                                      width: 100,
                                      child: ListTile(
                                          contentPadding: EdgeInsets.all(2.0),
                                          title: Text('Include'),
                                          leading: Radio(
                                            value: true,
                                            groupValue:
                                                _includeSpecialCharacter,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _includeSpecialCharacter =
                                                    value;
                                              });
                                            },
                                          )),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: ListTile(
                                          contentPadding: EdgeInsets.all(2.0),
                                          title: const Text('Not Include'),
                                          leading: Radio(
                                            value: false,
                                            groupValue:
                                                _includeSpecialCharacter,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _includeSpecialCharacter =
                                                    value;
                                              });
                                            },
                                          )),
                                    ),
                                  ]),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {},
                        ),
                      ])),
                ])),
          ),
          Center(
            child: Column(children: [
              Text("Output"),
              Container(
                child: Column(
                  children:
                  [
                    Text("New safe password"),
                    Container(
                      color: Colors.white,
                      child: Text(newPassword),
                      ),
                      RaisedButton(
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: newPassword));
                        },
                      ),
                  ]
                )
              )
            ])
          ),
        ],
      ),
    );
  }
}
