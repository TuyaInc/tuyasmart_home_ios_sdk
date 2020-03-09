##### 1. 为什么执行 `pod install` 会报错？  

- 确认 CocoaPods 是最新版本，执行 `pod --version` 命令查看版本，确认版本是 1.3.0 以上

##### 2. 为什么调用 SDK 接口以后，会报 `Error Domain=NSURLErrorDomain Code=-999 "已取消"` 的错误? 

- 确认请求的对象是全局变量，否则会被提早释放，例如： `self.feedBack = [[TuyaSmartFeedback alloc] init];`

##### 3. 如何开启调试模式，打印日志？

- 在初始化 SDK 之后，调用以下代码：`[[TuyaSmartSDK sharedInstance] setDebugMode:YES];`

##### 4、下发控制指令，设备没有上报状态。  

- 确认功能点的数据类型是否正确，比如功能点的数据类型是数值型（value），那控制命令发送的应该是 @{@"2": @(25)} 而不是 @{@"2": @"25"}。

##### 5. iOS 12 使用 `[[TuyaSmartActivator sharedInstance] currentWifiSSID]` 无法获取到 SSID 。

在 Xcode 10 中获取 WiFi 信息需要开启相关权限，解决方案：

- `Xcode` -> [Project Name] -> `Targets` -> [Target Name] -> `Capabilities` -> `Access WiFi Information` -> `ON`

打开上述权限即可。

![](./images/ios-sdk-wifi-access.png)

##### 6. 升级 SDK 至 >=2.8.0 版本之后，SDK 初始化之后 App 立即闪退。提示 `Terminating app due to uncaught exception 'start sdk error', reason: 'security image not found'`

- 从 SDK 2.8.0 版本之后加入了安全图片校验，并启用了新的 AppKey / AppSecret 。请按照[准备工作](./Preparation.md)章节前往开发者平台重新生成 SDK 初始化所需文件。

##### 7. 基于 SDK 开发的 App ，上传了推送证书，却收不到推送信息

- 确认 Xcode 的 Push Notification 是否打开
- 去涂鸦开发者平台上传 push 证书
- 在  `didFinishLaunchingWithOptions`  方法中初始化 push 方法
- 涂鸦开发者平台 - 用户运营 - 消息中心 - 新增消息
- 详见：[集成 Push ](./Push.md)章节

##### 8. Demo编译失败，提示 `library not found for -XXX`

- 确认你打开的工程为 `.xcworkspace` 而不是 `.xcproject` 。详见：[CocoaPods Guides](https://guides.cocoapods.org/)


##### 9. iOS 13 SDK 权限变化
- 详见：[iOS 13 适配](./iOSAdaptation.md#ios-13-适配)章节

##### 10. 为什么SDK 获取本地语言为英文，而不是手机系统的语言？

- 因为 SDK 现在获取的本地语言是根据 `[[NSBundle mainBundle] preferredLocalizations]` 获取的，所以需要在工程中创建国际化语言

##### 11. SDK 是否支持红外设备控制？

- 现在 SDK 不支持红外设备控制

##### 12. 为什么设备控制合并发送了多个功能点（dps），没有收到所有的功能点响应？

- 设备控制发送多个功能的时候，需要先去判断功能点是否有冲突，例如照明的设备，可以把灯的亮度，冷暖功能点放在一块发送。但是当把开关，亮度，冷暖 3 个功能点放在一块，就会存在有些功能点执行没有响应的问题。所以建议将没功能冲突的功能放在一块发送。

##### 13. 如果没有蓝牙功能是否可以不依赖 SDK 蓝牙模块，减少包大小？

- 可以的，只需要设备配网和控制功能可以只依赖下面两个模块

```ruby
# 家庭管理，设备，房间，群组管理相关功能
pod 'TuyaSmartDeviceKit',
# 设备配网相关功能
pod 'TuyaSmartActivatorKit',
```

- 下面模块可以根据实际需要去引用

```ruby
# 单点蓝牙相关功能
pod 'TuyaSmartBLEKit', 
# sigMesh 相关功能
pod 'TuyaSmartBLEMeshKit',
# 智能场景相关功能
pod 'TuyaSmartSceneKit', 
# 设备和群组定时相关功能
pod 'TuyaSmartTimerKit',
# 消息中心相关功能
pod 'TuyaSmartMessageKit',
# 问题反馈相关功能
pod 'TuyaSmartFeedbackKit',
```

##### 14. SDK 集成错误，显示 `Undefined symbols xxx`

* 一般是由于引用的 SDK 各个组件版本不一致导致，确认引用的每个库是否都是统一版本（最高位和中位一致，例如: 3.12.1, 3.12.5..），如果不是，使用 `pod update` 进行更新后，重新编译即可

##### 15. Xcode 11 找不到 application loader

* 从 Xcode 11 开始，不再内置 `application loader` ，苹果官方出了一个新的 ipa 上传工具，可以直接在 mac 应用商店搜 `Transporter` 进行 ipa 上传

##### 16. 接口提示签名错误

* 确认 bundleId、appKey、appSecret、安全图片是否与 IoT 平台上的信息一致，任意一个不匹配都将校验失败。具体请按照[准备工作](./Preparation.md)章节来进行检查

##### 17. pod install 时提示 `CDN: trunk Repo update failed / trunk URL couldn't be downloaded`

- CocoaPods 1.8.0 版本默认会使用CDN Repo作为源，如果因为网络原因导致无法访问，可以改回原先的Master Repo。编辑 `Podfile` ，设置 Master Repo 作为主要的源：

  ```diff
  - source 'https://cdn.cocoapods.org/'
  + source 'https://github.com/CocoaPods/Specs.git'
  ```

- 详情：http://blog.cocoapods.org/CocoaPods-1.8.0-beta/

