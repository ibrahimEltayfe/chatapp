import 'dart:async';
import 'dart:developer';
import 'package:chatapp/core/utils/network_checker.dart';
import 'package:chatapp/features/home/data/models/chat_model.dart';
import 'package:chatapp/features/home/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_errors.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/chat_remote.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final networkInfoRef = ref.read(networkInfoProvider);
  final chatRemoteRef = ref.read(chatRemoteProvider);
  return ChatRepository(networkInfoRef,chatRemoteRef);
});

class ChatRepository{
  final NetworkInfo networkInfo;
  final ChatRemote chatRemote;
  ChatRepository(this.networkInfo, this.chatRemote);

  Stream<List<dynamic>> getUserChatIds() async*{
    final chatIds = chatRemote.getUserChatIds();
    await for(DocumentSnapshot<Map<String, dynamic>> ids in chatIds){
      yield ids.data()!['chats'] as List<dynamic>;
    }
  }

  Future<List<ChatModel>> getChats(List<String> userChatIds) async{
    final chats = await chatRemote.getUserChats(userChatIds);
    return chats.docs.map((chat){
      return chat.data();
    }).toList();


/*
    List<ChatModel> dataToReturn = [];

    return chats.asyncMap((chat){
        for (var doc in chat.docs) {
          dataToReturn.add(doc.data());
        }
        return dataToReturn;
      });*/

  }

  Stream<List<MessageModel>> getChatMessages(String chatId) async*{
    final chats = chatRemote.getChatMessages(chatId);

    await for (QuerySnapshot<MessageModel> q in chats){
      List<MessageModel> messages = [];

      for (QueryDocumentSnapshot<MessageModel> doc in q.docs) {
        messages.add(doc.data());
      }

      yield messages;
    }

  }

  Future<Either<Failure, resultType>> _handleFailures<resultType>(Future<resultType> Function() task) async{
    if(await networkInfo.isConnected) {
      try{
        final resultType result = await task();
        return Right(result);
      }catch(e){
        log(e.toString());
        return Left(ExceptionHandler.handle(e).failure);
      }
    }else{
      return const Left(NoInternetFailure(AppErrors.noInternet));
    }
  }
}