import 'package:chatapp/core/constants/app_colors.dart';
import 'package:chatapp/core/constants/app_icons.dart';
import 'package:chatapp/core/constants/app_styles.dart';
import 'package:chatapp/core/extensions/mediaquery_size.dart';
import 'package:chatapp/features/home/presentation/manager/chat_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../home/data/models/message_model.dart';

class ChatPage extends ConsumerWidget {
  final String chatId;
  const ChatPage({
    required this.chatId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: context.width,
              height: context.height*0.1,
              child: Row(
                children: [
                  SizedBox(width: 10,),

                  FaIcon(AppIcons.back),

                  SizedBox(width: 15,),

                  Container(
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/avatars/avatar1.jpg'),
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: Text(
                      "Ibrahim Ezz",
                      style: getBoldTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),

            Expanded(child: _BuildBody(chatId)),

          ],

        ),
      ),
    );
  }
}

class _BuildBody extends ConsumerWidget {
  final String chatId;
  const _BuildBody(this.chatId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  StreamBuilder<List<MessageModel>>(
      stream: ref.read(chatProvider.notifier).fetchMessages(chatId),
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.data!.isNotEmpty){
          return ListView.builder(
            itemCount:snapshot.data!.length ,
            itemBuilder: (context, index) {
              if(snapshot.data![index].senderId == FirebaseAuth.instance.currentUser!.uid){
                return _BuildMyMessage(message: snapshot.data![index].text??'',);
              }else{
                return _BuildReceiverMessage(message: snapshot.data![index].text??'',);
              }

            },
          );
        }

        return const SizedBox.shrink();

      },
    );
  }
}

class _BuildMyMessage extends StatelessWidget {
  final String message;
  const _BuildMyMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
        child: Container(
            constraints: BoxConstraints(
                maxWidth: context.width*0.75
            ),
            decoration: messageContainerDecoration(
                color: AppColors.lightBlue,
                isSender: true
            ),
            padding: const EdgeInsets.all(14),
            child: Text(
              message,
              style: getRegularTextStyle(),
              textAlign: TextAlign.center,
            )
        ),
      ),
    );
  }
}

class _BuildReceiverMessage extends StatelessWidget {
  final String message;
  const _BuildReceiverMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
        child: Container(
          constraints: BoxConstraints(
             maxWidth: context.width*0.75
           ),
         decoration: messageContainerDecoration(
           color: AppColors.skyBlue,
           isSender: false
         ),
          padding: const EdgeInsets.all(14),
          child: Text(
            message,
            style: getRegularTextStyle(),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}
