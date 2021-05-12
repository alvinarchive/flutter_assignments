import 'package:flutter/material.dart';
import 'package:flutter_assignment_1/random_number.dart';
import 'package:flutter_assignment_1/random_number_button.dart';
import 'dart:math';

// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    void _generateRandomNumber() {
      Random random = new Random();
      setState(() {
        _number = random.nextInt(100);
      });
    }

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Assignment 1'),
            ),
            body: Container(
              width: double.infinity,
              margin: EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Random Number Generator',
                    style: TextStyle(fontSize: 24),
                  ),
                  RandomNumber(
                    number: _number,
                  ),
                  RandomNumberButton(
                    generateRandomNumber: _generateRandomNumber,
                  )
                ],
              ),
            )));
  }
}
