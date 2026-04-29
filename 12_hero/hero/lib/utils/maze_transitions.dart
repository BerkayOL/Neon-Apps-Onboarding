import 'package:flutter/material.dart';

class MazeTransitions {
  // UP: Slide aşağıdan yukarıya kayma
  static Route slide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // RIGHT: ZoomSlide sağdan kayarken büyüme
  static Route zoomSlide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));
        return SlideTransition(
          position: animation.drive(slideTween),
          child: ScaleTransition(scale: animation, child: child),
        );
      },
    );
  }

  static Route page(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }

  // DOWN: Cover üstten aşağı tam kaplama
  static Route cover(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
