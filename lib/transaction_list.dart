import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDeleteTransaction;

  const TransactionList(this.transactions, this.onDeleteTransaction);

  @override
  Widget build(BuildContext context) {
    return (transactions.isEmpty)
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.75,
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      'assets/images/no-records.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'No transactions',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final t = transactions[index];

              return TransactionItem(
                  transaction: t, onDeleteTransaction: onDeleteTransaction);
            },
          );
  }
}
