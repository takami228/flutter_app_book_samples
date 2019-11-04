import 'package:flutter/material.dart';
import 'package:flutter_app/counter_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('Scoped Model')),
            body: Center(child: CounterApp())),
      );
}
