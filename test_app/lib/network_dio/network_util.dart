import 'dart:html';

import 'package:dio/dio.dart';

void dioNetwork() async {
  final dio = Dio();
  final response = await dio.get("http://123.207.32.32:8000/api/v1/recommend");
  if (response.statusCode == HttpStatus.ok) {
    print(response.data);
  } else {
    print("error:${response.statusCode}");
  }
}