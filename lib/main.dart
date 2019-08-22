import 'package:flutter/material.dart';

import 'chart.dart';
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
        accentColor: Colors.deepOrangeAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
            ),
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
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Spending Tracker'),
      actions: <Widget>[
        if (isLandscape)
          (_showChart)
              ? IconButton(
                  icon: Icon(Icons.list),
                  onPressed: _toggleChart,
                )
              : IconButton(
                  icon: Icon(Icons.insert_chart),
                  onPressed: _toggleChart,
                ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: (!isLandscape || (isLandscape && !_showChart))
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openNewTransactionSheet(context),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              _buildChart((MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.225),
            if (!isLandscape)
              _buildTransactions((MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.775),
            if (isLandscape)
              _showChart
                  ? _buildChart((MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top))
                  : _buildTransactions((MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top))
          ],
        ),
      ),
    );
  }

  void _addTransaction(
      String description, double amount, DateTime transactionDate) {
    final t = Transaction(
        description: description,
        amount: amount,
        date: transactionDate,
        id: DateTime.now().toString());

    setState(() => _transactions.add(t));
  }

  void _removeTransaction(String id) {
    if (id == null) {
      return;
    }

    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  void _openNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _toggleChart() {
    setState(() => _showChart = !_showChart);
  }

  Widget _buildChart(double height) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      height: height,
      child: Chart(_recentTransactions),
    );
  }

  Widget _buildTransactions(double height) {
    return Container(
      height: height,
      child: TransactionList(_transactions, _removeTransaction),
    );
  }
}
