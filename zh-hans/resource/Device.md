# 设备管理

设备管理主要提供设备相关的操作，设备控制，设备状态状态变化监听，设备重命名，设备固件升级，设备移除，设备恢复出厂设置等操作。



| 类名                 | 说明           |
| -------------------- | -------------- |
| TuyaSmartDevice      | 设备管理类     |
| TuyaSmartDeviceModel | 设备数据模型类 |

**`TuyaSmartDeviceModel` 数据模型**

| 字段             | 类型                      | 描述                                                         |
| ---------------- | ------------------------- | ------------------------------------------------------------ |
| devId            | NSString                  | 设备唯一 id                                                  |
| name             | NSString                  | 设备名称                                                     |
| iconUrl          | NSString                  | 设备图标 URL                                                 |
| isOnline         | BOOL                      | 设备在线状态。此状态包含 Wi-Fi、局域网、蓝牙在线状态，只要其中任意一个在线，即为 YES |
| isCloudOnline    | BOOL                      | 设备 Wi-Fi 在线状态                                          |
| isLocalOnline    | BOOL                      | 设备局域网在线状态                                           |
| isShare          | BOOL                      | 是否为分享设备                                               |
| dps              | NSDictionary              | 设备功能点数据                                               |
| dpCodes          | NSDictionary              | 设备功能点数据，code-value 形式                              |
| schemaArray      | NSArray                   | 设备 dp 点规则信息                                           |
| productId        | NSString                  | 设备所对应的产品 id                                          |
| capability       | NSUInteger                | 设备产品能力值                                               |
| deviceType       | TuyaSmartDeviceModelType  | 设备类型                                                     |
| supportGroup     | BOOL                      | 是否支持创建群组                                             |
| gwType           | NSString                  | "v" 代表虚拟体验设备，为空为真实配网设备                     |
| pv               | NSString                  | 设备协议版本，Wi-Fi 协议版本或蓝牙协议版本                   |
| lpv              | NSString                  | 设备局域网协议版本。默认为空，该值在设备局域网连接成功后，才会有值 |
| latitude         | NSString                  | 维度                                                         |
| longitude        | NSString                  | 经度                                                         |
| localKey         | NSString                  | 设备通信使用的 key                                           |
| uuid             | NSString                  | 设备 uuid                                                    |
| homeId           | long long                 | 设备所在家庭 id                                              |
| roomId           | long long                 | 设备所在房间 id                                              |
| upgrading        | BOOL                      | 是否在升级中                                                 |
| timezoneId       | NSString                  | 设备时区                                                     |
| nodeId           | NSString                  | 设备短地址，非子设备类型值为空。用于区分网关下子设备的唯一地址 |
| parentId         | NSString                  | 父设备（上一级）id，非子设备类型值为空。子设备用于寻找对应的网关设备 id。蓝牙 mesh 子设备或为 mesh id 或对应的网关设备 id |
| isMeshBleOnline  | BOOL                      | 设备蓝牙 mesh 本地在线状态                                   |
| devKey           | NSString                  | 标准 SIG Mesh 设备蓝牙通信 key                               |
| standard         | BOOL                      | 是否为标准化产品设备。如果为标准设备，可以使用标准设备控制功能 |
| standSchemaModel | TuyaSmartStandSchemaModel | 设备标准 dp 点规则信息                                       |
| activeTime       | NSTimeInterval            | 激活时间                                                     |
| sharedTime       | long long                 | 分享时间                                                     |

## 设备初始化

注意：需要通过 `TuyaSmartHome` 初始化一个 home 实例，然后调用接口 `getHomeDetailWithSuccess:failure:` 获取家庭的详情，同步过家庭的详情后，初始化设备才能成功。

错误的设备 id 可能会导致初始化失败，此时设备的实例返回 `nil`

**接口说明**

根据设备 id 去初始化设备控制类。

```objective-c
/**
 *  Get TuyaSmartDevice instance. If current user don't have this device, a nil will be return.
 *  获取设备实例。如果当前用户没有该设备，将会返回nil。
 *
 *  @param devId Device ID
 *  @return instance
 */
+ (nullable instancetype)deviceWithDeviceId:(NSString *)devId;
```



**参数说明**

| 参数  | 说明    |
| ----- | ------- |
| devId | 设备 id |

**示例代码**


```objective-c
TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:devId];
device.delegate = self;
```


## 设备代理监听

实现 `TuyaSmartDeviceDelegate` 代理协议后，可以在设备状态更变的回调中进行处理，刷新 App 设备控制面板的 UI

**示例代码**

Objc:

```objective-c
- (void)initDevice {
    self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    // 设备的 dps 状态发生变化，刷新界面 UI
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    //当前设备信息更新 比如 设备名称修改、设备在线离线状态等
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
    //当前设备被移除
}

- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal {
    // Wifi信号强度
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
    // 固件升级进度
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeStatusModel:(TuyaSmartFirmwareUpgradeStatusModel *)upgradeStatusModel {
    // 设备升级状态的回调
}
```

Swift:

```swift
func initDevice() {
    device = TuyaSmartDevice(deviceId: "your_device_id")
    device?.delegate = self
}

// MARK: - TuyaSmartDeviceDelegate

func device(_ device: TuyaSmartDevice?, dpsUpdate dps: [AnyHashable : Any]?) {
    // 设备的 dps 状态发生变化，刷新界面 UI
}

func deviceInfoUpdate(_ device: TuyaSmartDevice?) {
    //当前设备信息更新 比如 设备名称修改、设备在线离线状态等
}

func deviceRemoved(_ device: TuyaSmartDevice?) {
    //当前设备被移除
}

func device(_ device: TuyaSmartDevice?, signal: String?) {
    // Wifi信号强度
}

func device(_ device: TuyaSmartDevice?, firmwareUpgradeProgress type: Int, progress: Double) {
    // 固件升级进度
}

func device(_ device: TuyaSmartDevice?, firmwareUpgradeStatusModel upgradeStatusModel: TuyaSmartFirmwareUpgradeStatusModel?) {
    // 设备升级状态的回调
}

```



## 设备控制

设备控制接口功能为向设备发送功能点，来改变设备状态或功能。

**接口说明**

设备控制支持三种通道控制，局域网控制，云端控制和自动方式（如果局域网在线，先走局域网控制，局域网不在线，走云端控制）

局域网控制：

```objective-c
	[self.device publishDps:dps mode:TYDevicePublishModeLocal success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

云端控制：

```objective-c
	[self.device publishDps:dps mode:TYDevicePublishModeInternet success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

自动控制：

```objective-c
	[self.device publishDps:dps mode:TYDevicePublishModeAuto success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```


## 设备功能点说明

`TuyaSmartDeviceModel` 类的 `dps` 属性（`NSDictionary` 类型）定义了当前设备的状态，称作数据点（DP 点）或功能点

`dps` 字典里的每个 `key` 对应一个功能点的 `dpId`，`value` 对应一个功能点的 `dpValue `，`dpValue` 为该功能点的值<br />

产品功能点定义参见[涂鸦开发者平台](https://iot.tuya.com/)的产品功能，如下图所示：

![功能点](./images/ios_dp_sample.jpeg)


发送控制指令按照以下格式：

`{"<dpId>":"<dpValue>"}`

根据后台该产品的功能点定义，如下:

**示例代码**

Objc:

```objc
- (void)publishDps {
  // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

    NSDictionary *dps;
	//设置dpId为1的布尔型功能点示例 作用:开关打开
	dps = @{@"1": @(YES)};

	//设置dpId为4的字符串型功能点示例 作用:设置RGB颜色为ff5500
	dps = @{@"4": @"ff5500"};

	//设置dpId为5的枚举型功能点示例 作用:设置档位为2档
	dps = @{@"5": @"2"};

	//设置dpId为6的数值型功能点示例 作用:设置温度为20°
	dps = @{@"6": @(20)};

	//设置dpId为15的透传型(byte数组)功能点示例 作用:透传红外数据为1122
	dps = @{@"15": @"1122"};

	//多个功能合并发送
	dps = @{@"1": @(YES), @"4": @(ff5500)};

	[self.device publishDps:dps success:^{
		NSLog(@"publishDps success");

		//下发成功，状态上报通过 deviceDpsUpdate方法 回调

	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];

}
```
Swift:

```swift
func publishDps() {
    var dps = [String : Any]()
 
    // dp 可参考具体产品定义
    device?.publishDps(dps, success: {
 	    print("publishDps success")
        
        //下发成功，状态上报通过 deviceDpsUpdate方法 回调
    }, failure: { (error) in
        if let e = error {
            print("publishDps failure: \(e)")
        }
    })
}
```

#### 注意事项

- 控制命令的发送需要特别注意数据类型<br />
  比如功能点的数据类型是数值型（value），那控制命令发送的应该是 `@{@"2": @(25)}`  而不是  `@{@"2": @"25"}`<br />
- 透传类型传输的 byte 数组是字符串格式（16 进制字符串）、字母需小写并且必须是**偶数位**<br />
  比如正确的格式是: `@{@"1": @"011f"}` 而不是 `@{@"1": @"11f"}`

功能点更多概念参见[快速入门-功能点相关概念](https://docs.tuya.com/zh/iot/configure-in-platform/function-definition/custom-functions?id=K937y38137c64)

##  设备信息查询

**接口说明**

查询单个 dp 数据。

该接口并非同步接口，查询后的数据会通过代理 `- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps` 回调。

**示例代码**

Objc:

```objc
- (void)queryDP {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	// 查询 dp = "1" 的数据
  [self.device publishDps:@{@"1":null} mode:TYDevicePublishModeAuto success:^{
		NSLog(@"query dp success");
	} failure:^(NSError *error) {
		NSLog(@"query dp failure: %@", error);
	}];
}
```

Swift:

```swift
func queryDP() {
    // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    // 查询 dp = "1" 的数据
    device.publishDps([
        "1": null
    ], mode: TYDevicePublishModeAuto, success: {
        print("query dp success")
    }, failure: { error in
        if let error = error {
            print("query dp failure: \(error)")
        }
    })
}
```

> **[warning] 注意事项**
>
> 该接口主要是针对那些数据不主动去上报的 dp 点，例如倒计时信息查询。 常规查询 dp 数据值可以通过 TuyaSmartDeviceModel.dps 里面获取。



## 修改设备名称

**接口说明**

```objective-c
- (void)updateName:(NSString *)name success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| name    | 设备名称 |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objc
- (void)modifyDeviceName:(NSString *)mame {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device updateName:name success:^{
		NSLog(@"updateName success");
	} failure:^(NSError *error) {
		NSLog(@"updateName failure: %@", error);
	}];
}
```

Swift:

```swift
func modifyDeviceName(_ name: String) {
    device?.updateName(name, success: {
        print("updateName success")
    }, failure: { (error) in
        if let e = error {
            print("updateName failure: \(e)")
        }
    })
}
```



## 移除设备

设备被移除后，会重新进入待配网状态（快连模式）

**接口说明**

```objective-c
- (void)remove:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device remove:^{
		NSLog(@"remove success");
	} failure:^(NSError *error) {
		NSLog(@"remove failure: %@", error);
	}];
}
```

Swift:

```swift
func removeDevice() {
    device?.remove({
        print("remove success")
    }, failure: { (error) in
        if let e = error {
            print("remove failure: \(e)")
        }
    })
}
```

## 恢复出厂设置

设备恢复出厂设置后，会重新进入待配网状态（快连模式），设备的相关数据会被清除掉

**接口说明**

```objective-c
- (void)resetFactory:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device resetFactory:^{
		NSLog(@"reset success");
	} failure:^(NSError *error) {
		NSLog(@"reset failure: %@", error);
	}];
}
```

Swift:

```swift
func removeDevice() {
    device?.resetFactory({
        print("reset success")
    }, failure: { (error) in
        if let e = error {
            print("reset failure: \(e)")
        }
    })
}
```




## 查询 Wi-Fi 信号强度

**接口说明**

调用获取设备 Wi-Fi 信号之后，会通过 `TuyaSmartDeviceDelegate` 的 `device:signal:` 方法进行回调

```objective-c
- (void)getWifiSignalStrengthWithSuccess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                        |
| ------- | --------------------------- |
| success | 发送获取 Wi-Fi 强度成功回调 |
| failure | 失败回调                    |

**示例代码**

Objc:

```objc
- (void)getWifiSignalStrength {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    // self.device.delegate = self;

	[self.device getWifiSignalStrengthWithSuccess:^{
		NSLog(@"get wifi signal strength success");
	} failure:^(NSError *error) {
		NSLog(@"get wifi signal strength failure: %@", error);
	}];
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal {
    NSLog(@" signal : %@", signal);
}
```

Swift:

```swift
func getWifiSignalStrength() {
    self.device?.getWifiSignalStrength(success: {
        print("get wifi signal strength success")
    }, failure: { (error) in
        if let e = error {
            print("get wifi signal strength failure: \(e)")
        }
    })
}

// MARK: - TuyaSmartDeviceDelegate
func device(_ device: TuyaSmartDevice!, signal: String!) {

}
```



## 获取网关下的子设备列表

如果是网关设备，可以获取网关下子设备的列表

**接口说明**

```objective-c
- (void)getSubDeviceListFromCloudWithSuccess:(nullable void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| success | 成功回调，网关下的子设备信息 |
| failure | 失败回调                     |

**示例代码**

Objc:

```objc
- (void)getSubDeviceList {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device getSubDeviceListFromCloudWithSuccess:^(NSArray<TuyaSmartDeviceModel *> *subDeviceList) {
        NSLog(@"get sub device list success");
    } failure:^(NSError *error) {
        NSLog(@"get sub device list failure: %@", error);
    }];
}
```

Swift:

```swift
func getSubDeviceList() {
    device?.getSubDeviceListFromCloud(success: { (subDeviceList) in
        print("get sub device list success")
    }, failure: { (error) in
        if let e = error {
            print("get sub device list failure: \(e)")
        }
    })
}
```



## 固件升级

**固件升级流程**

获取设备升级信息 -> 下发联网模块升级指令 -> 联网模块升级成功 -> 下发设备控制模块升级指令 -> 设备控制模块升级成功

使用获取设备升级信息接口获取到的 `TuyaSmartFirmwareUpgradeModel` 固件升级模型中，type 属性能获取到固件的类型，typeDesc 属性能获取到固件类型的描述

### 获取设备升级信息

**接口说明**

```objective-c
- (void)getFirmwareUpgradeInfo:(nullable void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                             |
| ------- | -------------------------------- |
| success | 成功回调，设备的固件升级信息列表 |
| failure | 失败回调                         |

**`TuyaSmartFirmwareUpgradeModel` 数据模型**

| 字段          | 类型      | 说明                                            |
| ------------- | --------- | ----------------------------------------------- |
| desc          | NSString  | 升级文案                                        |
| typeDesc      | NSString  | 设备类型文案                                    |
| upgradeStatus | NSInteger | 0:无新版本 1:有新版本 2:在升级中 5:等待设备唤醒 |
| version       | NSString  | 新版本使用的固件版本                            |
| upgradeType   | NSInteger | 0:app 提醒升级 2:app强制升级 3:检测升级         |
| url           | NSString  | 蓝牙设备的升级固件包下载 URL                    |
| fileSize      | NSString  | 固件包的 size, byte                             |
| md5           | NSString  | 固件的md5                                       |
| upgradingDesc | NSString  | 固件升级中的提示文案                            |

**示例代码**

Objc:

```objc
- (void)getFirmwareUpgradeInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device getFirmwareUpgradeInfo:^(NSArray<TuyaSmartFirmwareUpgradeModel *> *upgradeModelList) {
		NSLog(@"getFirmwareUpgradeInfo success");
	} failure:^(NSError *error) {
		NSLog(@"getFirmwareUpgradeInfo failure: %@", error);
	}];
}
```

Swift:

```swift
func getFirmwareUpgradeInfo() {
    device?.getFirmwareUpgradeInfo({ (upgradeModelList) in
        print("getFirmwareUpgradeInfo success")
    }, failure: { (error) in
        if let e = error {
            print("getFirmwareUpgradeInfo failure: \(e)")
        }
    })
}
```

### 开始升级

**接口说明**

```objective-c
- (void)upgradeFirmware:(NSInteger)type success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                         |
| ------- | ------------------------------------------------------------ |
| type    | type: 需要升级的类型，从设备升级信息接口 `getFirmwareUpgradeInfo` 获取 |
| success | 成功回调                                                     |
| failure | 失败回调                                                     |

**示例代码**

Objc:

```objc
- (void)upgradeFirmware {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	// type: 从获取设备升级信息接口 getFirmwareUpgradeInfo 返回的固件类型
	// TuyaSmartFirmwareUpgradeModel - type

	[self.device upgradeFirmware:type success:^{
		NSLog(@"upgradeFirmware success");
	} failure:^(NSError *error) {
		NSLog(@"upgradeFirmware failure: %@", error);
	}];
}
```

Swift:

```swift
func upgradeFirmware() {
    // type: 从获取设备升级信息接口 getFirmwareUpgradeInfo 返回的固件类型
    // TuyaSmartFirmwareUpgradeModel - type
    device?.upgradeFirmware(type, success: {
        print("upgradeFirmware success")
    }, failure: { (error) in
        if let e = error {
            print("upgradeFirmware failure: \(e)")
        }
    })
}
```

### 回调监听

**示例代码**

Objc:

```objc
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级成功
}

- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级失败
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
	//固件升级的进度
}

```

Swift:

```swift
func deviceFirmwareUpgradeSuccess(_ device: TuyaSmartDevice!, type: Int) {
    //固件升级成功
}

func deviceFirmwareUpgradeFailure(_ device: TuyaSmartDevice!, type: Int) {
    //固件升级失败
}

func device(_ device: TuyaSmartDevice!, firmwareUpgradeProgress type: Int, progress: Double) {
    //固件升级的进度
}
```


