import 'dart:async';
import 'dart:developer';
import 'package:chatapp/features/home/data/models/chat_model.dart';
import 'package:chatapp/features/home/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/chat_repository.dart';
part 'chat_state.dart';

final chatProvider = StateNotifierProvider<ChatProvider,ChatState>((ref) {
  final chatRepositoryRef = ref.read(chatRepositoryProvider);
  return ChatProvider(chatRepositoryRef);
});


class ChatProvider extends StateNotifier<ChatState> {
  final ChatRepository chatRepository;
  ChatProvider(this.chatRepository) : super(ChatInitial());

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserChatIds() async*{
    yield* chatRepository.getUserChatIds();
  }

  Stream<List<MessageModel>> fetchMessages(String chatId) async*{
    yield* chatRepository.getChatMessages(chatId);
  }

  Future<List<ChatModel>> fetchChats(List userChatIds) async{
    return await chatRepository.getChats(userChatIds);

    /*.asyncMap(
      (event){
        event.fold(
         (failure){
           state = ChatError(failure.message);
         },
         (results){
           state = ChatFetched(results);
         });
      }
    );*/

  }
}
