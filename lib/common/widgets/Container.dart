import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Const.dart';

////Main Container that needs padding
class MainContainer extends StatelessWidget{
  final Widget child;

  MainContainer({this.child});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(contentPadding),
      child: child,
    );
  }
}

///Container for Content
class ContentContainer extends StatelessWidget {
  final Widget child;
  final bool horizontalPadding;

  ContentContainer({this.child, this.horizontalPadding = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: horizontalPadding
                   ? const EdgeInsets.symmetric(vertical:contentPadding, horizontal: contentPadding)
                   : const EdgeInsets.symmetric(vertical:contentPadding),
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: child,
        ),
        Separator()
      ],
    );
  }
}

/// Custom Separator
class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0,
      decoration: new BoxDecoration(
        color: Color(0XFFefefef),
      ),
    );
  }
}

class ItemSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      decoration: new BoxDecoration(
        color: Color(0XFFefefef),
      ),
    );
  }
}

class DashedSeparator extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraint){
        final dashWidth = 5.0;
        final dashCount = (constraint.constrainWidth()/ (2*dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_){
            return SizedBox(
              width: dashWidth,
              height: 1.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      }
    );
  }
}