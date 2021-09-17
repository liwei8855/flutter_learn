import 'package:flutter/material.dart';

class OPCounterWidget extends StatefulWidget {

  OPCounterWidget(){
    print("OPCounterWidget构造方法");
  }

  @override
  _OPCounterWidgetState createState() {
    print("OPCounterWidgetState的createState方法");
    return _OPCounterWidgetState();
  }
}

class _OPCounterWidgetState extends State<OPCounterWidget> {
  int _counter = 0;

  _OPCounterWidgetState(){
    print("OPCounterWidgetState构造方法");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("OPCounterWidgetState的init方法");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("OPCounterWidgetState的didChangeDependencies方法");
  }

  @override
  void didUpdateWidget(covariant OPCounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("OPCounterWidgetState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("OPCounterWidgetState的dispose方法");
  }

  @override
  Widget build(BuildContext context) {
    print("OPCounterWidgetState的build方法");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  _counter++;
                });
              }, child: Text("+1",style: TextStyle(fontSize: 20),)),
              ElevatedButton(onPressed: (){
                setState(() {
                  _counter--;
                });
              }, child: Text("-1",style: TextStyle(fontSize: 20),))
            ],
          ),
          Text("当前计数:${_counter}",style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}