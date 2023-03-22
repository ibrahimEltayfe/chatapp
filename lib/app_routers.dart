import 'package:chatapp/features/auth/presentation/pages/login_page.dart';
import 'package:chatapp/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'core/constants/app_routes.dart';
import 'features/auth/presentation/pages/decide_page.dart';
import 'features/home/presentation/pages/home.dart';

class RoutesManager{

  static Route<dynamic> routes(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (_)=> Home(),
            settings: settings
        );

      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_)=> LoginPage(),
                //LoginPage(),
            settings: settings
        );

      case AppRoutes.decide:
        return MaterialPageRoute(
            builder: (_)=> DecidePage(),
            settings: settings
        );

      case AppRoutes.chat:
        return MaterialPageRoute(
            builder: (_)=> ChatPage(chatId:settings.arguments as String),
            settings: settings
        );


      default: return MaterialPageRoute(
          builder: (_)=> UnExcepectedErrorPage(),
          settings: settings
      );
    }

  }
}

//todo:
class UnExcepectedErrorPage extends StatelessWidget {
  const UnExcepectedErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('UnExcepectedErrorPage'),
    );
  }
}
