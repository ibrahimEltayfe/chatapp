import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FractionallyIcon extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;
  final IconData icon;
  final Color color;
  const FractionallyIcon(this.icon,{Key? key, required this.heightFactor, required this.widthFactor, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: FittedBox(
            child: FaIcon(icon,color: color)
        )
    );
  }
}
