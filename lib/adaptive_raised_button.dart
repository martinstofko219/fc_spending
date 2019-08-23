import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String caption;
  final void Function() onSubmit;

  AdaptiveRaisedButton({@required this.caption, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              child: Text(caption),
              onPressed: onSubmit,
            ),
          )
        : RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            child: Text(caption),
            onPressed: onSubmit,
          );
  }
}
