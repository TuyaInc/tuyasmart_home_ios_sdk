# 涂鸦全屋智能 iOS SDK

---

## 功能概述

涂鸦全屋智能 APP SDK 提供了与硬件设备、涂鸦云的接口封装，加速应用开发过程，主要包括了以下功能：

- 账户体系（手机号、邮箱的注册和登录、重置密码，session 失效处理等和用户体系相关的功能）

- 硬件设备（设备配网、设备控制、设备的状态上报、群组、定时任务、固件升级）
- 家庭体系 （家庭管理、房间管理、家庭共享等功能）

## 快速集成

### 使用Cocoapods集成

在`Podfile`文件中添加以下内容：

```ruby
platform :ios, '8.0'

target 'your_target_name' do

   pod "TuyaSmartHomeKit"

end
```

然后在项目根目录下执行`pod update`命令，集成第三方库。

CocoaPods的使用请参考：[CocoaPods Guides](https://guides.cocoapods.org/)

## 初始化 SDK

1. 打开项目设置，Target => General，修改`Bundle Identifier`为涂鸦开发者平台对应的iOS包名

2. 导入安全图片到工程根目录，重命名为`t_s.bmp`，并加入「项目设置 => Target => Build Phases => Copy Bundle Resources」中。

3. 在项目的`PrefixHeader.pch`文件添加以下内容：

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Swift 项目可以添加在 `xxx_Bridging-Header.h` 桥接文件中添加以下内容

```
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

4. 打开`AppDelegate.m`文件，在`[AppDelegate application:didFinishLaunchingWithOptions:]`方法中初始化SDK：

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

