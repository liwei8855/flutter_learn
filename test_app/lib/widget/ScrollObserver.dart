import 'package:flutter/material.dart';

class ScrollObserverWidget extends StatefulWidget {
  @override
  _ScrollObserverWidgetState createState() => _ScrollObserverWidgetState();
}

class _ScrollObserverWidgetState extends State<ScrollObserverWidget> {
  static ScrollController _controller = ScrollController();
  bool _isShowTop = false;
  int _progress = 0;

  @override
  void initState() {
//    _controller = ScrollController();

    _controller.addListener(() {
      var tempShowTop = _controller.offset >100;
      if(tempShowTop != _isShowTop){
        setState(() {
          _isShowTop = tempShowTop;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(

        onNotification: (ScrollNotification notification){
          if(notification is ScrollStartNotification){
            print("开始滚动....");
          } else if (notification is ScrollUpdateNotification){
            final currentPixel = notification.metrics.pixels;
            final totalPixel = notification.metrics.maxScrollExtent;
            double progress = currentPixel / totalPixel;
            setState(() {
              _progress = (progress * 100).toInt();
            });
            print("正在滚动:${notification.metrics.pixels}-${notification.metrics.maxScrollExtent}");
          } else if (notification is ScrollEndNotification){
            print("结束滚动....");
          }
          return false;
        },
        child:Scaffold(
          appBar: AppBar(
            title: Text("ListView展示"),
          ),
          body:Stack(
            children: [
              ListView.builder(itemBuilder: (BuildContext context,int index){
                return ListTile(title: Text("item$index"),);
              },
                itemCount: 20,
                itemExtent: 60,
                controller: _controller,
              ),
              CircleAvatar(
                radius: 30,
                child: Text("${_progress}%"),
                backgroundColor: Colors.black54,
              ),
            ],
          ),
          floatingActionButton: !_isShowTop?null:FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: (){
                _controller.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.ease);
              }),
        )
    );
  }
}
