import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/counter_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
        model: CounterModel(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) => Text('${model.counter}'),
            ),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) => RaisedButton(
                  onPressed: model.increment, child: Text('Plus Button')),
            ),
          ],
        ));
  }
}
