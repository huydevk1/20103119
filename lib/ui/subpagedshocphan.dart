import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDshocphan extends StatelessWidget {
  const SubPageDshocphan({super.key});
  static int idpage = 5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(color: AppConstant.backgroundColor, child: Center(child: Text("Danh sách học phần"),)));
  }
}
