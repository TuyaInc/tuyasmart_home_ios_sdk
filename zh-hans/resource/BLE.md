## 单点蓝牙 BLE



### 单点蓝牙介绍

单点蓝牙设备指的是具有和手机终端**通过蓝牙一对一连接**的设备，例如蓝牙手环、蓝牙耳机、蓝牙音箱等。每个设备最多同时和一个手机进行蓝牙连接，每个手机终端目前**同时蓝牙连接数量控制在 6～7 个**内



### 准备工作

涂鸦 iOS 单点 BLE SDK (下文简称 BLE SDK 或单点蓝牙 SDK)，是基于[涂鸦智能全屋 SDK](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/) 的基础上进行开发



### 功能说明

- 导入头文件

  ```objective-c
  // OC 使用
  #import <TuyaSmartBLEKit/TuyaSmartBLEKit.h>
      
  // Swift
  import TuyaSmartBLEKit
  ```

- 主要功能

  单点蓝牙 SDK 功能主要类为 `TuyaSmartBLEManager`，此类包含单点蓝牙 SDK 的所有相关功能，包含蓝牙状态监测、设备扫描、设备名称查询、设备激活、设备 ota 升级等功能

  其中，支持双模配网功能的类为`TuyaSmartBLEWifiActivator`，此类包含设备双模配网所需方法

  
  
  TuyaSmartBLEManager` 的 `delegate` 功能如下，可以按需设置
  
  ```objective-c
  /**
   蓝牙状态变化通知
    
   @param isPoweredOn 蓝牙状态，开启或关闭
  */
  - (void)bluetoothDidUpdateState:(BOOL)isPoweredOn;
  
  /**
   扫描到未激活的设备
   
   @param deviceInfo 未激活设备信息 Model
   */
  - (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo;
  
  ```


#### 系统蓝牙状态监测

SDK 提供了对系统蓝牙的状态监测，在蓝牙状态变化（如开启或关闭）时，可以通过设置代理收到具体的消息

**示例代码**

Objc:

```objective-c
// 设置代理
[TuyaSmartBLEManager sharedInstance].delegate = self;


/**
 蓝牙状态变化通知

 @param isPoweredOn 蓝牙状态，开启或关闭
 */
- (void)bluetoothDidUpdateState:(BOOL)isPoweredOn {
    NSLog(@"蓝牙状态变化: %d", isPoweredOn ? 1 : 0);
}
```

Swift:

```swift
// 设置代理
TuyaSmartBLEManager.sharedInstance().delegate = self

/**
 蓝牙状态变化通知

 @param isPoweredOn 蓝牙状态，开启或关闭
 */
func bluetoothDidUpdateState(_ isPoweredOn: Bool) {
        
}

```



#### 设备扫描

处于待连接的蓝牙设备都会不停的向四周发蓝牙广播包，客户端作为终端可以发现这些广播包，根据广播包中包含涂鸦设备信息规则作为目标设备的过滤条件

```objective-c
/**
 开始扫描

 如果扫描到未激活设备，结果会通过 `TuyaSmartBLEManagerDelegate` 中的 `- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo` 返回;
 
 如果扫描到激活设备，会自动进行连接入网，不会返回扫描结果
 
 @param clearCache 是否清理已扫描到的设备
 */
- (void)startListening:(BOOL)clearCache;

/**
 停止扫描

 @param clearCache 是否清理已扫描到的设备
 */
- (void)stopListening:(BOOL)clearCache;
```



**示例代码**

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
    // 成功扫描到未激活的设备
    // 若设备已激活，则不会走此回调，且会自动进行激活连接
}
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().delegate = self
TuyaSmartBLEManager.sharedInstance().startListening(true)

/**
 扫描到未激活的设备

 @param uuid 未激活设备 uuid
 @param productKey 未激活设备产品 key
 */
func didDiscoveryDevice(withDeviceInfo deviceInfo: TYBLEAdvModel) {
    // 成功扫描到未激活的设备
    // 若设备已激活，则不会走此回调，且会自动进行激活连接
}
```



#### 设备激活

扫描到未激活的设备后，可以进行设备激活并且注册到涂鸦云，并记录在家庭下

```objective-c
/**
 激活设备，设备 uuid 来源于搜索发现的设备
 激活过程会将设备信息注册到云端
 
 @param deviceInfo 设备信息 Model
 @param homeId 家庭 id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)activeBLE:(TYBLEAdvModel *)deviceInfo
           homeId:(long long)homeId
          success:(void(^)(TuyaSmartDeviceModel *deviceModel))success
          failure:(TYFailureHandler)failure;
```

>接口中的 `deviceInfo` 来源于扫描代理方法返回的结果



**示例代码**

Objc:

```objective-c
[[TuyaSmartBLEManager sharedInstance] activeBLE:deviceInfo homeId:#<当前家庭的 home id> success:^(TuyaSmartDeviceModel *deviceModel) {
        // 激活成功
        
    } failure:^{
        // 激活中的错误
    }];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().activeBLE(<deviceInfo: deviceInfo, homeId: #<当前家庭的 home id>, success: { (deviceModel) in
        // 激活成功  
        }) {
        // 激活中的错误
        }
```



#### 设备 OTA 升级

对于有固件升级的设备，可以通过发送升级固件数据包对设备进行升级。其中升级固件包需要先请求云端接口进行获取固件信息

```objective-c
/**
 发送OTA包，升级固件。升级前请务必保证设备已通过蓝牙连接
 
 @param uuid    设备 uuid
 @param pid     设备 pid
 @param otaData 升级固件的数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure;
```

**代码示例**

Objc:

```objective-c
- (void)getFirmwareUpgradeInfo {
    // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

    [self.device getFirmwareUpgradeInfo:^(NSArray<TuyaSmartFirmwareUpgradeModel *> *upgradeModelList) {
        NSLog(@"getFirmwareUpgradeInfo success");
    } failure:^(NSError *error) {
        NSLog(@"getFirmwareUpgradeInfo failure: %@", error);
    }];
}

// 如果有升级，其中 TuyaSmartFirmwareUpgradeModel.url 是固件升级包的下载地址
// 根据 url 下载固件后，将数据转成 data，传给 sdk 进行固件升级
// deviceModel -- 需要升级的设备 model
// data -- 下载的固件包
[[TuyaSmartBLEManager sharedInstance] sendOTAPack:deviceModel.uuid pid:deviceModel.pid otaData:data success:^{
       NSLog(@"OTA 成功");
    } failure:^{
       NSLog(@"OTA 失败");
}];

```

Swift:

```swift
func getFirmwareUpgradeInfo() {
    device?.getFirmwareUpgradeInfo({ (upgradeModelList) in
        print("getFirmwareUpgradeInfo success");
    }, failure: { (error) in
        if let e = error {
            print("getFirmwareUpgradeInfo failure: \(e)");
        }
    })
}

// 如果有升级，其中 TuyaSmartFirmwareUpgradeModel.url 是固件升级包的下载地址
// 根据 url 下载固件后，将数据转成 data，传给 sdk 进行固件升级
// deviceModel -- 需要升级的设备 model
// data -- 下载的固件包
TuyaSmartBLEManager.sharedInstance().sendOTAPack(deviceModel.uuid, pid: deviceModel.pid, otaData: data, success: {
    print("OTA 成功");
}) {
    print("OTA 失败");
}
```



#### 查询设备名称

当扫描到设备广播包并拿到设备广播包对象后，可以通过该方法查询设备名称

```objective-c
/**
 查询设备名称
 
 @param uuid 设备 uuid
 @param productKey 产品 key
 @param success 成功回调
 @param failure 失败回调
 */
- (void)queryNameWithUUID:(NSString *)uuid
               productKey:(NSString *)productKey
                  success:(void(^)(NSString *name))success
                  failure:(TYFailureError)failure;
```



**示例代码**

Objc:

```objective-c
[[TuyaSmartBLEManager sharedInstance] queryNameWithUUID:bleAdvInfo.uuid productKey:bleAdvInfo.productId success:^(NSString *name) {
        // 查询设备名称成功
        
    } failure:^{
        // 查询设备名称失败
    }];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().queryName(withUUID: bleAdvInfo.uuid, productKey: bleAdvInfo.productId, success: { (name) in
        // 查询设备名称成功                                                                                              
}, failure: { (error) in
        // 查询设备名称失败
})
```




#### 设备 DP 下发

控制发送请参考[设备功能点发送](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#%E8%AE%BE%E5%A4%87%E5%8A%9F%E8%83%BD%E7%82%B9)



### 蓝牙 WiFi 配网



#### 发现设备

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

Swift:

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

使用方法：

```objective-c
/**
 *  connect ble wifi device
 *  连接蓝牙 Wifi 设备
 *
 *  @param UUID        蓝牙设备唯一标识
 *  @param homeId      当前家庭Id
 *  @param productId   产品Id
 *  @param ssid        路由器热点名称
 *  @param password    路由器热点密码
 *  @param timeout     轮询时间
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)startConfigBLEWifiDeviceWithUUID:(NSString *)UUID
                                  homeId:(long long)homeId
                               productId:(NSString *)productId
                                    ssid:(NSString *)ssid
                                password:(NSString *)password
                                timeout:(NSTimeInterval)timeout
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureHandler)failure;
```

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

Objc 示例:

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

Swift 示例:

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

Objc:

```objective-c
[[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
```

Swift:

```swift
TuyaSmartBLEWifiActivator.sharedInstance() .stopDiscover
```