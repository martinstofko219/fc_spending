import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spending Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openNewTransactionSheet(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openNewTransactionSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Text('chart'),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
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

  void _openNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }
}
