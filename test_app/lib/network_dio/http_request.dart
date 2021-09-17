import 'package:dio/dio.dart';
import 'package:test_app/network_dio/http_config.dart';

///----------封装返回数据类型
class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;
  ResultData(this.data,this.isSuccess,this.code,{this.headers});
}

///------------------ 拦截器

///日志拦截器
class DioLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1.在进行任何网络请求的时候, 可以添加一个loading显示
    // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token
    // 3.对参数进行一些处理,比如序列化处理等
    print("拦截了请求");
    String requestStr = "\n==== REQUEST ====\n -URL:\n${options.baseUrl+options.path}\n -method:${options.method}";
    requestStr += "-HEADER:\n${options.headers}\n";
    final data = options.data;
    if(data != null){
      if(data is Map){
        requestStr += "- BODY:\n${data}\n";
      } else if (data is FormData){
        final formDataMap = Map()
          ..addEntries(data.fields)
          ..addEntries(data.files);
        requestStr += "-BODY:\n ${formDataMap}\n";
      } else {
        requestStr += "-BODY:\n${data.toString()}\n";
      }
    }
    handler.next(options);
//    super.onRequest(options, handler);
  }
}

/// 拦截器 数据初步处理
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    RequestOptions option = response.requestOptions;
    try {
      if(option.contentType != null && option.contentType!.contains("text")){
        response.data = ResultData(response.data, true, 200);
        handler.next(response);
      }
      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201){
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["errorCode"];
        if(code==0){
          response.data = ResultData(response.data, true, 200,headers: response.headers);
          handler.next(response);
          print("---------response.data------------");
          print(response.data);
          print("---------response.data end------------");
          return;
        } else {
          response.data = ResultData(response.data, false, 200,headers: response.headers);
          handler.next(response);
          return;
        }
      }
    } catch(e) {
      print("ResponseError==="+e.toString()+"****"+option.path);
      response.data = ResultData(response.data, false, response.statusCode!,headers: response.headers);
      return;
    }
    response.data = ResultData(response.data, false, response.statusCode!,headers: response.headers);
    handler.next(response);
//    super.onResponse(response, handler);
  }
}

///--------------- HttpRequest
class HttpManager {
  static getInstance(){
    final httpRequest = HttpRequest();
  }
}

class HttpRequest {

  static Map<String, dynamic> httpHeaders = {
    'Accept': 'application/json,*/*',
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Credentials": true,
    "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS, HEAD",
  };

  static final BaseOptions options = BaseOptions(
    baseUrl: HTTPConfig.baseURL,
    connectTimeout: HTTPConfig.connectTimeout,
    receiveTimeout: HTTPConfig.receiveTimeout,
    headers:httpHeaders,
    // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
    validateStatus: (status){
      return true;
    },
  );
  static final Dio dio = Dio(options);

  static Future<T> request<T>(String url,{String method='get', Map<String, dynamic>? params, Interceptor? inter}) async {
    // 1.请求的单独配置
    final options = Options(method: method);

    // 2.添加第一个拦截器
//    Interceptor dInter = InterceptorsWrapper(
//      onRequest: (RequestOptions options,RequestInterceptorHandler handler){
//        // 1.在进行任何网络请求的时候, 可以添加一个loading显示
//        // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token
//        // 3.对参数进行一些处理,比如序列化处理等
//        print("拦截了请求");
//        String requestStr = "\n==== REQUEST ====\n -URL:\n${options.baseUrl+options.path}\n -method:${options.method}";
//        requestStr += "-HEADER:\n${options.headers}\n";
//        final data = options.data;
//        if(data != null){
//          if(data is Map){
//            requestStr += "- BODY:\n${data}\n";
//          } else if (data is FormData){
//            final formDataMap = Map()
//                ..addEntries(data.fields)
//                ..addEntries(data.files);
//            requestStr += "-BODY:\n ${formDataMap}\n";
//          } else {
//            requestStr += "-BODY:\n${data.toString()}\n";
//          }
//        }
//        handler.next(options);
//        return handler.next(options);
//      },
//      onResponse: (Response response, RequestInterceptorHandler handler){
//        print("拦截了响应");
//
//      },
//      onError: (DioError error, RequestInterceptorHandler handler) {
//        print("拦截了错误");
//      },
//    );

//    List<Interceptor> inters = [dInter];
//    if (inter != null) {
//      inters.add(inter);
//    }
//    dio.interceptors.addAll(inters);
    dio.interceptors.add(DioLogInterceptor());
    dio.interceptors.add(ResponseInterceptors());

    // 3.发送网络请求
    try {
      Response response = await dio.request(url,queryParameters:params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }
}