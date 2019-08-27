import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) onDeleteTransaction;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.onDeleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: key,
        background: Container(
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (direction != DismissDirection.endToStart) {
            return;
          }
          onDeleteTransaction(transaction.id);
        },
        child: ListTile(
          trailing: Text(
            '\$${transaction.amount.toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.body1.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
          ),
          title: Text(
            transaction.description,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle:
              Text(DateFormat.yMMMMEEEEd().add_jm().format(transaction.date)),
        ),
      ),
    );
  }
}
