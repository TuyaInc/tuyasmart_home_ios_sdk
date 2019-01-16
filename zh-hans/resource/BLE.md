## 单点蓝牙 BLE



### 单点蓝牙介绍

单点蓝牙设备指的是具有和手机终端**通过蓝牙一对一连接**的设备，例如蓝牙手环、蓝牙耳机、蓝牙音箱等。每个设备最多同时和一个手机进行蓝牙连接，每个手机终端目前**同时蓝牙连接数量控制在 6～7 个**内

### 功能说明

- 导入头文件

  ```objective-c
  使用
  #import <TuyaSmartBLEKit/TuyaSmartBLEKit.h>
  ```

- 主要功能

  单点蓝牙 SDK 功能主要类为 `TuyaSmartBLEManager`，此类包含单点蓝牙 SDK 的所有相关功能，包含蓝牙状态监测、设备扫描、设备激活、设备 ota 升级等功能

  `TuyaSmartBLEManager` 的 `delegate` 功能如下，可以按需设置

  ```objective-c
    /**
     蓝牙状态变化通知
    
     @param isPoweredOn 蓝牙状态，开启或关闭
     */
  - (void)bluetoothDidUpdateState:(BOOL)isPoweredOn;
  
    /**
     扫描到未激活的设备
    
     @param uuid 未激活设备 uuid
     @param productKey 未激活设备产品 key
     */
  - (void)didDiscoveryDeviceWithUUID:(NSString *)uuid productKey:(NSString *)productKey;
  ```


#### 系统蓝牙状态监测

SDK 提供了对系统蓝牙的状态监测，在蓝牙状态变化（如开启或关闭）时，可以通过设置代理收到具体的消息

**示例代码**

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



#### 设备扫描

处于待连接的蓝牙设备都会不停的向四周发蓝牙广播包，客户端作为终端可以发现这些广播包，根据广播包中包含涂鸦设备信息规则作为目标设备的过滤条件

```objective-c
/**
 开始扫描

 如果扫描到未激活设备，结果会通过 `TuyaSmartBLEManagerDelegate` 中的 `- (void)didDiscoveryDeviceWithUUID:(NSString *)uuid productKey:(NSString *)productKey` 返回;
 
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

```objective-c
// 设置代理
[TuyaSmartBLEManager sharedInstance].delegate = self;

// 开始扫描
[[TuyaSmartBLEManager sharedInstance] startListening:YES];


/**
 扫描到未激活的设备

 @param uuid 未激活设备 uuid
 @param productKey 未激活设备产品 key
 */
- (void)didDiscoveryDeviceWithUUID:(NSString *)uuid productKey:(NSString *)productKey {
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

 @param uuid 设备 uuid
 @param homeId 家庭 id
 @param productKey 产品 key
 @param success 成功回调
 @param failure 失败回调
 */
- (void)activeBLEWithUUID:(NSString *)uuid
                   homeId:(long long)homeId
               productKey:(NSString *)productKey
                  success:(void(^)(TuyaSmartDeviceModel *deviceModel))success
                  failure:(TYFailureHandler)failure;
```

>接口中的 `uuid` 和 `productKey` 来源于扫描代理方法返回的结果



**示例代码**

```objective-c

[[TuyaSmartBLEManager sharedInstance] activeBLEWithUUID:uuid homeId:#<当前家庭的 home id> productKey:productKey success:^(TuyaSmartDeviceModel *deviceModel) {
        // 激活成功
        
    } failure:^{
        // 激活中的错误
    }];
```



#### 设备 OTA 升级

对于有固件升级的设备，可以通过发送升级固件数据包对设备进行升级。其中升级固件包需要先请求云端接口进行获取固件信息

```objective-c
/**
 发送OTA包，升级固件。升级前请务必保证设备已通过蓝牙连接

 @param uuid 设备 uuid
 @param otaData 升级固件的数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPack:(NSString *)uuid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure;
```

**代码示例**

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
[[TuyaSmartBLEManager sharedInstance] sendOTAPack:deviceModel.uuid otaData:data success:^{
       NSLog(@"upgrade_success", nil);
    } failure:^{
       NSLog(@"upgrade_failre", nil);
}];

```



#### 设备 DP 下发

控制发送请参考[设备功能点发送](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#%E8%AE%BE%E5%A4%87%E5%8A%9F%E8%83%BD%E7%82%B9)