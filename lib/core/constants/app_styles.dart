import 'package:flutter/material.dart';
import 'app_colors.dart';


TextStyle _getTextStyle(double fontSize, Color color,String fontFamily,FontWeight? fontWeight,TextDecoration? textDecoration){
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration,
  );
}

TextStyle getRegularTextStyle({
  double fontSize = 16,
  Color color = Colors.black,
  String fontFamily = 'sen',
  FontWeight? fontWeight,
  TextDecoration? textDecoration,
}) {
  return _getTextStyle(fontSize,color,fontFamily,fontWeight,textDecoration);
}

TextStyle getBoldTextStyle({
  double fontSize = 18,
  Color color = Colors.black,
  String fontFamily = 'sen',
  FontWeight fontWeight = FontWeight.bold,
  TextDecoration? textDecoration
}) {
  return _getTextStyle(fontSize,color,fontFamily,fontWeight,textDecoration);
}

//button styles
ButtonStyle getRegularButtonStyle({required Color bgColor,required double radius}){
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all<Color>(bgColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide.none
        )
    ),
    overlayColor:MaterialStateProperty.all<Color>(AppColors.white.withOpacity(0.05)),
  );
}

ButtonStyle getBorderedButtonStyle({required Color bgColor,required double radius}){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(bgColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: AppColors.grey)
          )
      ),
      elevation: MaterialStateProperty.all(0)
  );
}

ButtonStyle getDialogButtonStyle(bool isAllow){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(isAllow?AppColors.primaryColor:AppColors.lightGrey),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none
          )
      ),
      elevation: MaterialStateProperty.all(0)
  );
}