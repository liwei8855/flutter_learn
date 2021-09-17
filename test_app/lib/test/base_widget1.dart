/*
* StatelessWidget的build方法什么情况下被执行
* 1、当我们的StatelessWidget第一次被插入到Widget树中时（也就是第一次被创建时）；
2、当我们的父Widget（parent widget）发生改变时，子Widget会被重新构建；
3、如果我们的Widget依赖InheritedWidget的一些数据，InheritedWidget数据发生改变时
* */

/*
* StatefulWidget生命周期
*
* StatelessWidget可以由父Widget直接传入值，调用build方法来构建，整个过程非常简单；
 StatefulWidget需要通过State来管理其数据，并且还要监控状态的改变决定是否重新build整个Widget
*
* 1、执行StatefulWidget的构造函数（Constructor）来创建出StatefulWidget；
* 2、执行StatefulWidget的createState方法，来创建一个维护StatefulWidget的State对象；
其次，调用createState创建State对象时，执行State类的相关方法：
    1、执行State类的构造方法（Constructor）来创建State对象
    2、执行initState，我们通常会在这个方法中执行一些数据初始化的操作，或者也可能会发送网络请求；
    3、执行didChangeDependencies方法，这个方法在两种情况下会调用
       情况一：调用initState会调用；
       情况二：从其他对象中依赖一些数据发生改变时，比如前面我们提到的InheritedWidget
    4、Flutter执行build方法，来看一下我们当前的Widget需要渲染哪些Widget
    5、当前的Widget不再使用时，会调用dispose进行销毁
    6、手动调用setState方法，会根据最新的状态（数据）来重新调用build方法，构建对应的Widgets
    7、执行didUpdateWidget方法是在当父Widget触发重建（rebuild）时，系统会调用didUpdateWidget方法
* */
