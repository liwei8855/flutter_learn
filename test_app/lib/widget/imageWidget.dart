import 'package:flutter/material.dart';

/*Image组件有很多的构造函数，我们这里主要学习两个：
Image.assets：加载本地资源图片；
Image.network：加载网络中的图片；
* **/

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        Image.network(
          "http://img0.dili360.com/ga/M01/48/3C/wKgBy1kj49qAMVd7ADKmuZ9jug8377.tub.jpg",
          alignment: Alignment.topCenter,
          repeat: ImageRepeat.repeatY,
          color: Colors.red,
          colorBlendMode: BlendMode.colorDodge,
          width: 300,
          height: 300,
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.yellow,
          child: Image.asset("images/pic1.png"),
        ),
        //圆角头像
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg"),
          child: Container(
            alignment: Alignment(0, .5),
            width: 50,
            height: 50,
            child: Text("兵长利威尔"),
          ),
        ),
        ClipOval(
          child: Image.network(
            "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
            height: 50,
            width: 50,
          ),
        ),
        //圆角图片
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
            height: 80,
            width: 80,
          ),
        )
      ],
    );
  }
}
