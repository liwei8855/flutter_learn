import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "Hello world";
    //监听文本框
    textEditingController.addListener(() {
      print(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.people),
        labelText: "username",
        hintText: "请输入用户名",
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.lightGreen,
      ),
      onChanged: (value){
        print(value);
      },
      onSubmitted: (value){
        print(value);
      },
    );
  }
}
