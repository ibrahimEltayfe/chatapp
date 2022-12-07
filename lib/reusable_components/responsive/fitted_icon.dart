import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FittedIcon extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  final Color color;
  const FittedIcon(this.icon,{Key? key, required this.height, required this.width , required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: FittedBox(
            child: FaIcon(icon,color: color)
        )
    );
  }
}
