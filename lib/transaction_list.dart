import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          final t = transactions[index];

          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        t.description,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().add_jm().format(t.date),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    '\$${t.amount.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.subhead.apply(
                          color: Colors.red,
                          fontWeightDelta: 2,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
