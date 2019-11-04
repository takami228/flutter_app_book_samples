import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: LogoApp());
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addStatusListener(_onAnimationStatusChanged);
    animation = Tween<double>(begin: 0.1, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GrowTransition(
        animation: animation,
        child: LogoWidget(),
      );

  void _onAnimationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      default:
    }
  }
}

class GrowTransition extends StatelessWidget {
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  GrowTransition({Key key, this.child, this.animation})
      : assert(child != null),
        assert(animation != null),
        super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: AnimatedBuilder(
                animation: animation,
                child: child,
                builder: (context, child) => Opacity(
                    opacity: animation.value,
                    child: Container(
                        height: _sizeTween.evaluate(animation),
                        width: _sizeTween.evaluate(animation),
                        child: child)))),
      );
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}
