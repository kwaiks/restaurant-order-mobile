import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final String direction;

  static getDirection(String direction){
    switch(direction){
      case 'right':
      return const Offset(1,0);
      case 'left':
      return const Offset(-1,0);
      case 'top':
      return const Offset(0,1);
      case 'bottom':
      return const Offset(0,1);
      default:
      return Offset.zero;
    }
  }

  SlideRoute({this.page,this.direction='right'})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: getDirection(direction),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}

class Scale extends PageRouteBuilder {
  final Widget page;
  final Curve curve;
  Scale({this.page, this.curve})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  ),
                ),
                child: child,
              ),
        );
}

class Size extends PageRouteBuilder {
  final Widget page;
  Size({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child
          ) =>
              Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              ),
              
        );
}

class Fade extends PageRouteBuilder {
  final Widget page;
  Fade({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        );
}