import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime) onAddTransaction;

  NewTransaction(this.onAddTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          left: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (_selectedDate == null)
                        ? 'No transaction date'
                        : DateFormat.yMMMMEEEEd().format(_selectedDate),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: _openDatePicker,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                ),
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text);
    final transactionDate = _selectedDate;

    if (description.isEmpty ||
        amount == null ||
        amount <= 0 ||
        transactionDate == null) {
      return;
    }

    widget.onAddTransaction(_descriptionController.text,
        double.parse(_amountController.text), transactionDate);

    // close the bottom modal sheet
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: (_selectedDate == null) ? DateTime.now() : _selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() => _selectedDate = value);
    });
  }
}
