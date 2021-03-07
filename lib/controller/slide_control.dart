import 'package:flutter/material.dart';

AnimationController slideController; //Props rotation (empty)
enum AnimPropSlide { opacity }

// ignore: must_be_immutable
class SlideController extends StatefulWidget {
  @override
  _SlideControllerState createState() => _SlideControllerState();
}

class _SlideControllerState extends State<SlideController>
    with TickerProviderStateMixin {
  Animation<double> slideAnimation;
  AnimationController slideController;
  double progress = 0;
  double multiple = 1;
  double opacity = 1;
  double interval(double lower, double upper, double _progress) {
    assert(lower < upper);
    if (_progress > upper) return 1.0;
    if (_progress < lower) return 0.0;
    return ((_progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    slideController = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
    );
    slideAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(slideController)
          ..addListener(() {
            setState(() {
              progress = slideAnimation.value;
              multiple = 1 - interval(0.0, 0.6, progress);
              opacity = multiple;
            });
          });
    return Opacity(
      opacity: opacity,
    );
  }
}
