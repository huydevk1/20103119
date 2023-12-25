import 'package:connection/models/profile.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';
import '../models/place.dart';
import 'AppConstant.dart';

class CustomTextFie extends StatelessWidget {
  const CustomTextFie({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white)),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          child: Text(
        textButton,
        style: const TextStyle(
          color: Color.fromARGB(255, 12, 11, 11),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}

class Applogo extends StatelessWidget {
  const Applogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.qr_code_scanner,
      size: 100,
      color: Colors.deepPurple[300],
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.deepPurple.withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 50,
          image: AssetImage('images/loading.gif'),
        ),
      ),
    );
  }
}

class CustomAvatar1 extends StatelessWidget {
  const CustomAvatar1({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.20),
      child: Container(
        width: 100,
        height: 100,
        //child: Image.network(Profile().user.avatar, fit: BoxFit.cover,),
        child: Image(
          image: AssetImage('images/huy.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valueName,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;
  final Function(int outputID, String outputName) callback;
  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputID = 0;
  String outputName = "";
  @override
  void initState() {
    // TODO: implement initState
    outputID = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "Không có" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      width: widget.width,
                      child: DropdownButton(
                        value: outputID,
                        items: widget.list
                            .map((e) => DropdownMenuItem(
                                value: e.id,
                                child: Container(
                                    width: widget.width - 45,
                                    child: Text(
                                      e.ten,
                                      overflow: TextOverflow.ellipsis,
                                    ))))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            outputID = value!;
                            for (var dropitem in widget.list) {
                              if (dropitem.id == outputID) {
                                outputName = dropitem.ten;
                                widget.callback(outputID, outputName);
                                break;
                              }
                            }
                            status = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFormField extends StatefulWidget {
  const CustomInputTextFormField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    this.type = TextInputType.text,
  });

  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callback;
  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = "";
  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;
    //if(output == "")
    //{
    //  output = "Không có";
    //}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "Không có" : widget.value,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      width: widget.width - 50,
                      child: TextFormField(
                        keyboardType: widget.type,
                        decoration: InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        onChanged: (value) {
                          output = value;
                          setState(() {
                            output = value;
                            widget.callback(output);
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            status = 0;
                            widget.callback(output);
                          });
                        },
                        child: Icon(
                          Icons.save,
                          size: 18,
                        )),
                  ],
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomPlaceDropDown extends StatefulWidget {
  const CustomPlaceDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valueName,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Place> list;
  final Function(int outputID, String outputName) callback;
  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputID = 0;
  String outputName = "";
  @override
  void initState() {
    // TODO: implement initState
    outputID = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.valueName == "" ? "Không có" : widget.valueName,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200]),
                        width: widget.width - 25,
                        child: DropdownButton(
                          value: widget.valueId,
                          items: widget.list
                              .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Container(
                                      width: widget.width - 45,
                                      child: Text(
                                        e.name,
                                        overflow: TextOverflow.ellipsis,
                                      ))))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              outputID = value!;
                              for (var dropitem in widget.list) {
                                if (dropitem.id == outputID) {
                                  outputName = dropitem.name;
                                  widget.callback(outputID, outputName);
                                  break;
                                }
                              }
                              status = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
