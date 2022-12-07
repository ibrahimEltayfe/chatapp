import 'dart:developer';
import 'package:chatapp/core/constants/app_colors.dart';
import 'package:chatapp/core/constants/app_styles.dart';
import 'package:chatapp/core/extensions/mediaquery_size.dart';
import 'package:chatapp/features/home/data/models/chat_model.dart';
import 'package:chatapp/features/home/presentation/manager/chat_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../core/constants/responsive_conditions.dart';
import '../../data/models/message_model.dart';

class Chats extends ConsumerWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final chats = ref.watch(chatProvider);

    /*ref.listen(chatProvider, (previous, next) {
      if(chats is ChatError){
        Fluttertoast.showToast(msg: chats.message);
      }
    });*/

    return StreamBuilder(
      stream: ref.read(chatProvider.notifier).fetchUserChatIds(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
        }

        if(snapshot.data == null || snapshot.data?.data()?['chats'].isEmpty){
          return Text("No Data");
        }

        List ids = snapshot.data?.data()?['chats'] ?? [];

        return FutureBuilder<List<ChatModel>>(
            future: ref.read(chatProvider.notifier).fetchChats(ids),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
              }

              if(snapshot.data == null){
                return const Center(child: Text("No Data"),);
              }

              final chatsData = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: chatsData.length,
                  itemBuilder: (context, i) {
                    return StreamBuilder<List<MessageModel>>(
                      stream: ref.read(chatProvider.notifier).fetchMessages(chatsData[i].chatId??''),
                      builder: (context, snapshot) {
                        if(snapshot.data != null && snapshot.data!.isNotEmpty){

                          final lastMessage = snapshot.data!.last;

                          return Container(
                            width: context.width,
                            height: 100,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColors.lightGrey, width: 1),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                  height: 120,
                                  child: _BuildImageAvatar(),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const _BuildReceiverName(name:"ibrahim ezz"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _BuildLastMessage(lastMessage.text??''),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  width: 5,
                                ),

                                ResponsiveConstraints(
                                  constraint: const BoxConstraints.tightFor(
                                      width: 65,height: 100
                                  ),

                                  constraintsWhen: const [
                                    Condition.largerThan(
                                        name: TABLET,
                                        value: BoxConstraints.tightFor(
                                            width:120,
                                            height:65
                                        )
                                    )
                                  ],

                                  child: ResponsiveRowColumn(
                                    layout:isSmallerThanDesktop(context)
                                        ? ResponsiveRowColumnType.COLUMN
                                        : ResponsiveRowColumnType.ROW,

                                    columnMainAxisAlignment: MainAxisAlignment.start,
                                    columnCrossAxisAlignment: CrossAxisAlignment.center,

                                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                                    rowMainAxisAlignment: MainAxisAlignment.start,

                                    rowPadding: EdgeInsets.symmetric(horizontal: 10),
                                    columnPadding: const EdgeInsets.only(top: 26, left: 8,right: 10),

                                    columnSpacing: 10,
                                    rowSpacing: 10,

                                    children: const [
                                      ResponsiveRowColumnItem(
                                          rowFlex: 1,
                                          rowOrder: 1,
                                          child: _BuildLastMessageTime()
                                      ),

                                      ResponsiveRowColumnItem(
                                        rowOrder: 0,
                                        rowFlex: 1,
                                        child: _BuildUnSeenMessageNumber(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();


                      },
                    );
                  },
                ),
              );
            },

          );
      }
    );
  }
}

class _BuildImageAvatar extends StatelessWidget {
  const _BuildImageAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // image
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/avatars/avatar1.jpg'),
            ),
          ),
        ),

        //is online badge
        Positioned(
          bottom: 15,
          right: 2,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white),
            ),
          ),
        )
      ],
    );
  }
}

class _BuildReceiverName extends StatelessWidget {
  final String name;
  const _BuildReceiverName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        name,
        style: getBoldTextStyle(fontSize: 20),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _BuildLastMessage extends StatelessWidget {
  final String lastMessage;
  const _BuildLastMessage(this.lastMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        lastMessage,
        style: getRegularTextStyle(fontSize: 17),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _BuildLastMessageTime extends StatelessWidget {
  const _BuildLastMessageTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "14:30",
      maxLines: 1,
      style: getBoldTextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      softWrap: false,
      overflow: TextOverflow.visible,
    );
  }
}

class _BuildUnSeenMessageNumber extends StatelessWidget {
  const _BuildUnSeenMessageNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.white),
      ),
      child: Text(
        "2",
        style: getBoldTextStyle(
          color: AppColors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.clip,
      ),
    ));
  }
}
