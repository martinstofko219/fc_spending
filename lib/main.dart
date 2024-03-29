import 'dart:io';

import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    // Add an observer for this class (needs to implement didChangeAppLifecycleState(AppLifecycleState) method).
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    // Remove the observer.
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isLandscape = mq.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar(isLandscape);
    final pageBody = _buildAppBody(isLandscape, mq, appBar);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _openNewTransactionSheet(context),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: pageBody,
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

  PreferredSizeWidget _buildAppBar(bool isLandscape) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: Row(
              children: <Widget>[
                if (isLandscape)
                  _showChart
                      ? GestureDetector(
                          child: const Text('Transactions'),
                          onTap: _toggleChart,
                        )
                      : GestureDetector(
                          child: const Text('Chart'),
                          onTap: _toggleChart,
                        )
              ],
            ),
            middle: const Text('Spending Tracker'),
            trailing: GestureDetector(
              child: const Icon(CupertinoIcons.add),
              onTap: () => _openNewTransactionSheet(context),
            ),
          )
        : AppBar(
            title: const Text('Spending Tracker'),
            actions: <Widget>[
              if (isLandscape)
                _showChart
                    ? IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: _toggleChart,
                      )
                    : IconButton(
                        icon: const Icon(Icons.insert_chart),
                        onPressed: _toggleChart,
                      ),
            ],
          );
  }

  Widget _buildAppBody(
      bool isLandscape, MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              _buildChart((mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.225),
            if (!isLandscape)
              _buildTransactions((mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.775),
            if (isLandscape)
              _showChart
                  ? _buildChart((mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top))
                  : _buildTransactions((mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top))
          ],
        ),
      ),
    );
  }

  Widget _buildChart(double height) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
