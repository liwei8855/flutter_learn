# flutter source code learn

# 一、源码配置

# 二、源码结构
flutter/flutter目录结构
bin
  ｜-flutter # flutter tool的启动脚本
  ｜-internal
    ｜-engine.version # Framework对应的Engine版本
    ｜-shared.sh #flutter命令的内部逻辑
    ｜-update_dart_sdk.sh #flutter sdk的更新逻辑
examples #flutter示例工程
packages
  |-flutter #flutter sdk源码
  |-flutter_driver #flutter集成测试相关代码
  |-flutter_goldens #flutter ui测试相关代码
  |-flutter_localizations # 国际化相关
  |-flutter_test # flutter单元测试相关代码
  |-flutter_tools #flutter tool 源码
  |-flutter_web_plugins #flutter web相关代码
version #flutter sdk版本

flutter/engine的目录（flutter/src/）
-flutter
assets #资源读取
common #公共逻辑
flow #渲染管道相关逻辑
flutter_frontend_server #Dart构建相关逻辑
fml #消息循环相关
lib #Dart Runtime及渲染和web相关逻辑
runtime #dart runtime相关逻辑
shell
  |-platform
    |-android #android embedder相关逻辑
    |-common #embedder 公共逻辑
sky
testing #测试相关
third_party

engine部分c++组成，最终机器码和运行平台与cpu架构强相关，不同平台embedder有所不同。
构建engine：gn工具目录src/flutter/tools/gn
flutter-engine 依赖 dart-sdk，而 dart-sdk 仅在目标平台为 host 的时候才会编译的，所以我们需要执行多个 gn 命令
<code>code</code>



