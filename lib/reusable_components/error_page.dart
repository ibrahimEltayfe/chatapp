import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatapp/core/extensions/mediaquery_size.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_styles.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.08 * context.width),
          child: Column(
            children: [
              SizedBox(height: context.height * 0.1,),
              //todo:add image
              Container(
                width: context.width * 0.95,
                height: context.height * 0.4,
                child: Placeholder(),
              ),

              SizedBox(height: context.height * 0.05,),

              SizedBox(
                width: context.width*0.9,
                height: context.height*0.1,
                child: AutoSizeText(
                    'This is An Error Message Message Message Message Message Message Message Message',
                    style: getRegularTextStyle(color:AppColors.red,fontSize: 30),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
