import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts.dart';
import 'package:simple_animations/simple_animations.dart';

class RotationController extends StatefulWidget {
  @override
  _RotationControllerState createState() => _RotationControllerState();
}

class _RotationControllerState extends State<RotationController>
    with TickerProviderStateMixin {
  int index;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _controller.loop();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.25,
      child: RotationTransition(
        turns: Tween(begin: 0.1, end: 1 * pi).animate(_controller),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.transparent,
          child: Image.asset(
            ConstsApp.whitePokeball,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
