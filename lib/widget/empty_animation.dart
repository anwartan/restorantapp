import 'package:flutter/material.dart';
import 'dart:math';
class AnimationPage extends StatefulWidget {
  final String message;
  final IconData? icon;
  AnimationPage({required this.message,this.icon});
  @override
  _AnimationPageState createState() => _AnimationPageState();
}
 
class _AnimationPageState extends State<AnimationPage> {
  double _size = 100.0;
  
  Tween<double> _animationTween = Tween<double>(begin: 0, end: pi * 2);
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
                    tween: _animationTween,
                    duration: Duration(seconds: 3),
                    builder: (context, double value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: Icon(widget.icon??Icons.error,color: Colors.green,size: _size,)
                      );
                    },
                  ),
          Text(widget.message,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}