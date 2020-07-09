# 扫地机 SDK



##  功能概述

涂鸦智能扫地机 iOS SDK 是在[涂鸦智能 iOS SDK](https://github.com/TuyaInc/tuyasmart_home_ios_sdk) （下文简介为: Home SDK）的基础上扩展了接入扫地机设备相关功能的接口封装，加速开发过程。主要包括了以下功能：

- 流媒体（用于陀螺仪型或视觉型扫地机）通用数据通道
- 激光型扫地机数据传输通道
- 激光型扫地机实时/历史清扫记录
- 扫地机通用语音下载服务

## 准备工作

涂鸦智能 iOS 扫地机 SDK 依赖于涂鸦智能 Home SDK，基于此基础上进行拓展开发，在开始开发前，需要在涂鸦智能开发平台上注册开发者账号、创建产品等，并获取到激活 SDK 的密钥，具体的操作流程请参考[涂鸦全屋智能 SDK 集成准备章节](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Preparation.html)

## 快速集成

在 `Podfile` 文件中添加以下内容：

```ruby
platform :ios, '9.0'

target 'your_target_name' do
   pod "TuyaSmartSweeperKit"
end
```

然后在项目根目录下执行 `pod update` 命令，集成第三方库。

CocoaPods 的使用请参考：[CocoaPods Guides](https://guides.cocoapods.org/) 

## 头文件引入

在项目的`PrefixHeader.pch`文件添加以下内容：

```objc
#import <TuyaSmartSweeperKit/TuyaSmartSweeperKit.h>
```

Swift 项目可以添加在 `xxx_Bridging-Header.h` 桥接文件中添加以下内容

```
#import <TuyaSmartSweeperKit/TuyaSmartSweeperKit.h>
```