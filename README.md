# flutter_learn
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
