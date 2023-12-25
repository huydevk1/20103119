import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_forgot.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loginviewmodel.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if(viewmodel.status == 3)
    {
      Future.delayed(Duration.zero,() {
        Navigator.popAndPushNamed(context, PageMain.routename);
      },);
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea( // Để không bị ẩn
        child: Center(
          child: SingleChildScrollView( // hiển thị nhưng không bị giới hạn bởi kích thước màn hình
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Applogo(),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Đăng nhập", 
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Chào mừng bạn đã đến với chúng tôi!", 
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFie(
                        textController: _emailController, 
                        hintText: "username",
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFie(
                        textController: _passwordController, 
                        hintText: "password", 
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      viewmodel.status == 2? Text(
                        viewmodel.erronMessage, 
                        style: const TextStyle(
                          color: Colors.red
                          ),
                        ):const Text(""),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector( // dụng để kích hoạt các hoạt động hoặc thay đổi trạng thái của ứng dụng
                        onTap: () {
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(textButton: "Đăng nhập"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Text("Chưa có tài khoản?"), 
                        GestureDetector(
                          onTap: () => Navigator.of(context).popAndPushNamed(PageRegister.routename),
                          child: Text(" Đăng ký", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),))],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(onTap: () => Navigator.of(context).popAndPushNamed(PageForgot.routeName), 
                      child: Text("Quên mật khẩu", style: AppConstant.textlink)),
                    ],
                  ),
                ),
                viewmodel.status == 1? CustomSpinner(size: size): Container(),
              ],
            ),
          ),
        )
      ),
    );
  }
}


