import 'dart:io';

import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'custom_control.dart';
import 'package:image_picker/image_picker.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idpage = 1;
  XFile? image;
  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.playspiner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      viewmodel.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                //--start header--//
                createHeader(size, profile, viewmodel),
                //end header ...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomInputTextFormField(
                      title: 'Điện thoại',
                      value: profile.user.phone,
                      width: size.width * 0.45,
                      callback: (output) {
                        profile.user.phone = output;
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.phone,
                    ),
                    CustomInputTextFormField(
                      title: 'Ngày sinh',
                      value: profile.user.birthday,
                      width: size.width * 0.45,
                      callback: (output) {
                        if (AppConstant.isDate(output)) {
                          profile.user.birthday = output;
                        }
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.datetime,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPlaceDropDown(
                      width: size.width * 0.45,
                      title: 'Thành phố/tỉnh',
                      valueId: profile.user.provinceid,
                      valueName: profile.user.provincename,
                      callback: (outputId, outputName) async {
                        viewmodel.playspiner();
                        profile.user.provinceid = outputId;
                        profile.user.provincename = outputName;
                        await dcmodel.setCity(outputId);
                        profile.user.districtid = 0;
                        profile.user.wardid = 0;
                        profile.user.districtname = '';
                        profile.user.wardname = '';
                        viewmodel.setModified();
                        viewmodel.hideSpinner();
                      },
                      list: dcmodel.listCity,
                    ),
                    CustomPlaceDropDown(
                      width: size.width * 0.45,
                      title: 'Quận/huyện',
                      valueId: profile.user.districtid,
                      valueName: profile.user.districtname,
                      callback: (outputId, outputName) async {
                        viewmodel.playspiner();
                        profile.user.districtid = outputId;
                        profile.user.districtname = outputName;
                        profile.user.wardid = 0;
                        profile.user.wardname = '';
                        await dcmodel.setDistrict(outputId);
                        viewmodel.setModified();
                        viewmodel.hideSpinner();
                      },
                      list: dcmodel.listDistrict,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPlaceDropDown(
                      width: size.width * 0.45,
                      title: 'Huyện/xã',
                      valueId: profile.user.wardid,
                      valueName: profile.user.wardname,
                      callback: (outputId, outputName) async {
                        viewmodel.playSpinner();
                        profile.user.wardid = outputId;
                        profile.user.wardname = outputName;
                        await dcmodel.setWard(outputId);
                        viewmodel.setModified();
                        viewmodel.hideSpinner();
                      },
                      list: dcmodel.listWard,
                    ),
                    CustomInputTextFormField(
                      title: 'Số nhà/tên đường',
                      value: profile.user.address,
                      width: size.width * 0.45,
                      callback: (output) {
                        profile.user.address = output;
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.streetAddress,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: size.width * 0.2,
                  width: size.width * 0.2,
                  child: QrImageView(
                    data: '{userid:' + profile.user.id.toString() + '}',
                    version: QrVersions.auto,
                    gapless: false,
                  ),
                )
              ],
            ),
            SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: viewmodel.status == 1
                    ? CustomSpinner(
                        size: size,
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container createHeader(
      Size size, Profile profile, ProfileViewModel viewmodel) {
    var textBodyfocuswhitebold;
    var textbodyfocuswhitebold;
    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade700,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbodyfocuswhite,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: viewmodel.updateavatar == 1 && image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                viewmodel.uploadAvatar(image!);
                              },
                              child: Container(
                                  color: Colors.white,
                                  child: Icon(size: 30, Icons.save)),
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          viewmodel.setUpdateAvatar();
                        },
                        child: CustomAvatar1(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.user.username,
                style: AppConstant.textbodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv:',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodywhitebold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lớp: ',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodywhitebold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          ' (Chưa duyệt)',
                          style: AppConstant.textbodyfocuswhite,
                        )
                      : Text('')
                ],
              ),
              Row(
                children: [
                  Text(
                    'Vai trò: ',
                    style: AppConstant.textbodywhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          'Sinh viên',
                          style: AppConstant.textBodyfocuswhitebold,
                        )
                      : Text(
                          'Giảng viên',
                          style: AppConstant.textBodyfocuswhitebold,
                        ),
                ],
              ),
              SizedBox(
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: viewmodel.modifile == 1
                        ? GestureDetector(
                            onTap: () {
                              viewmodel.updateProfile();
                            },
                            child: Icon(Icons.save))
                        : Container(),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
