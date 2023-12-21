import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> AnimatedPageRouteBuilder(var resultRoute) {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (_, __, ___) => resultRoute,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
