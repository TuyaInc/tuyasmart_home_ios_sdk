# 涂鸦全屋智能 iOS SDK

---

## 功能概述

iOS Home SDK 是一套涂鸦智能针对全屋智能领域提供的 iOS 9.0 及以上版本的 SDK。iOS 开发者可以基于 SDK 快速的实现 APP 功能开发，实现对智能设备的配网，控制，固件升级，定时任务，智能场景等操作。

SDK 主要包括以下功能：

- 账户体系（手机号、邮箱的注册和登录、重置密码，session 失效处理等用户体系相关的功能）
- 家庭体系 （家庭管理、房间管理、家庭共享等功能）
- 硬件设备（设备配网、设备控制、设备的状态上报、群组、定时任务、固件升级）



## 快速集成

### 使用 Cocoapods 集成

在`Podfile`文件中添加以下内容：

```ruby
platform :ios, '9.0'

target 'your_target_name' do

   pod "TuyaSmartHomeKit"

end
```

然后在项目根目录下执行 `pod update` 命令，集成第三方库。

CocoaPods的使用请参考：[CocoaPods Guides](https://guides.cocoapods.org/)

## 初始化 SDK

1. 打开项目设置，Target => General，修改 `Bundle Identifier` 为涂鸦开发者平台对应的 iOS 包名

2. 导入安全图片到工程根目录，重命名为 `t_s.bmp`，并加入「项目设置 => Target => Build Phases => Copy Bundle Resources」中。

3. 在项目的`PrefixHeader.pch`文件添加以下内容：

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Swift 项目可以在 `xxx_Bridging-Header.h` 桥接文件中添加以下内容

```
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

4. 打开`AppDelegate.m`文件，在`[AppDelegate application:didFinishLaunchingWithOptions:]`方法中初始化SDK：

**接口说明**

初始化 SDK

```objc
- (void)startWithAppKey:(NSString *)appKey secretKey:(NSString *)secretKey;
```

**参数说明**

| **参数**  | **说明**    |
| --------- | ----------- |
| appKey    | App key     |
| secretKey | App 密钥key |

**实例代码**

Objc:

```objc
[[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
```

Swift:

```swift
 TuyaSmartSDK.sharedInstance()?.start(withAppKey: <#your_app_key#>, secretKey: <#your_secret_key#>)
```



至此，准备工作已经全部完毕，可以开始App开发啦。

### Debug 模式

在开发的过程中可以开启 Debug 模式，打印一些日志用于分析问题。



Objc:

```objc
#ifdef DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#else
#endif
```

Swift:

```swift
#if DEBUG
   TuyaSmartSDK.sharedInstance()?.debugMode = true
#else
#endif
```

