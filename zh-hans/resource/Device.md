# 设备管理

涂鸦支持多种设备类型，设备管理相关的所有功能都对应在

| 类名            | 说明             |
| --------------- | ---------------- |
| TuyaSmartDevice | 涂鸦设备相关的类 |

`TuyaSmartDevice`类需要使用设备 id 进行初始化。错误的设备 id 可能会导致初始化失败，此时的实例返回 `nil`

## 更新设备信息

### 更新单个设备信息

**接口说明**

从云端拉取、同步更新设备信息

```objective-c
- (void)syncWithCloud:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objc
- (void)updateDeviceInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	__weak typeof(self) weakSelf = self;
	[self.device syncWithCloud:^{
		NSLog(@"syncWithCloud success");
		NSLog(@"deviceModel: %@", weakSelf.device.deviceModel);
	} failure:^(NSError *error) {
		NSLog(@"syncWithCloud failure");
	}];
}
```

Swift:

```swift
func updateDeviceInfo() {
    device?.sync(cloud: {
        print("syncWithCloud success")
    }, failure: { (error) in
        if let e = error {
            print("syncWithCloud failure: \(e)")
        }
    })
}
```



## 设备控制

设备控制目前分为**标准设备控制**和**自定义设备控制**



###  标准设备控制 (Beta)

####  标准设备功能集

什么是标准设备功能集？

不同品类的产品，功能点都不一样。例如照明品类中，以灯为例，有开关、调色等功能，但对于电工品类，以插座为例，就没有 “调色” 功能

但对于某个大的品类而言，基本的通用功能都是一致的。比如，所有的照明品类，都有开关这个功能

统一同类产品的功能集定义，制定一套功能指令集规则，这就是标准功能集

> 因为需要兼容繁多的多样化产品功能，所以目前标准设备控制功能处于阶段性开放产品适配功能
> 若您要使用该功能，可以联系涂鸦或咨询相关的对接负责人



#### 设备否支持标准化

`TuyaSmartDeviceModel` 类的 `standard` 属性（ `BOOL` 类型）定义了当前设备是否支持标准化控制

`dpCodes` 属性定义了当前设备的状态，称作标准数据点(标准 dp code)

`dpCodes` 字典里的每个 `key` 对应一个功能点的 `dpCode`，`value` 对应一个功能点的 `dpValue `，`dpValue` 为该功能点的值

具体品类的设备标准 dpCode 功能集可以参照对应的[文档](./StandardDpCode.md)



#### 设备操作控制

**接口说明**

标准功能指令下发

```objective-c
- (void)publishDpWithCommands:(NSDictionary *)commands
                      success:(nullable TYSuccessHandler)success
                      failure:(nullable TYFailureError)failure
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| commands | 标准指令集 |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

Objc:

```objective-c
[self.device publishDpWithCommands:dpCodesCommand success:^{
    NSLog(@"publishDpWithCommands success");
} failure:^(NSError *error) {
    NSLog(@"publishDpWithCommands failure: %@", error);
}];
```

Swift:

```swift
self.device.publishDp(withCommands: command, success: {
      print("publishDpWithCommands success")
    }) { (error) in
        if let e = error {
          print("error: \(e)")
        }
     }
```

【指令格式】

```json
// 以灯为例
// 每种产品都有标准的一套规则
// 作用: 开关打开 
{"switch_led" : true}

// 字符串型功能点示例 作用: 设置彩光颜色
{"colour_data" : "009003e803e8"}

// 枚举型功能点示例 作用: 设置模式为 "white" 白光模式
{"work_mode" : "white"}

// 设置数值型功能点示例 作用: 设置亮度为100
{"bright_value" : 100}

// 多个功能合并发送
{"work_mode" : "colour"}
{"colour_data" : "009003e803e8"}
```

#### 设备状态更新

实现 `TuyaSmartDeviceDelegate` 代理协议后，可以在设备状态更变的回调中进行处理，刷新 App 设备控制面板的 UI

**示例代码**

Objc:

```objective-c
- (void)initDevice {
    self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpCommandsUpdate:(NSDictionary *)dpCodes {
    NSLog(@"dpCommandsUpdate: %@", dpCodes);
    // TODO: 刷新界面UI
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    //当前设备信息更新 比如 设备名、设备在线状态等
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
    //当前设备被移除
}
```

Swift:

```objective-c
func initDevice() {
    device = TuyaSmartDevice(deviceId: "your_device_id")
    device?.delegate = self
}

// MARK: - TuyaSmartDeviceDelegate

func device(_ device: TuyaSmartDevice!, dpCommandsUpdate dpCodes: [AnyHashable : Any]!) {
    print("dpCommandsUpdate: \(dpCodes)")
    // TODO: 刷新界面UI
}

func deviceInfoUpdate(_ device: TuyaSmartDevice!) {
    //当前设备信息更新 比如 设备名、设备在线状态等
}

func deviceRemoved(_ device: TuyaSmartDevice!) {
    //当前设备被移除
}
```

### 自定义设备控制

#### 设备功能点

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

功能点更多概念参见[快速入门-功能点相关概念](https://docs.tuya.com/cn/product/function.html)

#### 设备控制

设备控制支持三种通道控制，局域网控制，云端控制和自动方式（如果局域网在线，先走局域网控制，局域网不在线，走云端控制）

局域网控制：

```
	[self.device publishDps:dps mode:TYDevicePublishModeLocal success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

云端控制：

```
	[self.device publishDps:dps mode:TYDevicePublishModeInternet success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

自动控制：

```
	[self.device publishDps:dps mode:TYDevicePublishModeAuto success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```


#### 设备状态更新

实现 `TuyaSmartDeviceDelegate` 代理协议后，可以在设备状态更变的回调中进行处理，刷新 App 设备控制面板的 UI

**示例代码**

Objc:

```objc
- (void)initDevice {
	self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
	NSLog(@"deviceDpsUpdate: %@", dps);
	// TODO: 刷新界面UI
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
	//当前设备信息更新 比如 设备名、设备在线状态等
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
	//当前设备被移除
}

```

Swift:

```swift
func initDevice() {
    device = TuyaSmartDevice(deviceId: "your_device_id")
    device?.delegate = self
}

// MARK: - TuyaSmartDeviceDelegate

func device(_ device: TuyaSmartDevice!, dpsUpdate dps: [AnyHashable : Any]!) {
    print("deviceDpsUpdate: \(dps)")
    // TODO: 刷新界面UI
}

func deviceInfoUpdate(_ device: TuyaSmartDevice!) {
    //当前设备信息更新 比如 设备名、设备在线状态等
}

func deviceRemoved(_ device: TuyaSmartDevice!) {
    //当前设备被移除
}
```



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



## 获取设备的 Wi-Fi 信号强度

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

下发升级指令

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

回调接口：

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


