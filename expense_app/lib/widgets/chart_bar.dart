import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final String spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Container(
              padding: EdgeInsets.all(2.5),
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(
                'Rp $spendingAmount',
              ))),
          SizedBox(height: constraint.maxHeight * 0.015),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10))),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraint.maxHeight * 0.015),
          Container(
              padding: EdgeInsets.all(2.5),
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
