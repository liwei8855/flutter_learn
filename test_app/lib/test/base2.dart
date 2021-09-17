import 'dart:math';

main(List<String> args){

}

//
test1(){
  var num = 7;
  print(num / 3); // 除法操作, 结果2.3333..
  print(num ~/ 3); // 整除操作, 结果2;
  print(num % 3); // 取模操作, 结果1;

  //1.赋值运算符 ??=
  //当变量为null时，使用后面的内容进行赋值,当变量有值时，使用自己原来的值
  var name = null;
  name ??= 'jack';
  print(name);

  //2.条件运算符 expr1 ?? expr2
  //如果expr1是null，则返回expr2的结果
  //如果expr1不是null，直接使用expr1的结果
  var temp = null;
  var temp1 = temp??'jim';

  //3.级联语法：..
  final persion = Person('jim',10)
  ..name = 'tom'
  ..run()
  ..eat();

  Person.attendClass();//类方法

  //枚举
  print('${Colors.red.index},${Colors.green.index}');
  print(Colors.values);
}

//类
//1。构造方法
//当类中没有明确指定构造方法时，将默认拥有一个无参的构造方法
//当有了自己的构造方法时，默认的构造方法将会失效，因为Dart本身不支持函数的重载（名称相同, 参数不同的方式）

//2.命名构造方法
//因为不支持方法（函数）的重载，所以我们没办法创建相同名称的构造方法。
//我们需要使用命名构造方法
//重定向构造方法:在一个构造方法中去调用另外一个构造方法, 这个时候可以使用重定向构造方法

//3.类方法
//static关键字来定义类方法

class Person {
  var name;
  var age;
  //构造函数
//  Person(String name,int age){
//    this.name = name;
//    this.age = age;
//  }
  //语法糖
  Person(this.name,this.age);

  //命名构造方法
  Person.withArgments(String name,int age){
    this.name = name;
    this.age = age;
  }

  //重定向构造方法
  Person.fromName(String name):this(name,0);

  //map转对象
  Person.fromMap(Map<String, Object> map){
    this.name = map['name'];
    this.age = map['age'];
  }

  void run(){
    print('${name} is run');
  }
  void eat(){
    print('${name} is eat');
  }

  //类方法
  static attendClass(){
    print('去上课');
  }
}

//初始化列表

class Point {
  final num x;
  final num y;
  final num distance;
  //初始化列表
  Point(this.x,this.y): distance = sqrt(x*x + y*y);
}

//常量构造方法
//注意一：拥有常量构造方法的类中，所有的成员变量必须是final修饰的
//注意二: 为了可以通过常量构造方法，创建出相同的对象，不再使用 new关键字，而是使用const关键字
//如果是将结果赋值给const修饰的标识符时，const可以省略
class Person1{
  final String name;
  const Person1(this.name);
}

//工厂构造方法
//class Person2{
//
//  String name;
//  static final Map<String, Person2> _cache = <String, Person2>{};
//
//
//  factory Person2(String name){
//    if(_cache.containsKey(name)){
//      return _cache[name];
//    } else {
//      final p = Person2._internal(name);
//      _cache[name] = p;
//      return p;
//    }
//  }
//
//  Person2._internal(this.name);
//}

//getter setter监控类属性被访问的过程
class Dog{
  String color;
  Dog(this.color);

  String get getColor{
    return color;
  }

  set setColor(String color){
    this.color = color;
  }
}

//类的继承
//子类的构造方法在执行前，将隐含调用父类的无参默认构造方法（没有参数且与类同名的构造方法）
//如果父类没有无参默认构造方法，则子类的构造方法必须在初始化列表中通过super显式调用父类的某个构造方法
class Erha extends Dog {
  Erha(String color) : super(color);
}

//抽象类 类方法
//抽象方法，必须存在于抽象类中
abstract class Shape{
  getArea();
}

class Circle extends Shape{
  double r;
  Circle(this.r);
  @override
  getArea() {
    return r*r*3.14;
  }
}

//隐式接口
//Dart不支持多继承，通过抽象类实现
abstract class Runner{
  run();
}
abstract class Flyer{
  fly();
}

class SuperMan implements Runner,Flyer{
  @override
  run() {
    print('run');
  }
  @override
  fly() {
    print('fly');
  }
}

//Mixin混入
//在通过implements实现某个类时，类中所有的方法都必须被重新实现(无论这个类原来是否已经实现过该方法)
//某些情况下，一个类可能希望直接复用之前类的原有实现方案
//通过mixin定义的类用于被其他类混入使用，通过with关键字来进行混入
mixin RunnerM{
  run(){
    print('Run mixin');
  }
}
mixin FlyerM{
  fly(){
    print('Fly mixin');
  }
}
//// implements的方式要求必须对其中的方法进行重新实现
class SuperManM with RunnerM, FlyerM {
  //可以选择实现父类的方法
}

//枚举
//注意一: 您不能子类化、混合或实现枚举。
//注意二: 不能显式实例化一个枚举

//枚举类型中有两个比较常见的属性
//index: 用于表示每个枚举常量的索引, 从0开始.
//values: 包含每个枚举值的List.
enum Colors{
  red,
  green,
  blue
}

//类定义的泛型

//不确定属性的类型：
//方法一：使用Object类型, 但是在之后使用时, 非常不方便
class Location{
  Object x;
  Object y;
  Location(this.x,this.y);
}
//方法二：Location类的定义: 泛型方式
class LocationF<T>{
  T x;
  T y;
  LocationF(this.x,this.y);
}
//如果我们希望类型只能是num类型
class LocaitonNum<T extends num>{
  T x;
  T y;
  LocaitonNum(this.x,this.y);
}
//泛型方法的定义
T getFirst<T>(List<T> ts){
  return ts[0];
}









