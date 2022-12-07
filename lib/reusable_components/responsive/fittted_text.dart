import 'package:flutter/material.dart';

class FittedText extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final TextStyle textStyle;
  final Alignment? alignment;
  const FittedText(this.text,{Key? key, required this.height, required this.width, required this.textStyle, this.alignment, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: FittedBox(
            alignment: alignment??Alignment.center,
            child: Text(
              text,
              style: textStyle,
            )
        )
    );
  }
}
