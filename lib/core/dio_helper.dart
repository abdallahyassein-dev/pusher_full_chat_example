// ignore_for_file: unused_catch_clause, deprecated_member_use

import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:pusher_full_chat_example/core/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          baseUrl: ApiEndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var res = await dio!.get(url, queryParameters: query);
    log("headers for this request :  $url ${dio!.options.headers}");
    log("response for this request :  $url ${res.data}");

    return res;
  }

  static deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? lang,
    String? token,
  }) async {
    try {
      dio!.options.headers = {
        'Authorization': token ?? '',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      log("deleting");
      log(url.toString());
      log(data.toString());

      var res = await dio!.delete(url, queryParameters: query, data: data);
      log("body: $data");
      log("response of the delete: ${res.data}");

      return res;
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<Response> postData(
      {required String url,
      dynamic data,
      String? lang,
      String? token,
      Map<String, dynamic>? query,
      bool withFiles = false}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': withFiles ? "multipart/form-data" : "application/json",
    };
    log("headers for this request : ${dio!.options.headers}");

    try {
      var res = await dio!.post(
        url,
        data: data,
        queryParameters: query,
      );

      log("i am in the post method :$res");

      return res;
    } on DioError catch (e) {
      log(e.response.toString());
      rethrow;
    }
  }

  static Future<Response> putData({
    required String url,
    dynamic data,
    String? lang,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    var res = await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );

    return res;
  }
}
