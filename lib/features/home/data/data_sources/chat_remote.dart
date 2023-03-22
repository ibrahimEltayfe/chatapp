import 'dart:developer';

import 'package:chatapp/core/constants/app_errors.dart';
import 'package:chatapp/core/constants/end_points.dart';
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/features/home/data/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_model.dart';

final chatRemoteProvider = Provider<ChatRemote>((ref) {
  return ChatRemote();
});

class ChatRemote{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserChatIds(){
    final userId = _firebaseAuth.currentUser?.uid;

    if(userId == null){
      throw const NoUIDFailure(AppErrors.noUID);
    }

    return _fireStore.collection(EndPoints.users)
        .doc(userId)
        .snapshots();
  }

  Future<QuerySnapshot<ChatModel>> getUserChats(List userChatIds){
    if(_firebaseAuth.currentUser?.uid == null){
      throw const NoUIDFailure(AppErrors.noUID);
    }

     return _fireStore.collection(EndPoints.chats)
         .where('chatId' ,whereIn: userChatIds)
         .withConverter<ChatModel>(
       fromFirestore: (snapshot, options) {
         return ChatModel.fromJson(snapshot.data()!);
       },
       toFirestore: (value, options) {
         return {};//todo:
         //return ChatModel.toJson();
       },
     )
     .get();

  }
  
  Stream<QuerySnapshot<MessageModel>> getChatMessages(String chatId){
    if(_firebaseAuth.currentUser?.uid == null){
      throw const NoUIDFailure(AppErrors.noUID);
    }

    return _fireStore.collection(EndPoints.chats)
        .doc(chatId)
        .collection(EndPoints.messages)
        .orderBy('createdAt',descending: false)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            try{
              final a = MessageModel.fromJson(snapshot.data()!);
              log(a.toString());
            }catch(e){
              log(e.toString());

            }

            return MessageModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return {};//todo:
            //return MessageModel.toJson();
          },
         )
        .snapshots();
  }

}