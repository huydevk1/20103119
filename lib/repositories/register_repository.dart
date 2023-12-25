import '../services/api_service.dart';

class RegisterRepository{
  final ApiService api = ApiService();  // khai báo api kiểu apiservice
  Future <int> register(String email, String username, String password)
  async {
    int kq = 2;
    final response = await api.registerUser(email, username, password);
    if(response != null && response.statusCode == 201)
    {
      // response.data['requies_email_confirmation'] == true: Kiểm tra xem có yêu cầu xác nhận qua email không.
      if(response.data['requies_email_confirmation'] == true) {
        kq = 3;
      }
      else {
        kq = 4;
      }
    }
    return kq;
  }
}