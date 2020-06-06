# 涂鸦智能门锁 iOS SDK

涂鸦智能门锁 iOS SDK 提供了与智能门锁设备、涂鸦云的接口封装，加速和简化门锁应用功能开发过程，主要包括了以下功能：

- 门锁密码解锁（包括动态密码获取、临时密码管理、指纹、卡片解锁等相关的功能）

- 门锁使用记录（包括门锁开锁记录、门铃记录、报警记录等功能）

- 门锁用户体系 （包括门锁用户管理、关联密码等功能）

  


## 准备工作

该 SDK 依赖于涂鸦全屋智能 SDK，基于此基础上进行拓展开发，准备工作请查阅[涂鸦全屋智能 SDK 集成准备章节](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Preparation.html)



## 快速集成

### 使用 Cocoapods 集成

在 `Podfile` 文件中添加以下内容：

```ruby
platform :ios, '8.0'

target 'your_target_name' do
   pod "TuyaSmartLockKit"
end
```

然后在项目根目录下执行 `pod update` 命令，集成第三方库。

CocoaPods 的使用请参考：[CocoaPods Guides](https://guides.cocoapods.org/)



### 头文件导入

Objective-C 项目在需要使用的地方添加

```objective-c
#import <TuyaSmartLockKit/TuyaSmartLockKit.h>
```

Swift 项目在需要使用的地方添加

```
import TuyaSmartLockKit
```

