import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {
  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return AlignTest();
  }
}


class GradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(color: Colors.redAccent,width: 3),
            bottom: BorderSide(color: Colors.green,width: 1),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomRight: Radius.circular(2),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
              color: Colors.purple,
              blurRadius: 5
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.red
            ]
          ),
        ),
    );
  }
}

class CornerWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.pets, size: 36, color: Colors.yellow,),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg")
              )
          ),
        )
      ],
    );
  }
}

class ExpandedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: Container(color: Colors.red, height: 60,),
        ),
        Container(color: Colors.blue, width: 80, height: 80,),
        Container(color: Colors.green, width: 70, height: 70,),
        Expanded(
          flex: 1,
          child: Container(color: Colors.orange, height: 100,),
        ),
      ],
    );
  }
}

class ExpandedColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: Container(color: Colors.red, width: 60,),
        ),
        Container(color: Colors.blue, width: 80, height: 80,),
        Container(color: Colors.green, width: 70, height: 70,),
        Expanded(
          flex: 1,
          child: Container(color: Colors.orange, width: 100,),
        ),
      ],
    );
  }
}

class StackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.purple,width: 300,height: 300,
        ),
        Positioned(child: Icon(Icons.favorite, size:50, color: Colors.white,),left: 20,top: 20,),
        Positioned(child: Text("你好hello",style: TextStyle(fontSize: 20,color: Colors.white),),bottom: 20,right: 20,)
      ],
    );
  }
}


class AlignTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
//      widthFactor: 3,
//      heightFactor: 3,
      child:StackWidget()
    );
  }
}
