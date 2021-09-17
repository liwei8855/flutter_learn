import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';

//------- model

class TitleModel {
  var imageUrl;
  var titleName;
  var path;

  TitleModel({this.imageUrl,this.titleName,this.path});
  TitleModel.fromMap(Map<String, dynamic> parsedMap){
    this.titleName = parsedMap["titleName"];
    this.path = parsedMap["path"];
    this.imageUrl = parsedMap["imageUrl"];
  }
}

//------  load data
Future<String> loadAssetJsonData() async {
  return await rootBundle.loadString('assets/data.json');
}

String loadData(){
  print('begin loading');
  loadAssetJsonData().then((value){
    print(value);
    return value;
  }).catchError((error){
    print("error");
    return "";
  });
  return "";
}

Future<Map> convertData() {
  return Future((){
    String value = loadData();
    if(value.length == 0){
      return {"message":"no result"};
    } else {
      Map json = jsonDecode(value);
      return json;
    }
  });
}

Future<List<TitleModel>> getList() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  return Future((){
    final jsonResult = jsonDecode(jsonString);
    print(jsonResult);
    List dataList = jsonResult["data"];
    List<TitleModel> list = [];
    for(Map<String, dynamic> map in dataList){
      list.add(TitleModel.fromMap(map));
    }
    return list;
  });
}