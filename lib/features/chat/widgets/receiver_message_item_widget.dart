import 'package:flutter/material.dart';
import 'package:pusher_full_chat_example/core/constants.dart';
import 'package:pusher_full_chat_example/core/widgets/cached_image_widget.dart';
import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/audio_message.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiverMsgItemWidget extends StatelessWidget {
  final Message message;
  const ReceiverMsgItemWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImageWidget(
          imgUrl: message.sender!.avatar.toString(),
          radius: 100,
          height: 40,
          width: 40,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                width: Sizes.getWidth(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: message.type == "IMAGE"
                    ? CachedImageWidget(
                        imgUrl: message.content.toString(),
                        height: Sizes.getHeight(context) * 0.2,
                        width: 30,
                        fit: BoxFit.fill,
                      )
                    : message.type == "FILE"
                        ? InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(message.content.toString()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Open File",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ))
                        : message.type == "AUDIO"
                            ? AudioMessage(source: message.content.toString())
                            : Text(
                                message.content.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
              ),
              const SizedBox(height: 6),
              Text(
                message.sentAt.toString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
