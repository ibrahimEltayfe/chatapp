import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

const List<Condition> isDesktop =[
  Condition.largerThan(name: TABLET,value: 40),
];

const List<Condition> isMobileTablet =[
  Condition.smallerThan(name: DESKTOP,),
];

bool isSmallerThanDesktop(BuildContext context){
  return ResponsiveWrapper.of(context).isSmallerThan(DESKTOP);
}
