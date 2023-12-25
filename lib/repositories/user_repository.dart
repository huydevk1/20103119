import 'dart:io';

import 'package:connection/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getUserInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<void> uploadAvatar(XFile image) async {
    ApiService api = ApiService();
    if (image != null) {
      //resize the image
      final img.Image originalImage =
          img.decodeImage(File(image.path).readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(originalImage, width: 300);
      final File resizedFile =
          File(image.path.replaceAll('.jpg', '_resized.jpg'))
            ..writeAsBytes(img.encodeJpg(resizedImage));
      await api.uploadAvatarToSever(File(resizedFile.path));
    }
  }
}
