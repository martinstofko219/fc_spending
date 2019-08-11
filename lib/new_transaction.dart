import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double) addTransactionFunc;

  NewTransaction(this.addTransactionFunc);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

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
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final description = descriptionController.text;
    final amount = double.tryParse(amountController.text);

    if (description.isEmpty || amount == null || amount <= 0) {
      return;
    }

    widget.addTransactionFunc(
      descriptionController.text,
      double.parse(amountController.text),
    );

    // close the bottom modal sheet
    Navigator.of(context).pop();
  }
}
