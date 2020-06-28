# Extension Features

Camera SDK provide some extension functions base on data point (DP). If you do not know about data point, please refer to [Custom Device Control](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#custom-device-control).

**Class and Protocol**

| Class (Protocol)          | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| TuyaSmartCameraDPManager  | Provides the ability to communicate with device through data points |
| TuyaSmartCameraDPObserver | Provides the ability to monitor device data point value changes |

## Device Control

### Create instance

**Declaration**

Initialize data point manager.

```objc
- (instancetype)initWithDeviceId:(NSString *)devId;
```

**Parameters**

| Parameter | Description |
| --------- | ----------- |
| devId     | Device id   |

**Declaration**

Add and remove device status listening observer.

```objc
/// add observer
- (void)addObserver:(id<TuyaSmartCameraDPObserver>)observer;

/// remove observer
- (void)removeObserver:(id<TuyaSmartCameraDPObserver>)observer;
```

**Parameters**

| Parameter | Description                                         |
| --------- | --------------------------------------------------- |
| observer  | need implement `TuyaSmartCameraDPObserver` protocol |

### Query value

**Declaration**

Determines whether the device supports a data point.

```objc
- (BOOL)isSupportDP:(TuyaSmartCameraDPKey)dpName;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| dpName    | data point id |

**Return**

| Type | Description                                   |
| ---- | --------------------------------------------- |
| BOOL | whether the specified data point is supported |

**Declaration**

Query the value of the data point, get the value in the cache directly, and return nil if the data point is not supported.

```objc
- (id)valueForDP:(TuyaSmartCameraDPKey)dpName;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| dpName    | data point id |

**Return**

| Type | Description      |
| ---- | ---------------- |
| id   | data point value |

**Declaration**

Asynchronous query data point value, in addition to memory card related functions, is not recommended.

```objc
- (void)valueForDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| dpName    | data point id                                                |
| success   | success callback, return the value of  the specified data point |
| failure   | failure callback, error indicates an error message           |

### Publish data

**Declaration**

Asynchronous set value for the specified data point.

```objc
- (void)setValue:(id)value forDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| value     | the value of the data point, numeric or BOOL, needs to be wrapped as `NSNumber` |
| dpName    | data point id                                                |
| success   | success callback, return the value of  the specified data point |
| failure   | failure callback, error indicates an error message           |

> Except for some data points in the memory card state, the camera will voluntarily report to the cloud when the data point state changes, and the SDK will update the device's data point status cache in real time. Therefore, in most cases, it is ok to directly obtain the value of the data point in the cache.

> Asynchronous query data point value, is publish `NULL` to the device, under normal circumstances, the device received `NULL` for the data point, will respond the value of the specified data point. However, this behavior is implemented by camera manufacturers, some manufacturers do not handle this logic, so after publish `NULL`, the camera firmware will crash. So when using this interface, make sure that the vendor has the logic to handle `NULL` correctly for these data points.

### Callback

The `TuyaSmartCameraDPObserver` protocol provides the ability to monitor changes in the status of data points reported by the device.

**Declaration**

Device data point status change callback.

```objc
- (void)cameraDPDidUpdate: (TuyaSmartCameraDPManager *) manager dps: (NSDictionary *) dpsData;
```

**Parameters**

| Parameter | Description |
| --------- | --------------------------------------- -------------- |
|manager | `TuyaSmartCameraDPManager` object |
| dpsData | `dpId` and current value of the changed data point, `{dpName: value}` |


## Data point id

Has open standard of camera data point, in the form of a string constants defined in `TuyaSmartCameraDPManager.h `, redefine as `TuyaSmartCameraDPKey`. The constant name is formed in the form of "TuyaSmartCamera"+"function"+"DPName".

### Basic features

| Data point       | Value type | Value range                  | Description                                                  |
| ---------------- | ---------- | ---------------------------- | ------------------------------------------------------------ |
| BasicIndicator   | BOOL       | `YES`: on; `NO`: off         | indicator light switch                                       |
| BasicFlip        | BOOL       | `YES`: on; `NO`: off         | video flip                                                   |
| BasicOSD         | BOOL       | `YES`: on; `NO`: off         | video time watermark                                         |
| BasicPrivate     | BOOL       | `YES`: on; `NO`: off         | Privacy mode, after turning on, the camera does not collect audio and video |
| BasicNightvision | String     | "0": off; "1": auto; "2": on | night vision                                                 |

### Motion detection alarm

| Data point        | Value type | Value range                                                  | Description                   |
| ----------------- | ---------- | ------------------------------------------------------------ | ----------------------------- |
| BasicPIR          | String     | "0": off; "1": low sensitivity; "2": medium sensitivity; "3": high sensitivity | passive infrared detection    |
| MotionDetect      | BOOL       | `YES`: on; `NO`: off                                         | motion detection alarm switch |
| MotionSensitivity | String     | "0": low; "1": medium; "2": high                             | motion detection sensitivity  |

### Sound detection alarm

| Data point         | Value type | Value range          | Description                  |
| ------------------ | ---------- | -------------------- | ---------------------------- |
| DecibelDetect      | BOOL       | `YES`: on; `NO`: off | sound detection alarm switch |
| DecibelSensitivity | String     | "0": low; "1": high  | sound detection sensitivity  |

### Memory card management

| Data point        | Value type | Value range                                                  | Description                                                  |
| ----------------- | ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| SDCardStatus      | enum       | 1: normal; 2: exception (SD card is damaged or format is incorrect); 3: not enough space; 4: formatting; 5: SD card not detected | memory card status, can only be read                         |
| SDCardStorage     | String     | -                                                            | memory card capacity, can only read                          |
| SDCardFormat      | BOOL       | `YES`: start formatting                                      | format memory card, can only be published                    |
| SDCardFormatState | int        | -2001: formatting exception<br />1-100: formatting progress  | memory card format status or progress, can only be read      |
| SDCardRecord      | BOOL       | `YES`: on; `NO`: off                                         | device video recording switch, video recording is saved in memory card |
| RecordMode        | String     | "1": event recording; "2": continuous recording              | device memory card recording mode                            |

The value of `SDCardStorage`is a string which composed of total capacity, used capacity, free capacity by joined '|', the unit is `kb`. For example: "16777216|1048576|15728640" means that the total capacity is 16Gb, 1Gb has been used, and  15Gb is free.

### PTZ control

|Data  point | Value type | Value range | Description |
| ---------- | -------- | ----------------------------- ----- | -------------------------------------- |
| PTZControl | String | "0": up; "2": right; "4": down; "6": left | controls the PTZ camera to rotate in the specified direction, and can only be published |
|PTZStop | BOOL | YES: Stop rotation | stop camera rotation, can only be published |

### Doorbell

| Data point | Value type | Value range | Description |
| ------------------- | -------- | -------------------- -------- | ----------------------------------------- -|
|WirelessAwake | BOOL | YES: wake up; NO: sleep | whether the device is sleeping, when publish, only YES can be publish to wake up the device |
|WirelessPowerMode | String | "0": battery-powered; "1": plug-in power | device power mode |
|WirelessElectricity | int | 1-100: power | percentage of the device ’s current power, which can only be read |
|WirelessLowpower | int | 1-100: low battery threshold value | when the device battery level is lower than this value, a notification alarm is triggered |
| WirelessBatteryLock | BOOL | `YES`: on;` NO`: off | device battery lock, the battery cannot be removed directly when off |

### Enum data points

The value range of the data point of the string enum type, there are corresponding string enumeration constants defined in the SDK. The memory card status is an integer enum. You can view the specific definition in `TuyaSmartCameraDPManager.h`.

| Data points | Value type |
| ------------------ | --------------------------- |
| BasicNightvision | TuyaSmartCameraNightvision |
| BasicPIR | TuyaSmartCameraPIR |
| MotionSensitivity | TuyaSmartCameraMotion |
| DecibelSensitivity | TuyaSmartCameraDecibel |
| RecordMode | TuyaSmartCameraRecordMode |
| PTZControl | TuyaSmartCameraPTZDirection |
| WirelessPowerMode | TuyaSmartCameraPowerMode |
| SDCardStatus | TuyaSmartCameraSDCardStatus |


**Example**

ObjC

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dpManager = [[TuyaSmartCameraDPManager alloc] initWithDeviceId:self.devId];
  	[self.dpManager addObserver:self];
  	self.osdSwitch = [[self.dpManager valueForDP:TuyaSmartCameraBasicOSDDPName] boolValue];
}

- (void)openOSD {
    // Determine if the device supports this data point
    if ([self.dpManager isSupportDP:TuyaSmartCameraBasicOSDDPName]) {
        [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraBasicOSDDPName success:^(id result) {
          	self.osdSwitch = [result boolValue];
        } failure:^(NSError *error) {
						// network error
        }];
    }
}

#pragma mark - TuyaSmartCameraDPObserver
- (void)cameraDPDidUpdate:(TuyaSmartCameraDPManager *)manager dps:(NSDictionary *)dpsData {
    // If the data points of the change includes time watermark switch
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
    // Determine if the device supports this data point
    guard self.dpManager.isSupportDP(.basicOSDDPName) else {
        return
    }
    self.dpManager.setValue(true, forDP: .basicOSDDPName, success: { result in
        self.osdSwitch = result as! Bool
    }) { _ in
				// network error
    }
}

func cameraDPDidUpdate(_ manager: TuyaSmartCameraDPManager!, dps dpsData: [AnyHashable : Any]!) {
    // If the data points of the change includes time watermark switch
    if let osdValue = dpsData[TuyaSmartCameraDPKey.basicOSDDPName] {
        self.osdSwitch = osdValue as! Bool
    }
}
```

