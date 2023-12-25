import 'package:connection/models/student.dart';
import 'package:connection/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile{
// Profile().initialize() để khởi tạo SharedPreferences.
  static final Profile _instance = Profile._internal();  
  Profile._internal({this.token = ""});
  factory Profile(){
    return _instance;
  }
//  SharedPreferences dùng để lưu trữ cặp key-value dữ liệu
  late SharedPreferences _pef;    // Một biến SharedPreferences để lưu trữ dữ liệu người dùng.
  late String token;         // Biến lưu trữ token
  Student student = Student();     
  User user = User();
  Future <void> initialize() async{
    _pef = await SharedPreferences.getInstance();
    token = "";
  }
// Phương thức này lưu tên và mật khẩu vào SharedPreferences.
  Future <void> setUsernamePassword(String username, String password) async {
    _pef.setString("username", username);   
    _pef.setString("password", password);
  }
// trả về tên người dùng và mật khẩu đã lưu trong SharedPreferences.
  String get username => _pef.getString('username') ?? '';
  String get password => _pef.getString('password') ?? '';
  
}