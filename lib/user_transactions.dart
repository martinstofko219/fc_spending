import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      description: 'New Shoes',
      amount: 149.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      description: 'Groceries',
      amount: 84.65,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }

  void _addTransaction(String description, double amount) {
    final t = Transaction(
        description: description,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() => _transactions.add(t));
  }
}
