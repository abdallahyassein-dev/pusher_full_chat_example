import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';

enum ChatStates { initial, loading, success, failure }

enum SendMessagesStates { initial, loading, success, failure }

class ChatState {
  final ChatStates chatState;
  final SendMessagesStates sendMessagesStates;
  final ChatDetailsModel? chatDetailsModel;
  final String? exception;

  ChatState(
      {this.chatState = ChatStates.initial,
      this.sendMessagesStates = SendMessagesStates.initial,
      this.chatDetailsModel,
      this.exception});

  ChatState copyWith(
      {ChatStates? chatState,
      SendMessagesStates? sendMessagesStates,
      ChatDetailsModel? chatDetailsModel,
      String? exception}) {
    return ChatState(
        chatState: chatState ?? this.chatState,
        sendMessagesStates: sendMessagesStates ?? this.sendMessagesStates,
        chatDetailsModel: chatDetailsModel ?? this.chatDetailsModel,
        exception: exception ?? this.exception);
  }
}
