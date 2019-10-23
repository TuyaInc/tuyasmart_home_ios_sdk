##### 1、 为什么执行`pod install`会报错？  

- 确认cocoapod是最新版本，执行`pod --version`命令查看pod版本，确认版本是1.3.0以上

##### 2、为什么调用SDK接口以后，会报`Error Domain=NSURLErrorDomain Code=-999 "已取消"`的错误? 

- 确认请求的对象是全局变量，否则会被提早释放，例如： `self.feedBack = [[TuyaSmartFeedback alloc] init];`

##### 3、如何开启调试模式，打印日志？

- 在初始化SDK之后，调用以下代码：`[[TuyaSmartSDK sharedInstance] setDebugMode:YES];`

##### 4、下发控制指令，设备没有上报状态。  

- 确认功能点的数据类型是否正确，比如功能点的数据类型是数值型（value），那控制命令发送的应该是 @{@"2": @(25)} 而不是 @{@"2": @"25"}。

##### 5、iOS 12 使用`[[TuyaSmartActivator sharedInstance] currentWifiSSID]`无法获取到SSID。

在Xcode10中获取WiFi信息需要开启相关权限，解决方案：

- `Xcode` -> [Project Name] -> `Targets` -> [Target Name] -> `Capabilities` -> `Access WiFi Information` -> `ON`

打开上述权限即可。

![](./images/ios-sdk-wifi-access.png)

##### 6、升级sdk至>=2.8.0 版本之后，sdk初始化之后app立即闪退。提示 ***\** Terminating app due to uncaught exception 'start sdk error', reason: 'security image not found'**

- 从SDK 2.8.0版本之后加入了安全图片校验，并启用了新的appkey/secret。请按照[准备工作](./Preparation.md)章节前往开发者平台重新生成sdk初始化所需文件。

##### 7、基于Tuya SDK 开发的app，上传了推送证书，却收不到推送信息

- 确认Xcode 的Push Notification 是否打开
- 去涂鸦开发者平台上传push 证书
- 在 `didFinishLaunchingWithOptions` 方法中初始化push方法
- 涂鸦开发者平台 - 用户运营 - 消息中心 - 新增消息
- 详见：[集成Push](./Push.md)章节

##### 8、sdk demo编译失败，提示`library not found for -XXX`

- 确认你打开的工程为`.xcworkspace`而不是`.xcproject`。详见：[CocoaPods Guides](https://guides.cocoapods.org/)


##### 9、iOS 13 SDK 权限变化
- 详见：[iOS 13 适配](./iOSAdaptation.md#ios-13-适配)章节

##### 10、为什么SDK 获取本地语言为英文，而不是手机系统的语言？

- 因为SDK 现在获取的本地语言是根据[[NSBundle mainBundle] preferredLocalizations] 获取的，所以需要在工程中创建国际化语言

##### 11、SDK 是否支持红外设备控制？

- 现在TuyaSmartHomeKit SDK 不支持红外设备控制

##### 12、为什么设备控制合并发送了多个功能点（dps），没有收到所有的功能点响应？

- 设备控制发送多个功能的时候，需要先去判断功能点是否有冲突，例如照明的设备，可以把灯的亮度，冷暖功能点放在一块发送。但是当把开关，亮度，冷暖3个功能点放在一块，就会存在有些功能点执行没有响应的问题。所以建议将没功能冲突的功能放在一块发送。

