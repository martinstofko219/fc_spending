import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';
import 'models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get weeklyTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var dayTotal = 0.0;

      for (var t in recentTransactions) {
        if (t.date.day == weekday.day &&
            t.date.month == weekday.month &&
            t.date.year == weekday.year) {
          dayTotal += t.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': dayTotal,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return weeklyTransactions.fold<double>(0.0, (total, transaction) {
      return total + transaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
        // horizontal: 8.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weeklyTransactions.map((d) {
            return Expanded(
              child: ChartBar(
                d['day'],
                d['amount'],
                (totalSpending == 0.0)
                    ? 0.0
                    : (d['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
