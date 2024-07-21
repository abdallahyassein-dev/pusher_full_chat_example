// To parse this JSON data, do
//
//     final chatDetailsModel = chatDetailsModelFromJson(jsonString);

import 'dart:convert';

ChatDetailsModel chatDetailsModelFromJson(str) =>
    ChatDetailsModel.fromJson(str);

String chatDetailsModelToJson(ChatDetailsModel data) =>
    json.encode(data.toJson());

class ChatDetailsModel {
  Chats? chats;
  List<Message>? messages;

  ChatDetailsModel({
    this.chats,
    this.messages,
  });

  factory ChatDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChatDetailsModel(
        chats: json["chats"] == null ? null : Chats.fromJson(json["chats"]),
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chats": chats?.toJson(),
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Chats {
  int? roomId;

  Chats({
    this.roomId,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        roomId: json["room_id"],
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
      };
}

class Message {
  int? id;
  Sender? sender;
  String? content;
  String? type;
  String? sentAt;

  Message({
    this.id,
    this.sender,
    this.content,
    this.type,
    this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"],
        type: json["type"],
        sentAt: json["sent_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender?.toJson(),
        "content": content,
        "type": type,
        "sent_at": sentAt,
      };
}

class Sender {
  int? id;
  int? roleId;
  String? name;
  String? email;
  String? avatar;
  dynamic emailVerifiedAt;
  Settings? settings;
  DateTime? createdAt;
  DateTime? updatedAt;

  Sender({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.avatar,
    this.emailVerifiedAt,
    this.settings,
    this.createdAt,
    this.updatedAt,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        emailVerifiedAt: json["email_verified_at"],
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "email_verified_at": emailVerifiedAt,
        "settings": settings?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Settings {
  String? locale;

  Settings({
    this.locale,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "locale": locale,
      };
}
