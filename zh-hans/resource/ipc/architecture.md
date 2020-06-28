# SDK 架构说明

## SDK 架构

### 简介

Camera SDK 基于 Home SDK 封装了智能摄像机的相关功能。整个 SDK 分为四个部分，基础工具库，网络通信层，核心功能层，摄像机垂直业务层。

* 基础工具库提供一些常用的工具方法，如 JSON 序列化，字符串编解码等。
* 网络通信层封装了 Https，MQTT，Socket，p2p 等网络通道实现。
* 核心功能层提供用户管理，家庭管理，设备管理，摄像机基础功能。
* 摄像机垂直业务层提供设备功能点，报警消息，云存储视频管理等业务功能。

### 架构图

![architecture](./images/architecture.jpg)

### 组件模块

Camera SDK 依赖一部分 Home SDK 中的组件，包括账户管理，家庭设备管理，设备配网，基础通信模块等。在使用 Cocoapods 导入 Camera SDK 时，会自动导入依赖的组件。

**模块说明**

| 模块                         | 说明                                             |
| ---------------------------- | ------------------------------------------------ |
| TuyaSmartCameraKit           | 摄像机设备功能点，云存储管理，报警消息等业务功能 |
| TYCameraCloudServicePanelSDK | 涂鸦云存储服务购买功能                           |
| TuyaSmartCameraBase          | 摄像机基本功能接口                               |
| TuyaSmartCameraM             | 摄像机功能实现                                   |
| TuyaSmartDeviceKit           | 涂鸦智能家庭和设备管理                           |
| TuyaSmartActivatorKit        | 设备配网功能                                     |
| TuyaSmartBaseKit             | 用户管理，涂鸦云端通用接口功能                   |
| TuyaCameraSDK                | 涂鸦摄像机 p2p 网络通道实现                      |
| TuyaSmartSocketChannelKit    | 涂鸦 Socket 网络通道实现                         |
| TuyaSmartMQTTChannelKit      | 涂鸦 MQTT 网络通道实现                           |
| TuyaSmartUtil                | 基础工具方法实现                                 |



