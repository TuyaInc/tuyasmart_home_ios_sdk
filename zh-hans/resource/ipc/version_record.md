# 更新日志

## 文档更新记录

| 版本号 | 编写/修订说明 | 修订人 | 修订时间   |
| ------ | ------------- | ------ | ---------- |
| v1.0.0 | 创建          | 傅浪   | 2020-03-01 |
| v1.1.0 | 更新          | 傅浪   | 2020-06-05 |



## SDK 更新记录

### 3.17.0 (2020-06-05)

| 模块                | 版本   |      |
| ------------------- | ------ | ---- |
| TuyaCameraSDK       | 3.17.3 |      |
| TuyaSmartCameraBase | 4.17.0 |      |
| TuyaSmartCameraM    | 4.17.3 |      |
| TuyaSmartCameraT    | 4.17.6 |      |
| TuyaSmartCameraKit  | 4.17.1 |      |

**更新说明**

* P2P 通信库升级，提升连接速度和稳定性。
* 获取 p2p config 数据的接口需要更新为 `tuya.m.rtc.session.init`，版本是 `1.0`。

### 3.15.0 (2020-02-21)

| 模块                | 版本   |
| ------------------- | ------ |
| TuyaCameraSDK       | 3.15.3 |
| TuyaSmartCameraBase | 4.4.2  |
| TuyaSmartCameraM    | 4.3.4  |
| TuyaSmartCameraKit  | 4.4.4  |

**更新说明**

* TuyaCamera 更名为 TuyaCameraSDK，如果有在 podfile 中指定 TuyaCamera 的版本号，需要改一下库名和版本。
* 去除掉了部分尚未标准化（文档中未介绍过）的类和接口。
* 报警消息、云存储事件中的图片改为不加密的状态。
* 修复一些稳定性问题。

### 3.13.3 (2019-12-20)

| 模块                | 版本号 |
| ------------------- | ------ |
| TuyaSmartCameraBase | 4.2.6  |
| TuyaSmartCameraM    | 4.2.6  |
| TuyaCamera          | 3.13.4 |

**更新说明**

* 增加获取对讲时所采集的音频数据的接口，以供开发者对音频数据二次处理

### 3.13.0 (2019-12-05)

| 模块                | 版本   |
| ------------------- | ------ |
| TuyaSmartCameraBase | 4.2.5  |
| TuyaSmartCameraM    | 4.2.5  |
| TuyaSmartCameraKit  | 4.3.2  |
| TuyaCamera          | 3.13.3 |

**更新说明**

* P2P 和 音视频解码库独立为 TuyaCamera 组件，改为动态库方式，以解决相关库版本冲突问题。
* 增加录制、截图，保存到指定文件路径的接口。

### 3.10.0 (2019-10-25)

| 模块                         | 版本  |
| ---------------------------- | ----- |
| TuyaSmartCameraBase          | 4.0.2 |
| TuyaSmartCameraM             | 4.0.2 |
| TuyaSmartCameraKit           | 4.0.1 |
| TYCameraCloudServicePanelSDK | 0.2.1 |
| TuyaSmartLogger              | 0.1.0 |




