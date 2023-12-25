import 'package:connection/repositories/forgot_repository.dart';
import 'package:flutter/material.dart';

class ForgotViewModel with ChangeNotifier{  
// lớp ForgotViewModel kế thừa từ ChangeNotifier cho phép các widget con biết các sự kiện thay đổi trong dữ liệu mà nó quản lý.
  final forgotRepo = ForgotRepository();
  String erronMessage = "";
// status là một biến số nguyên dùng để xác định trạng thái 
  int status = 0; // 0: chưa gữi, 1: đang gữi, 2: Thành công
  Future<void> forgotPassword(String email) async
  {
    status = 1;
    notifyListeners();
    erronMessage = "";
    final bool emailValid = RegExp(r"^[a,zA-Z0-9.a-zA-Z0-9.!#$%&*'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid == false)
    {
      status = 2;
      erronMessage += "Email không hợp lệ!\n";
    }
    if(status != 2)
    {
      if(await forgotRepo.forgotPassword(email) == true)
      {
        status = 3;
      }
      else
      {
        status = 2;
        erronMessage = "Email không tồn tại!";
      }
    }
// notifyListeners được sử dụng sau mỗi thay đổi dữ liệu để cập nhật giao diện người dùng với dữ liệu mới 
    notifyListeners();
  }
}