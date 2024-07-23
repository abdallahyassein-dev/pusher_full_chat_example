import 'package:flutter/material.dart';
import 'package:pusher_full_chat_example/core/constants.dart';
import 'package:pusher_full_chat_example/core/widgets/cached_image_widget.dart';
import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/audio_message.dart';
import 'package:url_launcher/url_launcher.dart';

class SenderMsgItemWidget extends StatelessWidget {
  const SenderMsgItemWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                width: Sizes.getWidth(context),
                decoration: const BoxDecoration(
                  color: Color(0xff168AFF),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
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
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text("Open File",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            ))
                        : message.type == "AUDIO"
                            ? AudioMessage(source: message.content.toString())
                            : Text(
                                message.content.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
              ),
              const SizedBox(
                height: 6,
              ),
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
        const SizedBox(width: 8),
        CachedImageWidget(
          imgUrl: message.sender!.avatar.toString(),
          radius: 150,
          height: 40,
          width: 40,
        ),
      ],
    );
  }
}
