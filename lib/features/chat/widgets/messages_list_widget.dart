import 'package:flutter/widgets.dart';
import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/receiver_message_item_widget.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/send_message_widget.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/sender_message_item_widget.dart';

class MessagesListWidget extends StatelessWidget {
  const MessagesListWidget({
    super.key,
    required this.scrollController,
    required this.chatDetailsModel,
    required this.currentUser,
  });

  final ScrollController scrollController;
  final ChatDetailsModel? chatDetailsModel;
  final int currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            itemCount: chatDetailsModel!.messages!.length,
            itemBuilder: (context, i) {
              Message message = chatDetailsModel!.messages![i];
              if (currentUser != message.sender!.id) {
                return ReceiverMsgItemWidget(
                  message: message,
                );
              } else {
                return SenderMsgItemWidget(
                  message: message,
                );
              }
            }),
      ),
      SendMessageWidget(
        userId: currentUser,
        roomId: chatDetailsModel!.chats!.roomId!,
      ),
    ]);
  }
}
