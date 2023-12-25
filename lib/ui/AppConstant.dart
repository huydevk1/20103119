import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  // TextStyle được sử dụng cho các tiêu đề lớn
  static TextStyle textfancyheader =
      GoogleFonts.flavors(fontSize: 40, color: Colors.deepPurple[300]);

  static TextStyle textfancyheader2 =
      GoogleFonts.flavors(fontSize: 30, color: Colors.deepPurple[300]);
  // texterror: Được sử dụng để hiển thị văn bản của các thông báo lỗi hoặc lỗi.
  static TextStyle texterror =
      TextStyle(color: Colors.red[300], fontStyle: FontStyle.italic);
  // texterror: Được sử dụng cho văn bản trong các liên kết hoặc các phần tử tương tự.
  static TextStyle textlink =
      TextStyle(color: Colors.purple[300], fontSize: 16);

  static TextStyle textbody =
      TextStyle(color: Colors.deepPurple[300], fontSize: 16);

  static TextStyle textbodywhite = TextStyle(color: Colors.white, fontSize: 16);

  static TextStyle textbodywhitebold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle textbodyfocus =
      TextStyle(color: Colors.deepPurple, fontSize: 20);

  static TextStyle textbodyfocuswhite =
      TextStyle(color: Colors.white, fontSize: 20);
  static TextStyle textBodyfocuswhitebold = GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  static Color appbarcolor = Colors.deepPurple.shade700;

  static Color backgroundColor = Colors.deepPurple.shade100;

  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
