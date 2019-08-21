import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDeleteTransaction;

  TransactionList(this.transactions, this.onDeleteTransaction);

  @override
  Widget build(BuildContext context) {
    return (transactions.isEmpty)
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
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final t = transactions[index];

              return Card(
                child: Dismissible(
                  key: Key(t.id),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).errorColor,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(
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
                    onDeleteTransaction(t.id);
                  },
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
                ),
              );
            },
          );
  }
}
