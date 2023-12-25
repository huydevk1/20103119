import 'package:connection/models/profile.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';

class PageDangkylop extends StatefulWidget {
  PageDangkylop ({super.key});
  static String routename = '/dangkylop';

  @override
  State<PageDangkylop> createState() => _PageDangkylopState();
}

class _PageDangkylopState extends State<PageDangkylop> {
  Profile profile = Profile();
  List<Lop>? listlop = [];
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    // TODO: implement initState
     mssv = profile.student.mssv;
     ten = profile.user.first_name;
     idlop = profile.student.idlop;
     tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thêm thông tin cơ bản',
                  style: AppConstant.textfancyheader2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Bạn không thể quay lại trang sau khi rời đi. Vì vậy nên kiểm tra kỹ nhé!',
                  style: AppConstant.texterror,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputTextFormField(
                  title: "Tên", 
                  value: ten, 
                  width: size.width,
                  callback: (output) {
                    ten = output;
                  },
                ),
                CustomInputTextFormField(
                  title: "MSSV", 
                  value: mssv, 
                  width: size.width,
                  callback: (output) {
                    mssv= output;
                  },
                ),
                listlop!.isEmpty 
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(), 
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if(snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(  
                            width: size.width, 
                            list: listlop!,
                            title: 'Lớp', 
                            valueId: idlop,
                            valueName: tenlop,
                            callback: (outputID, outputName) {
                              idlop = outputID;
                              tenlop = outputName;
                            },
                          );
                        }
                        else{
                          return Text('Lỗi xảy ra');
                        }
                      },
                    )
                    : CustomInputDropDown(  
                      width: size.width, 
                      list: listlop!,
                      title: 'Lớp', 
                      valueId: idlop,
                      valueName: tenlop,
                      callback: (outputID, outputName) {
                        idlop = outputID;
                        tenlop = outputName;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async{
                        profile.student.mssv = mssv;
                        profile.student.idlop = idlop;
                        profile.student.tenlop = tenlop;
                        profile.user.first_name = ten;
                        await UserRepository().updateProfile();
                        await StudentRepository().dangkylop();
                      },
                      child: CustomButton(textButton: 'Lưu thông tin')
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.popAndPushNamed(context, PageMain.routename);
                      },
                      child: Text(
                        "Bấm vào đây để rời đi khỏi trang >>", 
                        style: AppConstant.textlink,
                      ),
                    ),              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
