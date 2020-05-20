import 'package:flutter/material.dart';

class ClickableIcon extends StatelessWidget{
  final double size;
  final IconData icon;
  final VoidCallback onTap;
  ClickableIcon({this.size,this.icon,this.onTap});
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
          child: Container(
        alignment: Alignment.center,
        width: size + 10,
        height: size + 10,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
        child: Icon(icon, color: Colors.white, size:size),
      ),
    );
  }
}