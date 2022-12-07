import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class DecidePage extends StatelessWidget {
  const DecidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_,AsyncSnapshot<User?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.data?.uid != null){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              });
            }else{
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              });
            }
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        }

    );
  }
}
