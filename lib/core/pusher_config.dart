// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:http/http.dart' as http;

class PusherConfig {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  late PusherChannelsFlutter _pusher;

  String APP_ID = "1835492";
  String API_KEY = "2485bd604e8accfb509a";
  String SECRET = "f0b78060be9b5cf4e785";
  String API_CLUSTER = "eu";

  Future<void> initPusher(onEvent, {channelName = "chat.room", roomId}) async {
    _pusher = PusherChannelsFlutter.getInstance();

    try {
      await _pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        //authEndpoint: "${ApiEndPoints.baseUrlPusher}/broadcasting/auth",
        // onAuthorizer: onAuthorizer,
      );

      try {
        await _pusher.subscribe(
          channelName: "$channelName.$roomId",
        );

        log("trying to subscribe to :  $channelName.$roomId");
      } catch (e) {
        log(e.toString());
      }

      await _pusher.connect();
    } catch (e) {
      log("error in initialization: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  // dynamic onAuthorizer(
  //     String channelName, String socketId, dynamic options) async {
  //   log(socketId.toString());
  //   // ignore: prefer_typing_uninitialized_variables
  //   var json;
  //   try {
  //     var authUrl = ApiEndPoints.pusherAuthBaseUrl;
  //     log('socket_id=' + socketId + '&channel_name=' + channelName);
  //     UserData userData = await StorageHelper.getUserData();
  //     var result = await http.post(
  //       Uri.parse(authUrl),
  //       headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         'Authorization': 'Bearer ${userData.token}',
  //       },
  //       body: 'socket_id=' + socketId + '&channel_name=' + channelName,
  //     );
  //     log("result: " + result.body.toString());
  //     try {
  //       json = jsonDecode(result.body);
  //     } catch (e) {
  //       return {};
  //     }

  //     log(json.toString());

  //     return json;
  //   } catch (e) {
  //     log("Error :" + e.toString());
  //   }
  // }
}
