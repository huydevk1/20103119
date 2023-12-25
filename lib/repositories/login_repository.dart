import 'package:connection/models/profile.dart';
import 'package:connection/services/api_service.dart';

class LoginRepository{
  final ApiService api = ApiService();  // khai báo api kiểu apiservice
  Future <Profile> login(String username, String password)
  async {
    Profile profile =Profile(); //Tạo một đối tượng Profile mới để lưu trữ thông tin của người dùng sau khi đăng nhập.
    final response = await api.loginUser(username, password);
    if(response != null && response.statusCode == 200)
    {
      profile.token = response.data['token']; // Lưu giá trị token từ dữ liệu phản hồi của yêu cầu đăng nhập vào trường token
      profile.setUsernamePassword(username, password);  // setUsernamePassword của đối tượng profile để lưu username và password đã được sử dụng trong yêu cầu đăng nhập.
    }
    else{
      profile.token = "";
    }
    return profile;
  }
}