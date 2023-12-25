import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/profile.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  int modifile = 0;
  int updateavatar = 0;

  void updatescreen() {
    notifyListeners();
  }

  void setUpdateAvatar() {
    updateavatar = 1;
    notifyListeners();
  }

  void playSpinner() {
    status = 1;
    notifyListeners();
  }

  void hideSpinner() {
    status = 0;
    notifyListeners();
  }

  void setModified() {
    if (modifile == 0) {
      modifile = 1;
      notifyListeners();
    }
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modifile = 0;
    notifyListeners();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateavatar = 0;
    status = 0;
    notifyListeners();
  }

  void playspiner() {}
}
