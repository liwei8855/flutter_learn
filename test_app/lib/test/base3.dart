//异步
/*
* Dart是单线程的
*
* 如何处理耗时的操作呢?
* 处理方式一： 多线程，比如Java、C++，我们普遍的做法是开启一个新的线程
* 处理方式二： 单线程+事件循环，比如JavaScript、Dart都是基于单线程加事件循环来完成耗时操作的处理
*
* 阻塞式调用和非阻塞式调用
* 阻塞式调用： 调用结果返回之前，当前线程会被挂起，调用线程只有在得到调用结果之后才会继续执行。
* 非阻塞式调用： 调用执行之后，当前线程不会停止执行，只需要过一段时间来检查一下有没有结果返回即可
*
*
* 如果在多核CPU中，单线程是不是就没有充分利用CPU呢？这个问题，我会放在后面来讲解
* 单线程是如何来处理网络通信、IO操作它们返回的结果呢？
* 答案就是事件循环（Event Loop）:将需要处理的一系列事件（包括点击事件、IO事件、网络事件）放在一个事件队列（Event Queue）中。
不断的从事件队列（Event Queue）中取出事件，并执行其对应需要执行的代码块，直到事件队列清空
* */

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

main(){
//  networkTest();
//  networkTest2();
//networkTest3();
//networkTest4();
//taskOperateOrder();
//loadAssetJsonData();
  loadAssetData();
}

Future<String> loadAssetJsonData() async {
  return await rootBundle.loadString('assets/data.json');
}

void loadAssetData() {
  print('begin loading');
  Future<String> future = rootBundle.loadString('assets/data.json');
  future.then((value){
    print(value);
  });
//  loadAssetJsonData().then((value){
//    print(value);
//  }).catchError((error){
//    print("error");
//  });
}

//事件循环的伪代码
eventLoop(){
  List eventQueue = [];
  var event;
  // 事件循环从启动的一刻，永远在执行
  while(true){
    if(eventQueue.length>0){
      // 取出一个事件
      event = eventQueue.removeAt(0);
      // 执行该事件
      event();
    }
  }
}

/*
* 1. Dart中的异步操作主要使用Future以及async、await
*   如果你之前有过前端的ES6、ES7编程经验，那么完全可以将Future理解成Promise，async、await和ES7中基本一致
* */
//使用getNetworkData来模拟了一个网络请求，3秒钟之后返回数据
networkTest(){
  print('main function start');
  print(getNetworkData());
  print('main function end');
}
//会阻塞main函数的执行 等待3s
String getNetworkData(){//不应该阻塞主线程 实现方式错误
  sleep(Duration(seconds: 3));
  return 'network data';
}
//正确的方式
//创建了一个Future实例
//将一个耗时的操作隔离了起来，这个操作不会再影响我们的主线程执行了
//获取Future得到的结果:有了Future之后，如何去获取请求到的结果：通过.then的回调
//可以在then中继续返回值，会在下一个链式的then调用回调函数中拿到返回的结果
networkTest2(){
  print('main function start');
  var future = getNetworkData1();
  future.then((value){
    print('value1：${value}');
    return 'value2';
  }).then((value){
    //then拿到的是上一个then返回的value
    // 可以一直链式下去 每步都可以处理数据
    //上一步没有return 则拿到的值为null
    print(value);
  }).catchError((error){
    print(error);
  });
  print(future);
  print('main function end');
}
Future<String> getNetworkData1(){
  return Future<String>(() {
    sleep(Duration(seconds: 3));
    var error = false;
    if(error){
      //返回异常
      throw Exception("错误");
    } else {
      //正常返回结果
      return 'network data';
    }
  });
}

//Future其他API
//直接获取一个完成的Future，该Future会直接调用then的回调函数

/*为什么立即执行，但是哈哈哈是在最后打印的呢？
*因为Future中的then会作为新的任务会加入到事件队列中（Event Queue），加入之后你肯定需要排队执行了
* */
networkTest3(){
  print('main function start');
//  futureTest1();
  futureTestError();
  print('main function end');
}
futureTest1(){
  Future.value('哈哈哈').then((value){
    print(value);
  });
}
//直接获取一个完成的Future，但是是一个发生异常的Future，该Future会直接调用catchError的回调函数
futureTestError(){
  Future.error(Exception('错误信息')).catchError((error){
    print(error);
  });
}
//延迟一定时间时执行回调函数，执行完回调函数后会执行then的回调
futureTestDelay(){
  Future.delayed(Duration(seconds: 3),(){
    return '3s后信息';
  }).then((value){
    print(value);
  });
}

/* 2. await、async
*用同步的代码格式，去实现异步的调用过程
* 通常一个async的函数会返回一个Future
* */
networkTest4(){
  print("main function start");
  getNetworkData2().then((value){
    print('result' + value);
  });
  print("main function end");
}

Future<String> getNetworkData2() async {
  var result = await Future.delayed(Duration(seconds: 3),(){
    return 'network data';
  });
  return '请求的数据' + result;
}

/*微任务队列
*微任务队列的优先级要高于事件队列
* 也就是说事件循环都是优先执行微任务队列中的任务，再执行 事件队列 中的任务
* 所有的外部事件任务都在事件队列中，如IO、计时器、点击、以及绘制事件等；
而微任务通常来源于Dart内部，并且微任务非常少。
因为如果微任务非常多，就会造成事件队列排不上队，会阻塞任务队列的执行（比如用户点击没有反应的情况）
*
*
*1、Dart的入口是main函数，所以main函数中的代码会优先执行；
*2、main函数执行完后，会启动一个事件循环（Event Loop）就会启动，启动后开始执行队列中的任务；
*3、首先，会按照先进先出的顺序，执行 微任务队列（Microtask Queue）中的所有任务；
*4、其次，会按照先进先出的顺序，执行 事件队列（Event Queue）中的所有任务
* */
//如何创建微任务
//如果我们有一个任务不希望它放在Event Queue中依次排队，那么就可以创建一个微任务了
createMicrotask(){
  scheduleMicrotask((){
    print('hello microtask');
  });
}
//Future的代码是加入到事件队列还是微任务队列呢？
//Future中通常有两个函数执行体：1。Future构造函数传入的函数体 2。then的函数体（catchError等同看待）
/*Future构造函数传入的函数体放在事件队列中
then的函数体要分成三种情况：
情况一：Future没有执行完成（有任务需要执行），那么then会直接被添加到Future的函数执行体后；
情况二：如果Future执行完后就then，该then的函数体被放到如微任务队列，当前Future执行完后执行微任务队列；
情况三：如果Future是链式调用，意味着then未执行完，下一个then不会执行
// future_1加入到eventqueue中，紧随其后then_1被加入到eventqueue中
Future(() => print("future_1")).then((_) => print("then_1"));

// Future没有函数执行体，then_2被加入到microtaskqueue中
Future(() => null).then((_) => print("then_2"));

// future_3、then_3_a、then_3_b依次加入到eventqueue中
Future(() => print("future_3")).then((_) => print("then_3_a")).then((_) => print("then_3_b"));
* */

/*
* 代码分析：
1、main函数先执行，所以main start和main end先执行，没有任何问题；
2、main函数执行过程中，会将一些任务分别加入到EventQueue和MicrotaskQueue中；
3、task7通过scheduleMicrotask函数调用，所以它被最早加入到MicrotaskQueue，会被先执行；
4、然后开始执行EventQueue，task1被添加到EventQueue中被执行；
5、通过final future = Future(() => null);创建的future的then被添加到微任务中，微任务直接被优先执行，所以会执行task6；
6、一次在EventQueue中添加task2、task3、task5被执行；
7、task3的打印执行完后，调用scheduleMicrotask，那么在执行完这次的EventQueue后会执行，所以在task5后执行task4（注意：scheduleMicrotask的调用是作为task3的一部分代码，所以task4是要在task5之后执行的）
8、task8、task9、task10一次添加到EventQueue被执行；*/

taskOperateOrder(){
  print('main start');

  Future(() => print('task1'));

  final future = Future(() => null);
  
  Future(() => print('task2')).then((_){
    print('task3');
    scheduleMicrotask(() => print('task4'));
  }).then((value) => print('task5'));

  future.then((_) => print('task6'));
  scheduleMicrotask(() => print('task7'));

  Future(()=>print('task8'))
    .then((_) => Future(() => print('task9')))
    .then((_) => print('task10'));

  print('main end');
}
