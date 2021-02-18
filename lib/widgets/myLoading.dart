import 'package:flutter/material.dart';

class MyLoading extends StatefulWidget {
  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> with SingleTickerProviderStateMixin {

  AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: CircularProgressIndicator(
        strokeWidth: 8,
        // backgroundColor: Colors.yellow,
        // valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
        valueColor: animationController.drive(ColorTween(begin: Colors.red, end: Colors.green)),
      ),
    );
  }
}
