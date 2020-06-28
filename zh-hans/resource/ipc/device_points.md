# 摄像设备功能点

涂鸦智能设备通过设备功能点来控制设备，并且通过标准化的功能点实现设备与 App 之间的交互。Camera SDK 基于 [自定义设备控制](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#%E8%87%AA%E5%AE%9A%E4%B9%89%E8%AE%BE%E5%A4%87%E6%8E%A7%E5%88%B6) 封装了一套智能摄像机的扩展功能。

**类和协议**

| 类名（协议名）            | 说明                               |
| ------------------------- | ---------------------------------- |
| TuyaSmartCameraDPManager  | 提供通过设备功能点与设备通信的能力 |
| TuyaSmartCameraDPObserver | 提供监听设备功能点状态变化的能力   |

## 设备控制

### 获取对象

**接口说明**

初始化

```objc
- (instancetype)initWithDeviceId:(NSString *)devId;
```

**参数说明**

| 参数  | 说明    |
| ----- | ------- |
| devId | 设备 id |

**接口说明**

添加和移除设备状态监听代理

```objc
/// 添加设备状态变化监听
- (void)addObserver:(id<TuyaSmartCameraDPObserver>)observer;

/// 移除设备状态变化监听
- (void)removeObserver:(id<TuyaSmartCameraDPObserver>)observer;
```

**参数说明**

| 参数     | 说明                                            |
| -------- | ----------------------------------------------- |
| observer | 监听者，需要实现`TuyaSmartCameraDPObserver`协议 |

### 状态查询

**接口说明**

判断设备是否支持某个功能点

```objc
- (BOOL)isSupportDP:(TuyaSmartCameraDPKey)dpName;
```

**参数说明**

| 参数   | 说明          |
| ------ | ------------- |
| dpName | 设备功能点 id |

**返回值**

| 类型 | 说明                 |
| ---- | -------------------- |
| BOOL | 是否支持指定的功能点 |

**接口说明**

查询设备功能点的值，直接获取缓存中的值，如果不支持此功能点，返回 nil

```objc
- (id)valueForDP:(TuyaSmartCameraDPKey)dpName;
```

**参数说明**

| 参数   | 说明            |
| ------ | --------------- |
| dpName | 设备功能点的 id |

**返回值**

| 类型 | 说明                                                         |
| ---- | ------------------------------------------------------------ |
| id   | 需要根据对应的设备点类型，转换成对应类型的值，可以参考后面的功能点列表 |

**接口说明**

异步查询设备功能点的值，除了存储卡相关功能外，不建议使用

```objc
- (void)valueForDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                             |
| ------- | -------------------------------- |
| dpName  | 设备功能点的 id                  |
| success | 成功回调，返回指定功能点的当前值 |
| failure | 失败回调，error 标示错误信息     |

### 数据下发

**接口说明**

设置设备功能点的值

```objc
- (void)setValue:(id)value forDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                    |
| ------- | ------------------------------------------------------- |
| value   | 功能点的值，数值型或者布尔型的值，需要包装成 `NSNumber` |
| dpName  | 设备功能点的 id                                         |
| success | 成功回调，并返回指定功能点当前的值                      |
| failure | 失败回调，error 标示错误信息                            |

> 除了部分存储卡状态的功能点，摄像机在功能点状态变化时，会主动上报到云端，Camera SDK 会实时更新设备功能点状态缓存，所以大部分情况下，直接获取缓存中功能点的值就可以了。

> 异步查询功能点的值，是下发`NULL`到设备端，正常情况下，设备端收到`NULL`的功能点数据后，会主动上报一次对应功能点的值。但是这个行为是由摄像机厂商实现的，有些厂商没有处理这个逻辑，所以下发`NULL`后，会导致摄像机固件程序崩溃。所以在使用此接口时，请向厂商确定他们有对这些功能点正确处理`NULL`的逻辑。

### 数据回调

`TuyaSmartCameraDPObserver`协议提供监听设备主动上报的功能点状态变化的能力。下发设置功能点的值以后，设备也会再主动上报一次更新后的值。

**接口说明**

设备功能点状态变化代理回调

```objc
- (void)cameraDPDidUpdate:(TuyaSmartCameraDPManager *)manager dps:(NSDictionary *)dpsData;
```

**参数说明**

| 参数    | 说明                                                  |
| ------- | ----------------------------------------------------- |
| manager | 触发回调的`TuyaSmartCameraDPManager`对象              |
| dpsData | 发生变化的功能点的 id 和当前的值，`{ dpName: value }` |

**示例代码**

ObjC

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dpManager = [[TuyaSmartCameraDPManager alloc] initWithDeviceId:self.devId];
  	[self.dpManager addObserver:self];
  	self.osdSwitch = [[self.dpManager valueForDP:TuyaSmartCameraBasicOSDDPName] boolValue];
}

- (void)openOSD {
  	s
    if ([self.dpManager isSupportDP:TuyaSmartCameraBasicOSDDPName]) {
        [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraBasicOSDDPName success:^(id result) {
          	self.osdSwitch = [result boolValue];
        } failure:^(NSError *error) {
						// 网络错误
        }];
    }
}

#pragma mark - TuyaSmartCameraDPObserver
- (void)cameraDPDidUpdate:(TuyaSmartCameraDPManager *)manager dps:(NSDictionary *)dpsData {
    // 如果变化的功能点中包含时间水印开关的功能点
    if ([dpsData objectForKey:TuyaSmartCameraBasicOSDDPName]) {
        self.osdSwitch = [[dpsData objectForKey:TuyaSmartCameraBasicOSDDPName] boolValue];
    }
}
```

Swift

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.dpManager = TuyaSmartCameraDPManager(deviceId: self.devId)
    self.dpManager.addObserver(self)
    if self.dpManager.isSupportDP(.basicOSDDPName) {
        self.osdSwitch = self.dpManager.value(forDP: .basicOSDDPName) as! Bool
    }
}

func openOSD() {
    // 判断设备是否支持此功能点
    guard self.dpManager.isSupportDP(.basicOSDDPName) else {
        return
    }
    self.dpManager.setValue(true, forDP: .basicOSDDPName, success: { result in
        self.osdSwitch = result as! Bool
    }) { _ in
        // 网络错误
    }
}

func cameraDPDidUpdate(_ manager: TuyaSmartCameraDPManager!, dps dpsData: [AnyHashable : Any]!) {
    // 如果变化的功能点中包含时间水印开关的功能点
    if let osdValue = dpsData[TuyaSmartCameraDPKey.basicOSDDPName] {
        self.osdSwitch = osdValue as! Bool
    }
}
```

## 功能点常量

目前已开放的摄像机标准功能点，都以字符串常量的形式定义在 `TuyaSmartCameraDPManager.h`中，类型重定义为`TuyaSmartCameraDPKey`。常量名以 "TuyaSmartCamera"+"功能"+"DPName" 的形式组成。下面介绍 Camera SDK 中定义的所有功能点。

### 基础功能

| 功能点           | 数据类型 | 取值范围                        | 描述                                 |
| ---------------- | -------- | ------------------------------- | ------------------------------------ |
| BasicIndicator   | BOOL     | YES：开；NO：关                 | 正常状态下的指示灯开关               |
| BasicFlip        | BOOL     | YES：开；NO：关                 | 视频画面翻转                         |
| BasicOSD         | BOOL     | YES：开；NO：关                 | 视频时间水印                         |
| BasicPrivate     | BOOL     | YES：开；NO：关                 | 隐私模式，打开后，摄像机不采集音视频 |
| BasicNightvision | String   | "0"：关闭；"1"：自动；"2"：打开 | 摄像机夜视功能                       |

### 移动侦测报警

| 功能点            | 数据类型 | 取值范围                                                     | 描述             |
| ----------------- | -------- | ------------------------------------------------------------ | ---------------- |
| BasicPIR          | String   | "0"：关闭；"1"：低灵敏度；<br />"2"：中灵敏度；"3"：高灵敏度； | 人体红外线感应   |
| MotionDetect      | BOOL     | YES：开；NO：关                                              | 移动侦测报警开关 |
| MotionSensitivity | String   | "0"：低；"1"："中"；"2"：高                                  | 移动侦测灵敏度   |

### 声音侦测报警

| 功能点             | 数据类型 | 取值范围         | 描述             |
| ------------------ | -------- | ---------------- | ---------------- |
| DecibelDetect      | BOOL     | YES：开；NO：关  | 声音侦测报警开关 |
| DecibelSensitivity | String   | "0"：低；"1"：高 | 声音侦测灵敏度   |

### 存储卡管理

| 功能点            | 数据类型 | 取值范围                                                     | 描述                                     |
| ----------------- | -------- | ------------------------------------------------------------ | ---------------------------------------- |
| SDCardStatus      | enum     | 1：正常；2：异常（SD卡损坏或格式不对）；<br />3：空间不足；4：正在格式化；5：无SD卡 | 存储卡状态，只能读取                     |
| SDCardStorage     | String   | -                                                            | 存储卡容量，只能读取                     |
| SDCardFormat      | BOOL     | YES：开始格式化                                              | 格式化存储卡，只能下发                   |
| SDCardFormatState | int      | -2000：SD卡正在格式化；<br />-2001：SD卡格式化异常<br />1-100：格式化进度 | 存储卡格式化状态或者进度，只能读取       |
| SDCardRecord      | BOOL     | YES：开；NO：关                                              | 设备视频录制开关，视频录像保存在存储卡中 |
| RecordMode        | String   | "1"：事件录像；"2"：连续录像                                 | 设备存储卡录像模式                       |

`SDCardStorage` 的值是一个由总容量，已使用容量，空闲容量插入 ‘|’ 符号拼接起来的字符串，单位是 `kb`。如 "16777216|1048576|15728640" 表示总容量是 16Gb，已经使用 1Gb，剩余空闲容量为 15Gb。

### 云台控制

| 功能点     | 数据类型 | 取值范围                           | 描述                                   |
| ---------- | -------- | ---------------------------------- | -------------------------------------- |
| PTZControl | String   | "0"：上；"2"：右；"4"：下；"6"：左 | 控制云台摄像机向指定方向转动，只能下发 |
| PTZStop    | BOOL     | YES：停止转动                      | 停止云台摄像机的转动                   |

### 低功耗

| 功能点              | 数据类型 | 取值范围                     | 描述                                        |
| ------------------- | -------- | ---------------------------- | ------------------------------------------- |
| WirelessAwake       | BOOL     | YES：唤醒；NO：休眠          | 设备是否休眠，下发时，只能下发 YES 唤醒设备 |
| WirelessPowerMode   | String   | "0"：电池供电；"1"：插电供电 | 设备供电模式                                |
| WirelessElectricity | int      | 1-100：电量                  | 设备当前电量百分比，只能读取                |
| WirelessLowpower    | int      | 1-100：低电量阈值            | 当设备电量低于这个数值时，触发通知报警      |
| WirelessBatteryLock | BOOL     | YES：开；NO：关              | 设备电池锁，关闭时不可以直接拆卸电池        |

### 枚举型功能点

字符串枚举类型功能点的取值范围，在 Camera SDK 中有定义相应的字符串枚举常量，存储卡状态是整型枚举，可在`TuyaSmartCameraDPManager.h`中查看具体的定义。

| 功能点             | 值常量类型                  |
| ------------------ | --------------------------- |
| BasicNightvision   | TuyaSmartCameraNightvision  |
| BasicPIR           | TuyaSmartCameraPIR          |
| MotionSensitivity  | TuyaSmartCameraMotion       |
| DecibelSensitivity | TuyaSmartCameraDecibel      |
| RecordMode         | TuyaSmartCameraRecordMode   |
| PTZControl         | TuyaSmartCameraPTZDirection |
| WirelessPowerMode  | TuyaSmartCameraPowerMode    |
| SDCardStatus       | TuyaSmartCameraSDCardStatus |

