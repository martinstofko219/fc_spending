import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalPercentage;

  const ChartBar(this.label, this.amount, this.totalPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(
              child: Text(
                '\$${amount.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 8.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1.0),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.black12,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: totalPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        );
      },
    );
  }
}
