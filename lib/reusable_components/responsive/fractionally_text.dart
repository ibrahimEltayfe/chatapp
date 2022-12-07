import 'package:flutter/material.dart';

class FractionallyText extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;
  final String text;
  final TextStyle textStyle;
  final Alignment? alignment;
  const FractionallyText(this.text,{Key? key, required this.heightFactor, required this.widthFactor, required this.textStyle, this.alignment, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: alignment ?? Alignment.centerLeft ,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: FittedBox(
            alignment: alignment ?? Alignment.center,
            child: Text(text,style: textStyle)
        )
    );
  }
}
