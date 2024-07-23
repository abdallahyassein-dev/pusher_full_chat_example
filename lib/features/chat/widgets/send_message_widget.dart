import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pusher_full_chat_example/core/constants.dart';
import 'package:pusher_full_chat_example/core/main_services.dart';
import 'package:pusher_full_chat_example/core/widgets/app_text_form_field.dart';
import 'package:pusher_full_chat_example/features/chat/cubit/chat_cubit.dart';
import 'package:pusher_full_chat_example/features/chat/widgets/audio_recorder.dart';

class SendMessageWidget extends StatefulWidget {
  final int roomId;
  final int userId;
  const SendMessageWidget(
      {super.key, required this.roomId, required this.userId});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  File? currentSelectedImage;

  File? currentAudioFile;
  File? currentSelectedFile;
  TextEditingController messageController = TextEditingController();

  bool showAudioRecorder = false;

  late ChatCubit chatCubit;

  @override
  void initState() {
    chatCubit = ChatCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentSelectedFile != null || currentSelectedImage != null
            ? const SizedBox(
                height: 35,
              )
            : const SizedBox.shrink(),
        currentSelectedFile != null || currentSelectedImage != null
            ? Container(
                width: Sizes.getWidth(context),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentSelectedImage == null
                        ? const SizedBox.shrink()
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  currentSelectedImage!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentSelectedImage = null;
                                        });
                                      },
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          )))),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    currentSelectedFile == null
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentSelectedFile = null;
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ))),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.file_copy_outlined,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        currentSelectedFile!.path!
                                            .split("/")
                                            .last
                                            .toString()!,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              )
            : const SizedBox.shrink(),
        currentSelectedFile != null
            ? const SizedBox(
                height: 35,
              )
            : const SizedBox.shrink(),
        showAudioRecorder
            ? SizedBox(
                height: 200,
                child: AudioRecorderWidget(onStop: (audioPath) {
                  log(audioPath.toString());
                  if (audioPath.isNotEmpty) {
                    currentAudioFile = File(audioPath);

                    chatCubit.sendMessage(
                        type: MESSAGETYPE.AUDIO,
                        userId: widget.userId,
                        roomId: widget.roomId,
                        file: currentAudioFile);
                  }

                  setState(() {
                    showAudioRecorder = false;
                  });
                }),
              )
            : SizedBox.shrink(),
        Container(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 28),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  horizontalPadding: 0,
                  hintText: "Message ..",
                  textInputType: TextInputType.text,
                  controller: messageController,
                  borderRadius: 15,
                  backgroundColor: const Color.fromARGB(255, 239, 247, 252),
                  suffixIcon: SizedBox(
                    width: Sizes.getWidth(context) * 0.16,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            currentSelectedImage =
                                await MainServices.getImageUsingImagePicker(
                                    ImageSource.gallery);
                            if (currentSelectedImage != null) {
                              setState(() {});
                            }
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.blueAccent,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () async {
                              currentSelectedFile =
                                  await MainServices.pickDocumentFile();
                              if (currentSelectedFile != null) {
                                setState(() {});
                              }
                            },
                            child: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showAudioRecorder = !showAudioRecorder;
                  });
                },
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  if (currentSelectedFile != null) {
                    chatCubit.sendMessage(
                        type: MESSAGETYPE.FILE,
                        userId: widget.userId,
                        roomId: widget.roomId,
                        file: currentSelectedFile!);
                  }
                  if (currentSelectedImage != null) {
                    chatCubit.sendMessage(
                        type: MESSAGETYPE.IMAGE,
                        userId: widget.userId,
                        roomId: widget.roomId,
                        file: currentSelectedImage!);
                  }

                  if (messageController.text.isNotEmpty) {
                    chatCubit.sendMessage(
                        type: MESSAGETYPE.TEXT,
                        userId: widget.userId,
                        roomId: widget.roomId,
                        content: messageController.text);
                  }

                  messageController.clear();
                  currentSelectedFile = null;
                  currentSelectedImage = null;
                  setState(() {});
                },
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.send_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
