import 'package:flutter/material.dart';

late AnimationController _animationController;
late Animation<double> _animation;

@override
void initState() {
  super.initState();
  
  _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  
  _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOut,
  );
}

@override
void dispose() {
  _animationController.dispose();
  super.dispose();
}