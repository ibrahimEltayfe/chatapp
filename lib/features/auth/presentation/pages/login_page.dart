import 'dart:developer';
import 'package:chatapp/core/constants/app_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:chatapp/core/constants/app_colors.dart';
import 'package:chatapp/core/constants/app_images.dart';
import 'package:chatapp/core/constants/app_routes.dart';
import 'package:chatapp/core/extensions/mediaquery_size.dart';
import 'package:chatapp/features/auth/presentation/manager/auth_riverpod.dart';
import 'package:chatapp/l10n/app_localizations.dart';
import 'package:chatapp/reusable_components/responsive/orientation_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: OrientationHandler(
          portrait: PortraitLogin(),
          landScape: LandscapeLogin(),
        ),
      ),
    );
  }
}

class PortraitLogin extends StatelessWidget {
  const PortraitLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30,),
          const _BuildImage(),

          SizedBox(height: 60,),
          _BuildGoogleLoginButton()

        ],
      ),
    );
  }
}

class LandscapeLogin extends StatelessWidget {
  const LandscapeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          SizedBox(width: 25,),
          Flexible(child: const _BuildImage()),

          SizedBox(width: 60,),
          Flexible(child: _BuildGoogleLoginButton())
          
        ],
      ),
    );
  }
}

class _BuildImage extends StatelessWidget {
  const _BuildImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isLandscape?0:10,
        vertical: context.isLandscape?10:0,
      ),
      child: SizedBox(
          width: context.width,
          height: 400,
          child: SvgPicture.asset(AppImages.login,)
      ),
    );
  }
}

class _BuildGoogleLoginButton extends ConsumerWidget {
  const _BuildGoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    ref.listen(authProvider, (previous, current) {
      if(current is AuthError){
        Fluttertoast.showToast(msg: current.message);
      }else if(current is AuthLoggedIn){
        Navigator.pushNamed(context, AppRoutes.home);
      }
    });

    if(auth is AuthLoading){
      return Lottie.asset(
        'assets/lottie/google_loading.json',
        alignment: Alignment.center,
        width: context.width*0.5,
        height: context.height*0.1
      );
    }

    return ElevatedButton(
        onPressed: (){
          ref.read(authProvider.notifier).signInWithGoogle();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.ovRed),
          fixedSize: MaterialStateProperty.all<Size>(Size(345,68))
        ),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Flexible(
              child: SizedBox(
                width: 35,
                height: double.infinity,
                child: const FittedBox(child: FaIcon(FontAwesomeIcons.google),),
              ),
            ),

            SizedBox(width: context.width*0.032,),

            Flexible(
              flex: 5,
              child: FittedBox(
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: getBoldTextStyle(
                    color: AppColors.white,
                    fontSize: 40
                  ),
                ),
              ),
            ),

            SizedBox(width: context.width*0.02,),
            
          ],
        ),
    );
  }
}

