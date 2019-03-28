# TuyaSmartHomeKit iOS SDK Change Log

## 2.8.44(2019-03-28)

- 修复 Wi-Fi 子设备在线异常问题
- Fixed an online problem with Wi-Fi subdevices

## 2.8.43(2019-03-15)

- 新的加密方式：需要在涂鸦开发者平台申请应用的 Appkey，AppSecret，iOS安全图片，bundleId

- New encryption:  Appkey, AppSecret, iOS security images, bundleId for application on Tuya Developer Platform

## 0.2.2(2019-01-19)
bug fixed

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
  - single bluetooth
- TuyaSmartBLEMeshKit
  - Ble mesh

## 0.1.6 (2018-12-26)

- bug fixed : Time zoneId update 

## 0.1.5 (2018-12-26)

- add : Low power consumption wake up method

## 0.1.4 (2018-12-26)

- bug fixed : TuyaSmartUser Avatars url updated, no update local cache

## 0.1.3 (2018-11-20)

- 添加更新用户时区接口

## 0.1.0 (2018-10-30)

-  控制台日志输出问题

## 0.0.20 (2018-10-25)

- 添加设备的数据流通道
- 文档更新

## 0.0.19 (2018-09-27)

- add api merger service

## 0.0.18 (2018-09-21)

-  去掉依赖 SDVersion'

## 0.0.17 (2018-09-18)

- 新的群组控制
- MQTT控制优化
- 群组分享更新

## 0.0.16 (2018-08-30)

- 新增获取设备的信号强度  

## 0.0.15 (2018-08-13)
- 群组功能更新
- bug fixed
- ble mesh 更新 

## 0.0.11 (2018-06-29)
- 固件升级 bug fixed
- 智能场景接口更新

## 0.0.7 (2018-06-25)
- 固件升级接口更新
- MQTTClient 版本指定为 0.14.0
- add Demo
- 添加 邮箱注册 2.0
- 添加 停用账号 
- 添加 zigbee子设备激活

## 0.0.3 (2018-05-21)
- 添加邀请分享接口

## 0.0.2 (2018-05-12)
- 更新 uid 登录注册接口
- 文档更新

## 0.0.1 (2018-03-13)
