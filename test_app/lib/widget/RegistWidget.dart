import 'package:flutter/material.dart';

class RegistWidget extends StatefulWidget {
  @override
  _RegistWidgetState createState() => _RegistWidgetState();
}

class _RegistWidgetState extends State<RegistWidget> {
  //获取一个通过一个引用获取一个StatefulWidget的State对象
  //通过绑定一个GlobalKey即可
  final registerFormKey = GlobalKey<FormState>();
  String username='', password='';
  void registerForm(){
    registerFormKey.currentState!.save();
    print('username:$username password:$password');
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.people),
              labelText: "用户名或手机号"
            ),
            onSaved: (value){
//              print('用户名：${value})');
              this.username = value as String;
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (value){
              if(value == null || value.isEmpty){
                return "请输用户名或手机号";
              }
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "密码"
            ),
            onSaved: (value){
//              print('密码：${value})');
              this.password = value as String;
            },
          ),
          SizedBox(height: 16,),
          Container(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              child: Text("注 册",style: TextStyle(fontSize: 26,)),
              onPressed: registerForm,
            ),
          )
        ],
      ),
    );
  }
}
