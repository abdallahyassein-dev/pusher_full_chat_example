import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class MainServices {
  static Future<File?> getCameraImageUsingImagePicker(
      ImageSource source) async {
    var pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 15,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  static Future<File?> getImageUsingImagePicker(ImageSource source) async {
    var pickedImage = await ImagePicker().pickMedia(
      imageQuality: 25,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  static Future<File?> pickDocumentFile() async {
    var pickedImage = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['docx', 'doc', 'pdf'],
      allowCompression: true,
    );
    if (pickedImage != null) {
      return File(pickedImage.files.first.path!);
    } else {
      return null;
    }
  }
}
