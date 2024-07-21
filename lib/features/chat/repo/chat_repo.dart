import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pusher_full_chat_example/core/dio_helper.dart';
import 'package:pusher_full_chat_example/core/end_points.dart';
import 'package:pusher_full_chat_example/features/chat/models/chat_details_model.dart';

class ChatRepo {
  static Future<ChatDetailsModel> getChatDetails(
      {required int? firstUser, required int? secondUser}) async {
    var res = await DioHelper.postData(
        url: ApiEndPoints.provideRoom,
        data: {"first_user": firstUser, "second_user": secondUser});
    ChatDetailsModel chatDetailsModel = chatDetailsModelFromJson(res.data);
    return chatDetailsModel;
  }

  static sendMessage(
      {File? file,
      String? content,
      required int roomId,
      required int? userId,
      String type = "TEXT"}) async {
    Map<String, dynamic> data = {"user_id": userId, "type": type};

    FormData formData = FormData.fromMap(data);

    if (content != null) {
      formData.fields.add(MapEntry("content", content));
    }
    if (file != null) {
      formData.files.add(
        MapEntry(
            "file",
            await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last)),
      );
    }

    await DioHelper.postData(
        url: "${ApiEndPoints.rooms}/$roomId${ApiEndPoints.send}",
        data: formData);
  }
}
