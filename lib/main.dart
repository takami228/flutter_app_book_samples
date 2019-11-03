import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Navigation',
      home: Scaffold(
        appBar: AppBar(title: Text('TapBox')),
        body: Center(
          //子で管理するパターン
          //child: TapBoxA(),
          //親で管理するパターン
          //child: ParentWidget(),
          //親で管理するパターン
          child: ParentChildrenWidget(),
        ),
      ),
    ));

//ウィジェット自身が状態を管理するパターン
class TapBoxA extends StatefulWidget {
  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(
          _active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        )),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ));

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }
}

//親ウィジェットが状態を管理するパターン
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => Container(
      // 親が管理するパターン
      child: TapBoxB(active: _active, onChanged: _handleTapBoxChanged));

  //child: TapBoxC(active: _active, onChanged: _handleTapBoxChanged));

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({Key key, this.active: false, @required this.onChanged})
      : assert(active != false),
        assert(onChanged != null),
        super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(
          active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        )),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ));

  void _handleTap() {
    onChanged(!active);
  }
}

//親と子の両方で管理するケース
class ParentChildrenWidget extends StatefulWidget {
  @override
  _ParentChildrenWidgetState createState() => _ParentChildrenWidgetState();
}

class _ParentChildrenWidgetState extends State<ParentChildrenWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => Container(
      child: TapBoxC(active: _active, onChanged: _handleTapBoxChanged));

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }
}

class TapBoxC extends StatefulWidget {
  TapBoxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapBoxCState createState() => _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(
          widget.active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        )),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(color: Colors.teal[700], width: 10.0)
              : null,
        ),
      ));

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }
}
