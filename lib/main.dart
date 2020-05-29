import 'package:animated_builder/images.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF832685),
        primaryColorLight: Color(0xFFC81379),
        accentColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = 'AnimatedBuilder';

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    final _curvedAnimation = CurvedAnimation(
        curve: Curves.elasticIn,
        parent: _animationController,
        reverseCurve: Curves.elasticOut);

    _animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(_curvedAnimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: RotatingTransition(
        angle: _animation,
        child: MainImage(),
      ),
    );
  }
}

class MainImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Image(
          image: AssetImage(gamora),
        ),
      ),
    );
  }
}

class RotatingTransition extends StatelessWidget {
  RotatingTransition({
    @required this.child,
    @required this.angle,
  });

  final Widget child;
  final Animation<double> angle;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: angle,
      child: child,
      builder: (context, child) {
        return Transform.rotate(angle: angle.value, child: child);
      },
    );
  }
}
