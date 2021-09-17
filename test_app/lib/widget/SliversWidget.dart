import 'package:flutter/material.dart';

//-------------SliverAppBar+SliverGrid+SliverFixedExtentList

class SliverGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return showCustomScrollView();
  }

  Widget showCustomScrollView(){

    const gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 4.0,
    );

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Sliver app bar"),
            background: Image(
              image: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: gridDelegate,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100*(index%9)],
                child: Text("grid item $index"),
              );
            },
            childCount: 10,
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate((context, index){
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100*(index%9)],
              child: Text("list item $index"),
            );
          },
            childCount: 20,
          ) ,
          itemExtent: 50.0,
        )
      ],
    );
  }
}


//-------------SliverGrid+SliverPadding+SliverSafeArea

class SliverStateLessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const fixedDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
    );

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: fixedDelegate,
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Container(
                  alignment: Alignment(0,0),
                  color: Colors.orange,
                  child: Text("item${index}"),
                );
                },
                childCount: 20
              )
            ),
          ),
        ),
      ],
    );
  }
}
