import 'package:flutter/material.dart';

class OrientationHandler extends StatelessWidget {
  final Widget portrait;
  final Widget landScape;

  const OrientationHandler({Key? key, required this.portrait, required this.landScape, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if(orientation == Orientation.portrait){
        return portrait;
      }else{
        return landScape;
      }
    },);
  }
}
