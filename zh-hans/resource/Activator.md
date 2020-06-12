

# 设备配网

##  功能概述

设备配网 SDK 提供了把智能设备配置上路由器的能力，具体包括：

- 快连模式

- 热点模式

- 摄像头二维码配网

- 有线设备配网 

- 子设备配网 

- 蓝牙设备配网






| 名词       | 解释                                                     |
| --------   | ------------------------------------------------------- |
| Wi-Fi 设备   | 采用 Wi-Fi 模块连接路由器，和 APP 以及云端进行数据交互的智能设备。 |
| EZ 模式      | 又称快连模式，APP 把配网数据包打包到802.11数据包的指定区域中，发送到周围环境；智能设备的 Wi-Fi 模块处于混杂模式下，监听捕获网络中的所有报文，按照约定的协议数据格式解析出 APP 发出配网信息包。 |
| AP 模式      | 又称热点模式，手机作为 STA 连接智能设备的热点，双方建立一个 Socket 连接通过约定端口交互数据。 |
| 摄像头扫码配网 | 摄像头设备通过扫描 APP 上的二维码获取配网数据信息 |
| 有线设备 |通过有线网络连接路由器的设备，例如 ZigBee 有线网关、有线摄像头等|
| 子设备 |通过网关来跟 APP 以及云端数据交互的设备，例如 ZigBee 子设备|
| ZigBee | ZigBee 技术是一种近距离、低复杂度、低功耗、低速率、低成本的双向无线通讯技术。主要用于距离短、功耗低且传输速率不高的各种电子设备之间进行数据传输以及典型的有周期性数据、间歇性数据和低反应时间数据传输的应用。|
| ZigBee 网关 | 融合 ZigBee 网络中协调器和 Wi-Fi 功能的设备，负责 ZigBee 网络的组建及数据信息存储。 |
| ZigBee 子设备 | ZigBee 网络中的路由或者终端设备，负责数据转发或者终端控制响应。|





## 使用须知

进行设备配网之前，需要先了解 iOS Home SDK 基本逻辑，并使用 iOS Home SDK 完成登录创建家庭等基本操作

| 类名                       | 说明                                                       | 注意                   |
| :------------------------- | :--------------------------------------------------------- | :--------------------- |
| TuyaSmartActivator（单例） | 提供快连模式、热点模式、有线设备激活、子设备激活等配网能力 | 需要在主线程中调用该类 |



## 配网实现

### 快连模式

快连模式配网流程：


```sequence

Title: 快连模式配网

participant APP
participant SDK
participant Device
participant Service

Note over APP: 连上路由器
Note over Device: Wifi 灯快闪

APP->SDK: 获取 token
SDK->Service: 获取 token
Service-->SDK: 返回 token
SDK-->APP: 返回 token

APP->SDK: 开始配网 ssid/pwd/token
Note over SDK: 通过广播、组播循环发送 ssid/pwd/token
Device->Device: 捕捉到 ssid/password/token

Device->Service: 去激活设备
Service-->Device: 激活成功

Device-->SDK: 激活成功
SDK-->APP: 激活成功

```



#### 获取 Token

开始配网之前，SDK 需要在联网状态下从涂鸦云获取配网 Token，然后才可以开始快连模式配网。Token 的有效期为 10 分钟，且配置成功后就会失效（再次配网需要重新获取）



**接口说明**

配网 Token 获取接口

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                      |
| :------ | :------------------------ |
| homeId  | 设备将要绑定到的家庭的 Id |
| success | 成功回调，返回配网 Token  |
| failure | 失败回调，返回失败原因    |



**示例代码**

Objc:

```objective-c
- (void)getToken {
	[[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
		NSLog(@"getToken success: %@", token);
		// TODO: startConfigWiFi
	} failure:^(NSError *error) {
		NSLog(@"getToken failure: %@", error.localizedDescription);
	}];
}
```

Swift:

```swift
func getToken() {
    TuyaSmartActivator.sharedInstance()?.getTokenWithHomeId(homeId, success: { (token) in
        print("getToken success: \(token)")
        // TODO: startConfigWiFi
    }, failure: { (error) in
        if let e = error {
            print("getToken failure: \(e)")
        }
    })
}
```



#### 开始配网

**接口说明**

开始配网接口

```objc
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;
```



**参数说明**

| 参数     | 说明                  |
| :------- | :-------------------- |
| mode     | 配网模式              |
| ssid     | Wi-Fi 名称            |
| password | Wi-Fi 密码            |
| token    | 配网 Token            |
| timeout  | 超时时间，默认 100 秒 |



**接口说明**

配网代理回调

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;
```



**参数说明**

| 参数        | 说明                                               |
| :---------- | :------------------------------------------------- |
| activator   | 配网使用 TuyaSmartActivator 对象实例               |
| deviceModel | 配网成功时，返回此次配网的设备模型，失败时返回 nil |
| error       | 配网失败时，标示错误信息，成功时为 nil             |



**示例代码**

Objc :

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;

	// 开始配网，快连模式对应 mode 为 TYActivatorModeEZ
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeEZ ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//配网成功
    }

    if (error) {
        //配网失败
    }
}

```

Swift :

```swift
func startConfigWiFi(withSsid ssid: String, password: String, token: String) {
    // 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // 开始配网
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeEZ, ssid: ssid, password: password, token: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //配网成功
    }
        
    if let e = error {
        //配网失败
        print("\(e)")
    }
}
```


#### 停止配网

开始配网操作后，App 会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用 `[TuyaSmartActivator stopConfigWiFi]` 方法

**接口说明**

```objc
- (void)stopConfigWiFi;
```



**示例代码**

Objc:

```objc
- (void)stopConfigWifi {
	[TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}
```

Swift:

```swift
func stopConfigWifi() {
    TuyaSmartActivator.sharedInstance()?.delegate = nil
    TuyaSmartActivator.sharedInstance()?.stopConfigWiFi()
}
```



### 热点模式

热点模式配网流程：

```sequence

Title: 热点配网

participant APP
participant SDK
participant Device
participant Service

Note over Device: Wifi 灯慢闪
APP->SDK: 获取 token
SDK->Service: 获取 token
Service-->SDK: 返回 token
SDK-->APP: 返回 token

Note over APP: 连上设备的热点

APP->SDK: 开始配网 ssid/pwd/token
SDK->Device: 发送配置信息 ssid/pwd/token
Note over Device: 自动关闭热点

Note over Device: 连上路由器 WiFi

Device->Service: 去激活设备
Service-->Device: 激活成功

Device-->SDK: 激活成功
SDK-->APP: 激活成功

```



#### 获取 Token

开始配网之前，SDK 需要在联网状态下从涂鸦云获取配网 Token，然后才可以开始热点模式配网。Token 的有效期为 10 分钟，且配置成功后就会失效（再次配网需要重新获取）



**接口说明**

配网 Token 获取接口

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                      |
| :------ | :------------------------ |
| homeId  | 设备将要绑定到的家庭的 Id |
| success | 成功回调，返回配网 Token  |
| failure | 失败回调，返回失败原因    |



**示例代码**

Objc:

```objective-c
- (void)getToken {
	[[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
		NSLog(@"getToken success: %@", token);
		// TODO: startConfigWiFi
	} failure:^(NSError *error) {
		NSLog(@"getToken failure: %@", error.localizedDescription);
	}];
}
```

Swift:

```swift
func getToken() {
    TuyaSmartActivator.sharedInstance()?.getTokenWithHomeId(homeId, success: { (token) in
        print("getToken success: \(token)")
        // TODO: startConfigWiFi
    }, failure: { (error) in
        if let e = error {
            print("getToken failure: \(e)")
        }
    })
}
```



#### 开始配网



**接口说明**

开始配网接口

```objc
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;
```



**参数说明**

| 参数     | 说明       |
| :------- | :--------- |
| mode     | 配网模式   |
| ssid     | WiFi 名称  |
| password | Wi-Fi 密码 |
| token    | 配网 Token |
| timeout  | 超时时间   |



**接口说明**

配网代理回调

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;
```



**参数说明**

| 参数        | 说明                                               |
| :---------- | :------------------------------------------------- |
| activator   | 配网使用 TuyaSmartActivator 对象实例               |
| deviceModel | 配网成功时，返回此次配网的设备模型，失败时返回 nil |
| error       | 配网失败时，标示错误信息，成功时为 nil             |



**示例代码**

Objc:

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;

	// 开始配网，热点模式对应 mode 为 TYActivatorModeAP
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeAP ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//配网成功
    }

    if (error) {
        //配网失败
    }
}

```

Swift:

```swift
func startConfigWiFi(withSsid ssid: String, password: String, token: String) {
    // 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // 开始配网
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeAP, ssid: ssid, password: password, token: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //配网成功
    }
        
    if let e = error {
        //配网失败
        print("\(e)")
    }
}
```



热点模式配网与快连模式类似，把`[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]`的第一个参数改为 `TYActivatorModeAP` 即可

注意 `ssid` 和 `password` 需要填写的是路由器的热点名称和密码，并不是设备的热点名称和密码

#### 停止配网

开始配网操作后，App 会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用 `[TuyaSmartActivator stopConfigWiFi]` 方法

**接口说明**

```objc
- (void)stopConfigWiFi;
```

**示例代码**

Objc:

```objc
- (void)stopConfigWifi {
	[TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}
```

Swift:

```swift
func stopConfigWifi() {
    TuyaSmartActivator.sharedInstance()?.delegate = nil
    TuyaSmartActivator.sharedInstance()?.stopConfigWiFi()
}
```



### 摄像头二维码配网

智能摄像机特有的二维码配网模式可以参考文档[二维码配网](https://tuyainc.github.io/tuyasmart_camera_ios_sdk_doc/zh-hans/resource/activitor.html#二维码配网).



### 有线设备配网

有线设备已通过网线连接着网络，设备激活过程无需输入路由器的名称和密码。下图以 ZigBee 有线网关为例，描述有线网关配网流程

```sequence

Title: Zigbee 网关配网

participant APP
participant SDK
participant Zigbee网关
participant Service

Note over Zigbee网关: 将 Zigbee 网关重置
APP->SDK: 获取 token
SDK->Service: 获取 token
Service-->SDK: 返回 token
SDK-->APP: 返回 token

APP->APP: APP 连上和网关相同的路由器热点

APP->SDK: 发送激活命令
SDK->Zigbee网关: 发送激活命令
Note over Zigbee网关: 设备收到激活信息

Zigbee网关->Service: 去云端进行激活
Service-->Zigbee网关: 激活成功

Zigbee网关-->SDK: 激活成功
SDK-->APP: 激活成功

```

#### 发现设备

SDK 提供发现待配网有线设备的功能，获取设备前手机需与设备接入同一网络，然后注册获取有线设备的通知，待 SDK 收到有线设备的广播即会通过通知转发设备信息。

**通知**

```objc
// 收到有线配网设备的广播后，会发送此通知。objec为dictionary，@{@"productId":productId, @"gwId":gwId}
extern NSString *const TuyaSmartActivatorNotificationFindGatewayDevice;

```

#### 获取 Token

开始配网之前，SDK 需要在联网状态下从涂鸦云获取配网 Token，然后才可以开始有线设备激活配网。Token 的有效期为 10 分钟，且配置成功后就会失效（再次配网需要重新获取）



**接口说明**

配网 Token 获取接口

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                      |
| :------ | :------------------------ |
| homeId  | 设备将要绑定到的家庭的 Id |
| success | 成功回调，返回配网 Token  |
| failure | 失败回调，返回失败原因    |



**示例代码**

Objc:

```
- (void)getToken {
	[[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
		NSLog(@"getToken success: %@", token);
		// TODO: startConfigWiFi
	} failure:^(NSError *error) {
		NSLog(@"getToken failure: %@", error.localizedDescription);
	}];
}
```

Swift:

```swift
func getToken() {
    TuyaSmartActivator.sharedInstance()?.getTokenWithHomeId(homeId, success: { (token) in
        print("getToken success: \(token)")
        // TODO: startConfigWiFi
    }, failure: { (error) in
        if let e = error {
            print("getToken failure: \(e)")
        }
    })
}
```



#### 开始配网



**接口说明**

```objc
- (void)startConfigWiFiWithToken:(NSString *)token timeout:(NSTimeInterval)timeout
```



**参数说明**

| 参数    | 说明       |
| ------- | ---------- |
| token   | 配网 Token |
| timeout | 超时时间   |



**示例代码**

Objc:

```objc
- (void)startConfigWiFiToken:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;

	// 开始配网
	[[TuyaSmartActivator sharedInstance] startConfigWiFiWithToken:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//配网成功
    }

    if (error) {
        //配网失败
    }

}

```

Swift:

```swift
func startConfigWifiToken(_ token: String) {
    // 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // 开始配网
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(withToken: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //配网成功
    }
        
    if let e = error {
        //配网失败
        print("\(e)")
    }
}
```



#### 停止配网

开始配网操作后，App 会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用 `[TuyaSmartActivator stopConfigWiFi]` 方法



**接口说明**

```objc
- (void)stopConfigWiFi;
```

**示例代码**

Objc:

```objc
- (void)stopConfigWifi {
	[TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}
```

Swift:

```swift
func stopConfigWifi() {
    TuyaSmartActivator.sharedInstance()?.delegate = nil
    TuyaSmartActivator.sharedInstance()?.stopConfigWiFi()
}
```



### 子设备配网

```sequence

Title: Zigbee 子设备激活

participant APP
participant SDK
participant Zigbee网关
participant Service

Note over Zigbee网关: 将 Zigbee 子设备重置
APP->SDK: 发送子设备激活指令
SDK->Zigbee网关: 发送子设备激活指令

Note over Zigbee网关: 收到子设备激活信息

Zigbee网关->Service: 通知云端子设备激活
Service-->Zigbee网关: 子设备激活成功

Zigbee网关-->SDK: 子设备激活成功
SDK-->APP: 子设备激活成功

```



#### 开始子设备配网



**接口说明**

```objc
- (void)activeSubDeviceWithGwId:(NSString *)gwId timeout:(NSTimeInterval)timeout
```



**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| gwId    | 网关 Id  |
| timeout | 超时时间 |



**示例代码**

Objc:

```objc
- (void)activeSubDevice {
    // 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;
    
	[[TuyaSmartActivator sharedInstance] activeSubDeviceWithGwId:@"your_device_id" timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

    if (!error && deviceModel) {
		//配网成功
    }

    if (error) {
        //配网失败
    }
}
```

Swift:

```swift
func activeSubDevice() {
    // 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
    TuyaSmartActivator.sharedInstance()?.delegate = self
    TuyaSmartActivator.sharedInstance()?.activeSubDevice(withGwId: "your_device_id", timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //配网成功
    }
        
    if let e = error {
        //配网失败
        print("\(e)")
    }
}
```



#### 停止激活子设备

**接口说明**

```objc
- (void)stopActiveSubDeviceWithGwId:(NSString *)gwId
```



**参数说明**

| 参数 | 说明    |
| ---- | ------- |
| gwId | 网关 Id |



**示例代码**

Objc:

```objc
- (void)stopActiveSubDevice {
  [TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopActiveSubDeviceWithGwId:@"your_device_id"];
}
```

Swift:

```swift
func stopActiveSubDevice() {
    TuyaSmartActivator.sharedInstance()?.delegate = nil
    TuyaSmartActivator.sharedInstance()?.stopActiveSubDevice(withGwId: "your_device_id")
}
```

### 蓝牙设备配网

蓝牙设备配网可以参考文档[涂鸦蓝牙体系](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/BLEs.html#涂鸦蓝牙体系).



