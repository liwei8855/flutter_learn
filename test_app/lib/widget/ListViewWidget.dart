import 'package:flutter/material.dart';
import 'TestDataBuilder.dart';

//------------- widget stateful

class ListViewStateFullWidget extends StatefulWidget {
  @override
  _ListViewStateFullWidgetState createState() => _ListViewStateFullWidgetState();
}

class _ListViewStateFullWidgetState extends State<ListViewStateFullWidget> {

  List<TitleModel> listData = [];

  @override
  void initState() {

    getList().then((items){

      setState(() {
        this.listData = items;
      });

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                listData[index].imageUrl,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 8,),
              Text(listData[index].titleName, style: TextStyle(fontSize: 20),),
              SizedBox(height: 5,),
            ],
          ),
        );
      }
    );
  }
}


//------------- widget stateless

class ListViewWidget extends StatelessWidget {
  final TextStyle textStyle = TextStyle(fontSize: 20,color: Colors.redAccent);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemExtent: 80,
      itemBuilder: (BuildContext context, int index) {
        if(index == 0){
          return Container(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              itemExtent: 200,
              children: [
                Container(color: Colors.red, width: 200,),
                Container(color: Colors.yellow, width: 200,),
                Container(color: Colors.green, width: 200,),
              ],
            ),
          );
        } else if (index == 1){
          return ListTile(
            leading: Icon(Icons.people, size: 36,),
            title: Text("a"),
            subtitle: Text("a detail"),
            trailing: Icon(Icons.arrow_forward),
          );
        } else {
          return ListTile(title: Text("标题$index"), subtitle: Text("详情内容$index"));
        }
      }
    );
  }
}





