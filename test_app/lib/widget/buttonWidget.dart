import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FloatingActionButton(child: Text("Floating"), onPressed: (){
            print("FloatingActionButton");
          }),
          ElevatedButton(onPressed: (){
            print("ElevatedButton");
          }, child: Text("ElevatedButton")),
          TextButton(onPressed: () => print("TextButton") , child: Text("TextButton")),
          OutlinedButton(onPressed: () => print("OutlinedButton") , child: Text("OutlinedButton")),
          ElevatedButton(onPressed: (){
              print("同意协议");
            }, 
            child: Text("同意协议",style: TextStyle(color: Colors.white)),
            style: ButtonStyle(),
          ),
        ],
      ),
    );
  }
}
