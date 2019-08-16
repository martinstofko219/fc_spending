import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 450.0,
      child: (transactions.isEmpty)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 300.0,
                  margin: EdgeInsets.only(bottom: 8.0),
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
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final t = transactions[index];

                return Card(
                  child: ListTile(
                    trailing: Text(
                      '\$${t.amount.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.body1.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    title: Text(
                      t.description,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle:
                        Text(DateFormat.yMMMMEEEEd().add_jm().format(t.date)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
