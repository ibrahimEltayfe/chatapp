import 'package:chatapp/core/constants/app_colors.dart';
import 'package:chatapp/core/constants/app_icons.dart';
import 'package:chatapp/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_value.dart';
import '../../../../core/constants/responsive_conditions.dart';
import '../widgets/chats.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        floatingActionButton: _FloatingActionButton(
          onTap: (){
          },
        ),

        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              ResponsiveVisibility(
                visible: true,
                hiddenWhen: isMobileTablet,

                replacement: _BuildNotificationBell(),

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Row(
                    children: const [
                      _BuildListIcon(),
                      Spacer(),
                      _BuildNotificationBell(),
                    ],
                  ),
                ),
              ),
              _BuildInboxText(),

              SizedBox(height: 20,),
              Chats()
            ],
          ),
        )
    );
  }
}

class _BuildListIcon extends StatelessWidget {
  const _BuildListIcon
      ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child:SizedBox(
          width: 28,
          height: 28,
          child: FittedBox(
            child: Icon(AppIcons.list,color: AppColors.black,),
          ),
        ),
      ),
    );
  }
}

class _BuildNotificationBell extends StatelessWidget {
  const _BuildNotificationBell({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo: notification number
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            width: 34,
            height: 40,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const FaIcon(AppIcons.notification,  color: AppColors.black,size: 40,),

                Positioned(
                    left: -4,
                    bottom: 4,

                    child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.ovRed
                      ),

                      child: FittedBox(
                        child: Text(
                          '2',
                          style: getBoldTextStyle(color: AppColors.white),
                        ),
                      ),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}

class _BuildInboxText extends StatelessWidget {
  const _BuildInboxText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SizedBox(
          height: 40,
          width: 120,
          child: FittedBox(
            alignment: Alignment.centerLeft,

            child: Text(
              'Inbox',
              style: getBoldTextStyle(),
            ),
          ),

        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FloatingActionButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,

      backgroundColor: AppColors.primaryColor,
      child: const Icon(
        AppIcons.add,
        color: AppColors.white,
      ),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<_BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: true,
      hiddenWhen: isDesktop,

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
            onTap: (i){
              setState((){
                currentIndex = i;
              });
            },
            elevation: 14,
            currentIndex: currentIndex,
            iconSize: 35,

            selectedItemColor: AppColors.primaryColor ,
            unselectedItemColor: AppColors.lightGrey,

            showSelectedLabels: false,
            showUnselectedLabels: false,

            items: [
              BottomNavigationBarItem(
                  icon: FaIcon(AppIcons.message),
                  label: ''
              ),

              BottomNavigationBarItem(
                  icon: FaIcon(AppIcons.profile),
                  label: ''
              ),
            ]

        ),
      ),
    );
  }
}