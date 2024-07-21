import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_full_chat_example/features/chat/cubit/chat_states.dart';
import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';
import 'package:pusher_full_chat_example/features/chat/repo/chat_repo.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  void getChatDetails(
      {required int? firstUser, required int? secondUser}) async {
    try {
      emit(state.copyWith(chatState: ChatStates.loading));

      ChatDetailsModel chatDetailsModel = await ChatRepo.getChatDetails(
          firstUser: firstUser, secondUser: secondUser);

      emit(state.copyWith(
          chatState: ChatStates.success, chatDetailsModel: chatDetailsModel));
    } catch (e) {
      emit(state.copyWith(
          exception: e.toString(), chatState: ChatStates.failure));
    }
  }

  void sendMessage(
      {File? file,
      String? content,
      required int roomId,
      required int? userId,
      String type = "TEXT"}) async {
    try {
      emit(state.copyWith(sendMessagesStates: SendMessagesStates.loading));

      await ChatRepo.sendMessage(
          file: file,
          content: content,
          roomId: roomId,
          userId: userId,
          type: type);
      emit(state.copyWith(sendMessagesStates: SendMessagesStates.success));
    } catch (e) {
      emit(state.copyWith(
          exception: e.toString(),
          sendMessagesStates: SendMessagesStates.failure));
    }
  }
}
