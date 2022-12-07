part of 'chat_riverpod.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFetched extends ChatState {
  final List<ChatModel> chatModels;
  const ChatFetched(this.chatModels);

  @override
  List<Object> get props => [chatModels];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}