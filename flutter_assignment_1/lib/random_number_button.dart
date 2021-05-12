import 'package:flutter/material.dart';

class RandomNumberButton extends StatelessWidget {
  final Function generateRandomNumber;

  RandomNumberButton({@required this.generateRandomNumber});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: generateRandomNumber,
      child: Text(
        'Create Random Number',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
