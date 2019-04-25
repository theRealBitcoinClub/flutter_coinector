import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Wordpress App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new BlinkAnimation(),
    );
  }
}

class BlinkAnimation extends StatefulWidget {
  @override
  _BlinkAnimationState createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Blink Animation'),
      ),
      body: new Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
              child: new RaisedButton(
                color: animation.value,
                onPressed: () {
                  controller.forward();
                },
                child: Text('Blink Animation'),
              ),
            );
          },
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}