import 'package:flutter/material.dart';

class OPCheckBox extends StatefulWidget {
  var checkBoxStatus = false;
  @override
  _OPCheckBoxState createState() => _OPCheckBoxState();
}

class _OPCheckBoxState extends State<OPCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
              value: widget.checkBoxStatus,
              onChanged: (value) {
                setState(() {
                  widget.checkBoxStatus = value as bool;
                });
              }),
          Text(
            '同意协议',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}