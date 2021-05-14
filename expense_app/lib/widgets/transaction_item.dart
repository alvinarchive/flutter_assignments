import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    @required this.transaction,
    @required this.mediaQuery,
    @required this.deleteTransaction,
  });

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('Rp ${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: mediaQuery.size.width > 360
            ? FlatButton.icon(
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).buttonColor,
                ),
                color: Theme.of(context).errorColor,
                label: Text(
                  'Delete Transaction',
                  style: TextStyle(color: Theme.of(context).buttonColor),
                ),
              )
            : IconButton(
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
