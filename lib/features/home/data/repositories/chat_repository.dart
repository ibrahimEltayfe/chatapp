import 'dart:async';
import 'dart:developer';
import 'package:chatapp/core/network_info/network_checker.dart';
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserChatIds(){
    final chatIds = chatRemote.getUserChatIds();

    return chatIds.asyncMap((ids){
      return ids;
    });
  }

  Future<List<ChatModel>> getChats(List userChatIds) async{
    /*if(await networkInfo.isConnected) {
      yield const Left(NoInternetFailure(AppErrors.noInternet));
      return;
    }*/


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

    List<MessageModel> dataToReturn = [];

    final chats = chatRemote.getChatMessages(chatId);

    await for (QuerySnapshot<MessageModel> q in chats){

      for (var doc in q.docs) {
        dataToReturn.add(doc.data());
      }

      yield dataToReturn;
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