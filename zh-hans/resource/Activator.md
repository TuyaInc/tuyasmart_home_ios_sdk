

# 设备配网

## 功能概述



设备配网 SDK 提供了把智能设备配置上路由器的能力，具体包括：

- 快连模式

- 热点模式

- 有线设备配网  

- 子设备配网  

- 蓝牙 WiFi 双模配网

  

## 使用说明



| 类名                               | 说明                                                       | 注意                   |
| :--------------------------------- | :--------------------------------------------------------- | :--------------------- |
| TuyaSmartActivator（单例）         | 提供快连模式、热点模式、有线设备激活、子设备激活等配网能力 | 需要在主线程中调用该类 |
| TuyaSmartBLEManager （单例）       | 提供扫描蓝牙能力                                           | 需要在主线程中调用该类 |
| TuyaSmartBLEWifiActivator （单例） | 提供蓝牙-WiFi 双模配网能力                                 | 需要在主线程中调用该类 |



### 快连模式

快连模式配网流程：


```sequence

Title: 快连模式配网

participant APP
participant SDK
participant Device
participant Service

Note over APP: 连上路由器
Note over Device: Wifi灯快闪

APP->SDK: 获取token
SDK->Service: 获取token
Service-->SDK: 返回token
SDK-->APP: 返回token

APP->SDK: 开始配网 ssid/pwd/token
Note over SDK: 通过广播、组播循环发送ssid/pwd/token
Device->Device: 捕捉到ssid/password/token

Device->Service: 去激活设备
Service-->Device: 激活成功

Device-->SDK: 激活成功
SDK-->APP: 激活成功

```



#### 获取token

开始配网之前，SDK 需要在联网状态下从涂鸦云获取配网 Token，然后才可以开始快连模式配网。Token 的有效期为 10 分钟，且配置成功后就会失效（再次配网需要重新获取）



**接口说明**

配网 Token 获取接口

```
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

```
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
| password | WiFi 密码  |
| token    | 配网 Token |
| timeout  | 超时时间   |



**接口说明**

配网代理回调

```
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



注意 `ssid ` 和 `password` 需要填写的是路由器的热点名称和密码，并不是设备的热点名称和密码



#### 停止配网

开始配网操作后，App 会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用 `[TuyaSmartActivator stopConfigWiFi]` 方法

**接口说明**

```
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

Note over Device: Wifi灯慢闪
APP->SDK: 获取token
SDK->Service: 获取token
Service-->SDK: 返回token
SDK-->APP: 返回token

Note over APP: 连上设备的热点

APP->SDK: 开始配网 ssid/pwd/token
SDK->Device: 发送配置信息 ssid/pwd/token
Note over Device: 自动关闭热点

Note over Device: 连上路由器WiFi

Device->Service: 去激活设备
Service-->Device: 激活成功

Device-->SDK: 激活成功
SDK-->APP: 激活成功

```



#### 获取 Token

开始配网之前，SDK 需要在联网状态下从涂鸦云获取配网 Token，然后才可以开始热点模式配网。Token 的有效期为 10 分钟，且配置成功后就会失效（再次配网需要重新获取）



**接口说明**

配网 Token 获取接口

```
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

```
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
| password | WiFi 密码  |
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



热点模式配网与快连模式类似，把`[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]`的第一个参数改为 `TYActivatorModeAP` 即可。注意 `ssid` 和 `password` 需要填写的是路由器的热点名称和密码，并不是设备的热点名称和密码。

注意 `ssid` 和 `password` 需要填写的是路由器的热点名称和密码，并不是设备的热点名称和密码。



#### 停止配网

开始配网操作后，App 会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用 `[TuyaSmartActivator stopConfigWiFi]` 方法。

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



### 有线设备配网

有线设备已通过网线连接着网络，设备激活过程无需输入路由器的名称和密码。下图以 ZigBee 有线网关为例，描述有线网关配网流程。

```sequence

Title: Zigbee 网关配网

participant APP
participant SDK
participant Zigbee网关
participant Service

Note over Zigbee网关: 将Zigbee网关重置
APP->SDK: 获取token
SDK->Service: 获取token
Service-->SDK: 返回token
SDK-->APP: 返回token

APP->APP: APP连上和网关相同的路由器热点

APP->SDK: 发送激活命令
SDK->Zigbee网关: 发送激活命令
Note over Zigbee网关: 设备收到激活信息

Zigbee网关->Service: 去云端进行激活
Service-->Zigbee网关: 激活成功

Zigbee网关-->SDK: 激活成功
SDK-->APP: 激活成功

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
| Timeout | 超时时间   |



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

Note over Zigbee网关: 将Zigbee子设备重置
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



### 蓝牙 Wi-Fi 双模配网

如果设备模块支持蓝牙协议，可以选择蓝牙 WiFi 配网方式，通过蓝牙将 WiFi 信息发送给设备，然后设备拿到 WiFi 信息后进行配网操作，该方案成功率较高

```sequence
Title: 蓝牙 WiFi 配网

participant APP
participant SDK
participant device
participant Service

Note over device: 将设备重置
APP->SDK: 发送搜寻设备指令
SDK->device: 扫描蓝牙设备
device->SDK: 返回设备信息
SDK->APP: 返回设备信息

APP->SDK: 激活设备（ssid、password等）
SDK->device: 通过蓝牙发送激活信息
Note over device: 连接路由器成功
device->Service: 到云端激活注册
Service-->device: 设备激活成功

device->SDK: 返回激活成功信息
SDK->APP: 返回成功设备信息

Note over APP: 停止配网
			
			
			
			
			
		
```



#### 发现设备



**接口说明**

开始扫描接口

```objc
- (void)startListening:(BOOL)clearCache
```



**参数说明**

| 参数       | 说明             |
| ---------- | ---------------- |
| clearCache | 是否清空缓存设备 |



设备回调接口

```objc
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo
```



**参数说明**

| 参数       | 说明                   |
| ---------- | ---------------------- |
| deviceInfo | 扫描到的未激活设备信息 |



**代码示例**

Objc:

```objective-c
// 设置代理
[TuyaSmartBLEManager sharedInstance].delegate = self;

// 开始扫描
[[TuyaSmartBLEManager sharedInstance] startListening:YES];


/**
 扫描到未激活的设备
 
 @param deviceInfo 未激活设备信息 Model
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo {
  
}
```

Swift 示例:

```swift
TuyaSmartBLEManager.sharedInstance().delegate = self
TuyaSmartBLEManager.sharedInstance().startListening(true)

/**
 扫描到未激活的设备
 
 @param deviceInfo 未激活设备信息 Model
 */
func didDiscoveryDevice(withDeviceInfo deviceInfo: TYBLEAdvModel) {
  // 扫描到未激活的设备
}
```



#### 设备激活

扫描到未激活的设备后，可以进行设备激活并且注册到涂鸦云，并记录在家庭下



**接口说明**

```objective-c
- (void)startConfigBLEWifiDeviceWithUUID:(NSString *)UUID
                                  homeId:(long long)homeId
                               productId:(NSString *)productId
                                    ssid:(NSString *)ssid
                                password:(NSString *)password
                                timeout:(NSTimeInterval)timeout
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureHandler)failure;
```



**参数说明**

| 参数      | 说明           |
| --------- | -------------- |
| UUID      | 设备唯一标识   |
| homeId    | 当前家庭 Id    |
| productId | 产品 Id        |
| ssid      | 路由器热点名称 |
| password  | 路由器热点密码 |
| timeout   | 超时时间       |
| success   | 操作成功回调   |
| failure   | 操作失败回调   |



**示例代码**

Objc:

```objective-c
  [[TuyaSmartBLEWifiActivator sharedInstance] startConfigBLEWifiDeviceWithUUID:TYBLEAdvModel.uuid homeId:homeId productId:TYBLEAdvModel.productId ssid:ssid password:password  timeout:100 success:^{
     // 激活成功
        } failure:^{
     // 激活失败
        }];
```

Swift:

```swift
  TuyaSmartBLEWifiActivator.sharedInstance() .startConfigBLEWifiDevice(withUUID: TYBLEAdvModel.uuid, homeId: homeId, productId:TYBLEAdvModel.productId, ssid: ssid, password: password, timeout: 100, success: {
            // 激活成功
        }) {
            // 激活失败
        }
```



#### 设备激活回调



**接口说明**

```objc
- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error
```



**参数说明**

| 参数        | 说明                                               |
| ----------- | -------------------------------------------------- |
| activator   | 配网使用 TuyaSmartBLEWifiActivator 对象实例        |
| deviceModel | 配网成功时，返回此次配网的设备模型，失败时返回 nil |
| error       | 配网失败时，标示错误信息，成功时为 nil             |



**示例代码**

Objc:

```objective-c
- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
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
func bleWifiActivator(_ activator: TuyaSmartBLEWifiActivator, didReceiveBLEWifiConfigDevice deviceModel: TuyaSmartDeviceModel, error: Error) {
    if (!error && deviceModel) {
		//配网成功
    }

    if (error) {
        //配网失败
    }
}
```



#### 停止发现设备

**接口说明**

```objc
- (void)stopDiscover;
```



**示例代码**

Objc:

```objc
[[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
```

Swift :

```swift
TuyaSmartBLEWifiActivator.sharedInstance() .stopDiscover
```