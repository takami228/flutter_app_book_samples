import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo({@required this.title, @required this.description})
      : assert(title != null),
        assert(description != null);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Navigation',
      home: TodoScreen(
          todos: List<Todo>.generate(
              20, (i) => Todo(title: 'Todo $i', description: 'Todo $i の詳細'))));
}

class TodoScreen extends StatelessWidget {
  final List<Todo> _todos;

  TodoScreen({Key key, @required List<Todo> todos})
      : assert(todos != null),
        this._todos = todos,
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Todoリスト'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) => ListTile(
            title: Text(_todos[index].title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(todo: _todos[index]),
                  ));
            }),
      ));
}

class DetailScreen extends StatelessWidget {
  final Todo _todo;

  DetailScreen({Key key, @required Todo todo})
      : assert(todo != null),
        this._todo = todo,
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(_todo.title),
      ),
      body:
          Padding(padding: EdgeInsets.all(16), child: Text(_todo.description)));
}
