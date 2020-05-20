import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Const.dart';

class TitleLabel extends StatelessWidget {
  final String label;

  /// Title used for content header ?
  final bool isHeader;

  TitleLabel({
    this.label = "", 
    this.isHeader = true
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label, style: new TextStyle(
        fontSize: titleFontSize,
        fontWeight: isHeader? FontWeight.w600 : FontWeight.bold
      )
    );
  }
}

class SubtitleLabel extends StatelessWidget {
  final String label;
  final Color color;

  SubtitleLabel({this.label = "",this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Text(
      label, style: new TextStyle(
        fontSize: subtitleFontSize,
        fontWeight: FontWeight.w300,
        color: color
      )
    );
  }
}