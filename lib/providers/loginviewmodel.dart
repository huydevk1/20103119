import 'package:connection/models/student.dart';
import 'package:connection/models/user.dart';
import 'package:connection/repositories/login_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
// lớp ForgotViewModel kế thừa từ ChangeNotifier cho phép các widget con biết các sự kiện thay đổi trong dữ liệu mà nó quản lý.
class LoginViewModel with ChangeNotifier
{
  String erronMessage = "";
// status là một biến số nguyên dùng để xác định trạng thái 
  int status = 0; // 0 - not login, 1 - waiting, 2 - error, 3 - already logged
  LoginRepository loginRepo = LoginRepository();
  Future <void> login(String username, String password)
// async thực hiện các tác vụ mà không cần chờ kết quả của tác vụ trước đó hoàn thành 
  async {
    status = 1;
    notifyListeners();
    try{
      var profile = await loginRepo.login(username, password);
      if(profile.token == ""){
        status = 2;
        erronMessage = "Tên đăng nhập hoặc mật khẩu sai!";
      } else {
        //status = 3;
        // đăng nhập thành công, lấy thông tin User student
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        status = 3;
      }
      notifyListeners(); // notifyListeners được sử dụng sau mỗi thay đổi dữ liệu để cập nhật giao diện người dùng với dữ liệu mới 
    }
    catch(e){}
  }
}