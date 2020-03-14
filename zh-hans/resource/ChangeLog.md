# Change Log

## 3.14.0(2019-12-21)

- 新增功能
  - `MQTTClient` 升级到 `0.15.2` 版本
  - HTTP 请求和响应数据加密
  - 新增家庭角色权限管理
  - 场景 SDK 增加缓存
  - 增加创建场景条件和场景动作的便捷工具类
  - 支持 Apple ID 登录
  - Bug Fixed

## 3.13.0(2019-12-06)

- 新增功能
  - 支持标准 Dp Code 控制
  - 家庭权限角色支持多样性

## 3.12.0(2019-09-21)

- 功能变化
  - 设备支持更新头像
  - 支持 Wi-Fi 和蓝牙双模设备
  - 支持子设备 OTA
  - 固件升级添加升级中的代理回调
  - AP 配网优化
  - 定时支持备注和推送功能
  - 支持 SigMesh 设备
  - Bug 修复

## 2.12.46(2019-07-22)

- Bug 修复，推送消息可分类开启

## 2.10.97(2019-06-20)

- 兼容新版本 Cocoapods (>=1.6.0)

## 2.10.96(2019-05-11)

- Bug 修复，新增免密码配网，新增消息推送的开启和关闭，新增开发环境推送支持

## 2.8.44(2019-03-28)

- 修复 Wi-Fi 子设备在线异常问题

## 2.8.43(2019-03-15)

- 新的加密方式：需要在涂鸦开发者平台申请应用的 Appkey，AppSecret，iOS 安全图片，BundleId


## 0.2.2(2019-01-19)
Bug Fixed

## 0.2.1(2019-01-08)
TuyaSmartHomeKit iOS SDK functions split:

 - TuyaSmartUtil 
   
    - Utility classes, including category etc
    
- TuyaSmartBaseKit 
    - Account system (phone number, email registration, login, password reset)
    
    - HTTP API interface
    
- TuyaSmartDeviceKit
  -  Home, room, group, device manager
  -  network configuration
  -  Device control
  -  Shared devices
- TuyaSmartTimerKit
  
  - Timer task
- TuyaSmartSceneKit
  
  - Smart scene
- TuyaSmartFeedbackKit
  
  - Feedback
- TuyaSmartMessageKit
  
  - Message center
- TYBluetooth
  
   - Bluetooth base 
- TuyaSmartBLEKit
  
  - Single bluetooth
- TuyaSmartBLEMeshKit
  
  - Ble mesh

## 0.1.6 (2018-12-26)

- Bug Fixed : Time zoneId update 

## 0.1.5 (2018-12-26)

- Add : Low power consumption wake up method

## 0.1.4 (2018-12-26)

- Bug Fixed : TuyaSmartUser Avatars url updated, no update local cache

## 0.1.3 (2018-11-20)

- 添加更新用户时区接口

## 0.1.0 (2018-10-30)

-  控制台日志输出问题

## 0.0.20 (2018-10-25)

- 添加设备的数据流通道
- 文档更新

## 0.0.19 (2018-09-27)

- Add Api Merger Service

## 0.0.18 (2018-09-21)

-  去掉依赖 SDVersion'

## 0.0.17 (2018-09-18)

- 新的群组控制
- MQTT 控制优化
- 群组分享更新

## 0.0.16 (2018-08-30)

- 新增获取设备的信号强度  

## 0.0.15 (2018-08-13)
- 群组功能更新
- Bug Fixed
- BLE Mesh 更新 

## 0.0.11 (2018-06-29)
- 固件升级 Bug Fixed
- 智能场景接口更新

## 0.0.7 (2018-06-25)
- 固件升级接口更新
- MQTTClient 版本指定为 0.14.0
- Add Demo
- 添加 邮箱注册 2.0
- 添加 停用账号 
- 添加 ZigBee子设备激活

## 0.0.3 (2018-05-21)
- 添加邀请分享接口

## 0.0.2 (2018-05-12)
- 更新 Uid 登录注册接口
- 文档更新

## 0.0.1 (2018-03-13)