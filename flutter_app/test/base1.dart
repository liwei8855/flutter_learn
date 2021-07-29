main(List<String> args){
  print("hello word");

  base1();
  changeType();
  finalAndConst();
  shareObject();
  parseType();
  boolType();
  listType();
  setType();
  mapType();
}

//1.基础
base1(){
  String name = 'jack';
  int age = 18;
  double height = 1.88;
  print('${name},${age},${height}');
  print('变量当前类型：${name.runtimeType}');
}

//2.dynamic 改变变量类型
changeType(){
  /*
  一般不能改变变量类型，确实需要用 dynamic声明
  * */
  dynamic changeType = 'change';
  print('改变变量类型前：${changeType.runtimeType}');
  changeType = 1;
  print('改变变量类型后：${changeType.runtimeType}');
}

//3.final & const
/*都是定义常量，定义之后值不可以修改
const在赋值时, 赋值的内容必须是在编译期间就确定下来的
final在赋值时, 可以动态获取, 比如赋值一个函数,只能赋值一次
* */
finalAndConst(){
  final name = 'jack';
//  name = 'rose';
  const age = 18;
//  age = 16;

//  const name1 = getName();
  final name2 = getName();
}
String getName(){
  return 'jim green';
}
//const放在赋值语句的右边，可以共享对象，提高性能
class Person{
  const Person();
}
shareObject(){
  final a = const Person();
  final b = const Person();
  print('${a.runtimeType} ${b.runtimeType}');
  print(identical(a, b));

  final m = Person();
  final n = Person();
  print('${m.runtimeType} ${n.runtimeType}');
  print(identical(m, n));
}

//4.数值类型 整数int 浮点double
/*Dart中的int和double可表示的范围并不是固定的，它取决于运行Dart的平台
* */

//5.字符串和数字转化
parseType(){
  var one = int.parse('111');
  var two = double.parse('12.12');
  print('${one} ${one.runtimeType} ${two} ${two.runtimeType}');

  var num1 = 123;
  var num2 = 12.128;
  var str1 = num1.toString();
  var str2 = num2.toStringAsFixed(2);//保留两位小数 会四舍五入
  print('${num1} ${num1.runtimeType} ${num2} ${num2.runtimeType}');
  print('${str1} ${str1.runtimeType} ${str2} ${str2.runtimeType}');
}

//6.布尔类型
boolType(){
  var isFlag = true;
  print('${isFlag} ${isFlag.runtimeType}');
  var message = 'message';
//  if(message){ //不能判断非0即真, 或者非空即真
  if(message!=null){
    print(message);
  }
}

//7.集合类型 List / Set / Map
listType(){
  var array = ['a','b','c','d'];
  print('$array ${array.runtimeType}');//List<String>
}
//Set是无序的，并且元素是不重复的
setType(){
  var setType = {'a','b','c','d'};
  print('$setType ${setType.runtimeType}');//_CompactLinkedHashSet<String>
  //指定类型
  Set<int> numbers = {1,2,3,4};
  print('$numbers ${numbers.runtimeType}');//_CompactLinkedHashSet<int>
}

mapType(){
  var info = {'name': 'why', 'age': 18};
  print('$info ${info.runtimeType}');//_InternalLinkedHashMap<String, Object>
  //指明类型
  Map<String,Object> infoMap = {'height': 1.88, 'address': '北京市'};
  print('$infoMap ${infoMap.runtimeType}');//_InternalLinkedHashMap<String, Object>
}

//集合操作
/*1.获取长度： length
* */
mapOperate(){
  var info = {'name': 'why', 'age': 18};
  print(info['name']);
  //获取所有entries
  print('${info.entries} ${info.entries.runtimeType}');
  //获取所有keys
  print('${info.keys} ${info.keys.runtimeType}');
  //获取所有的values
  print('${info.values} ${info.values.runtimeType}');
  //判断是否包含某个key或者value
  print('${info.containsKey('name')} ${info.containsValue(18)}');

}