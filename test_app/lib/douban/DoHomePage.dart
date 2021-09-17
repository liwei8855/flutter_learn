import 'package:flutter/material.dart';
import 'package:test_app/douban/DoHome.dart';
import 'package:test_app/douban/DoSubject.dart';
import 'package:test_app/douban/DoGroup.dart';
import 'package:test_app/douban/DoMall.dart';
import 'package:test_app/douban/DoProfile.dart';

class DoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "豆瓣",
      theme: ThemeData(
        primaryColor: Colors.green,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
      ),
      home: DoStackPage(),
    );
  }
}

class DoStackPage extends StatefulWidget {
  @override
  _DoStackPageState createState() => _DoStackPageState();
}

class _DoStackPageState extends State<DoStackPage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          createItem("home", "首页"),
          createItem("subject", "书影音"),
          createItem("group", "小组"),
          createItem("mall", "市集"),
          createItem("profile", "我的"),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DoHome(),
          DoSubject(),
          DoGroup(),
          DoMall(),
          DoProfile()
        ],
      ) ,
    );
  }
}

BottomNavigationBarItem createItem(String iconName, String title){
  String basePath = "assets/images/tabbar/";
  return BottomNavigationBarItem(
    icon: Image.asset(basePath+iconName+".png",width: 30,),
    activeIcon: Image.asset(basePath+iconName+"_active.png",width: 30,),
    label: title,
  );
}
