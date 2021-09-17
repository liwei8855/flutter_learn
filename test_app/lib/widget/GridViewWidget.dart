import 'package:flutter/material.dart';
import 'TestDataBuilder.dart';


//-----------state ful

class GridViewStateFulWidget extends StatefulWidget {
  @override
  _GridViewStateFulWidgetState createState() => _GridViewStateFulWidgetState();
}

class _GridViewStateFulWidgetState extends State<GridViewStateFulWidget> {

  List<TitleModel> list = [];
  @override
  void initState() {

    getList().then((value){

      setState(() {
        this.list = value;
      });

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const fixedDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: fixedDelegate,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(list[index].imageUrl),
                SizedBox(height: 5,),
                Text(list[index].titleName, style: TextStyle(fontSize: 16),),
              ],
            ),
          );
        }
      ),
    );
  }
}

//----------state less

class GridViewStateLessWidget extends StatelessWidget {
  List<Widget> getGridWidgets(){
    return List.generate(30, (index){
      return Container(
        color: Colors.purple,
        alignment: Alignment(0,0),
        child: Text("item${index}",style: TextStyle(fontSize: 20, color: Colors.white),),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const fixedDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
    );
    const maxDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 100,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.0
    );
    return GridView(
      gridDelegate: fixedDelegate,
      children: getGridWidgets(),
    );
  }
}
