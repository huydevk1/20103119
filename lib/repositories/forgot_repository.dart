import 'package:connection/services/api_service.dart';
import 'package:dio/dio.dart';

class ForgotRepository{
  final ApiService api = ApiService();  // khai báo api kiểu apiservice
  Future <bool> forgotPassword(String email) async{
    // khai báo kết quả phản hồi từ api.forgotPassword(email)
    final response = await api.forgotPassword(email);
    if(response != null) 
    {
      return true;  //yêu cầu quên mật khẩu đã được xử lý thành công
    }
    else{
      return false; // Trường hợp null hoặc có lỗi trả về false
    }
  }
}