import 'package:connection/repositories/register_repository.dart';
import 'package:flutter/material.dart';
// lớp ForgotViewModel kế thừa từ ChangeNotifier cho phép các widget con biết các sự kiện thay đổi trong dữ liệu mà nó quản lý.
class RegisterViewModel with ChangeNotifier{
// status là một biến số nguyên dùng để xác định trạng thái 
  int status = 0; // 0 - chưa đăng kí, 1 - đăng đk, 2 - bạn đăng ký lỗi, 3- - đăng ký cần xác minh email, 4 -đăng ký không cần xác minh email
  String erronMessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh = "Khi tham gia vào ứng dụng các bạn phải đồng ý với các điều kiện sau:\n"
                      +"1. Các thông tin của bạn sẽ được chia sẽ với cá thành viên\n"
                      +"2. Thông tin của bạn có thể ảnh hưởng đến kết qur học tập ở trường\n"
                      +"3. Thông tin của bạn sẽ được xóa vĩnh viễn khi có yêu cầu xóa thông tin.";
  void setAgree(bool value){
    agree = value;
    notifyListeners();
  }
  Future <void> register(String email, String username, String pass1, String pass2) async{
    status = 1;
    notifyListeners();
    if(agree == false)
    {
      status = 2;
      erronMessage += "Phải đồng ý điều kiện tài khoản trước khi đăng ký!\n";
    }
    if(email.isEmpty || username.isEmpty || pass1.isEmpty )
    {
      status = 2;
      erronMessage += "Email, username, password không được để trống!\n";
    }
    final bool emailValid = RegExp(r"^[a,zA-Z0-9.a-zA-Z0-9.!#$%&*'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid == false)
    {
      status = 2;
      erronMessage += "Email không hợp lệ!\n";
    }
    if(pass1.length < 8)
    {
      status = 2;
      erronMessage += "Password cần lớn hơn 8 chữ\n";
    }
    if(pass1 != pass2)
    {
      status = 2;
      erronMessage += "Mật khẩu không giống nhau!";
    }
    if(status != 2)
    {
      // await để đợi kết quả trả về từ một hàm hoặc biểu thức làm việc bất đồng bộ.
      status = await registerRepo.register(email,username,pass1);
    }
// Sử dụng repository gọi hàm login và lấy kết quả
// notifyListeners được sử dụng sau mỗi thay đổi dữ liệu để cập nhật giao diện người dùng với dữ liệu mới 
    notifyListeners();
  }
}