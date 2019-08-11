import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function(String, double) addTransactionFunc;
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransactionFunc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: descriptionController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: () => addTransactionFunc(
                descriptionController.text,
                double.parse(amountController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
