import 'package:flutter/material.dart';

class RandomNumber extends StatelessWidget {
  final int number;

  RandomNumber({@required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Text(
        number.toString(),
        style: TextStyle(fontSize: 36),
      ),
    );
  }
}
