import 'package:flutter/material.dart';

extension MediaQuerySize on BuildContext{
  double get width => MediaQuery.of(this).orientation == Orientation.landscape
      ?MediaQuery.of(this).size.height
      :MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).orientation == Orientation.landscape
      ?MediaQuery.of(this).size.width
      :MediaQuery.of(this).size.height;

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
}