# Device Management

The device ID needs to be used to initiate all `TuyaSmartDevice` classes related to all functions for device control. Wrong device Id may cause initiation failure, and the `nil` will be returned.

| Class           | Description                  |
| --------------- | ---------------------------- |
| TuyaSmartDevice | Tuya device management class |

**`TuyaSmartDeviceModel` 数据模型**

| Field            | Type                      | Description                                                  |
| ---------------- | ------------------------- | ------------------------------------------------------------ |
| devId            | NSString                  | Device Id                                                    |
| name             | NSString                  | Device Name                                                  |
| iconUrl          | NSString                  | Device Icon URL                                              |
| isOnline         | BOOL                      | Device Online Status. Include Wi-Fi、WLAN、Bluetooth. <br />As long as any of them is YES, the value is YES. |
| isCloudOnline    | BOOL                      | Device Wi-Fi Online Status                                   |
| isLocalOnline    | BOOL                      | Device WLAN Online Status                                    |
| isShare          | BOOL                      | Is Shared Device                                             |
| dps              | NSDictionary              | Dps                                                          |
| dpCodes          | NSDictionary              | Dp Code                                                      |
| schemaArray      | NSArray                   | Data Point Detail                                            |
| productId        | NSString                  | Product Id                                                   |
| capability       | NSUInteger                | Capability                                                   |
| deviceType       | TuyaSmartDeviceModelType  | Device Type                                                  |
| supportGroup     | BOOL                      | Is Support Group                                             |
| gwType           | NSString                  | "v" Means Virtual Device                                     |
| pv               | NSString                  | Protocol Version                                             |
| lpv              | NSString                  | WLAN Protocol Version                                        |
| latitude         | NSString                  | latitude                                                     |
| longitude        | NSString                  | longitude                                                    |
| localKey         | NSString                  | A Key Used For Device Communication                          |
| uuid             | NSString                  | Device uuid                                                  |
| homeId           | long long                 | Home Id For Device                                           |
| roomId           | long long                 | Room Id For Device                                           |
| upgrading        | BOOL                      | Is Upgrading                                                 |
| timezoneId       | NSString                  | Device Timezone Id                                           |
| nodeId           | NSString                  | Device Short Address                                         |
| parentId         | NSString                  | Parent Device Id                                             |
| isMeshBleOnline  | BOOL                      | Device Bluetooth Mesh Online Status                          |
| devKey           | NSString                  | A Key Used For Standard SIG Mesh Device Communication        |
| standard         | BOOL                      | Is a Standardized Device                                     |
| standSchemaModel | TuyaSmartStandSchemaModel | Standardized Data Point Detail                               |
| activeTime       | NSTimeInterval            | Active Time                                                  |
| sharedTime       | long long                 | Shared Time                                                  |



## Update Device Information

### Update Single Device Information

**Declaration**

Sync device info from cloud

```objective-c
- (void)syncWithCloud:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| success   | Success block |
| failure   | Failure block |

**Example**

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

## Device Control

Device control is currently divided into **standard device control** and **custom device control**.

### Standard Device Control (Beta)

#### Standard Device Feature Set

What is the standard device feature set?

The functions of different products are different. For example, in the lighting category, the lamp is used as an example, there are functions such as switching, color adjustment, but for the electrical category, the socket is used as an example, there is no "color" function.

But for a large category, the basic common functions are the same. For example, all lighting categories have the function of switching.

Unify the definition of the function set of similar products and formulate a set of function instruction set rules, which is the standard function set.

> Because it needs to be compatible with a wide variety of product functions, the standard equipment control function is currently in a phase of open product adaptation.
>
> If you want to use this function, you can contact Tuya.

#### Does the Device Support Standardization

The `standard` property (type `BOOL`) of the `TuyaSmartDeviceModel` class defines whether the current device supports standardized control

The `dpCodes` property defines the status of the current device and is called a standard dp code

Each key in the dpCodes dictionary corresponds to a dpCode of a function point, value corresponds to a dpValue of a function point, and dpValue is the value of the function point

#### Standard Device Control

**Declaration**

```objective-c
- (void)publishDpWithCommands:(NSDictionary *)commands
                      success:(nullable TYSuccessHandler)success
                      failure:(nullable TYFailureError)failure
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| commands  | Standard command |
| success   | Success block    |
| failure   | Failure block    |

**Example**

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

【Commands】

```json
// light 
// Each product has a standard set of rules
// bool: open light
{"switch_led" : true}

// string: set color 
{"colour_data" : "009003e803e8"}

// enum: set white mode
{"work_mode" : "white"}

// value: set brightness 100
{"bright_value" : 100}

// Multiple combinations
{"work_mode" : "colour"}
{"colour_data" : "009003e803e8"}
```

#### Update Device Status

After the `TuyaSmartDeviceDelegate` delegate protocol is realized, user can update the UI of the App device control in the callback of device status change.

**Example**

Objc:

```objective-c
- (void)initDevice {
    self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpCommandsUpdate:(NSDictionary *)dpCodes {
    NSLog(@"dpCommandsUpdate: %@", dpCodes);
    // TODO: refresh ui
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    // device info update
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
    // device removed
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
    // TODO: refresh ui
}

func deviceInfoUpdate(_ device: TuyaSmartDevice!) {
    // device info update
}

func deviceRemoved(_ device: TuyaSmartDevice!) {
    // device removed 
}
```

### Custom Device Control

#### Functions of Device

The `dps` (`NSDictionary` type) attribute of the `TuyaSmartDeviceModel` class defines the state of the device, and the state is called data point (DP) or function point.
Each `key` in the `dps` dictionary refers to a `dpId` of a function point, and `Value` refers to the `dpValue` of a function point. The `dpValue` is the value of the function point.
Refer to the functions of product in the [Tuya developer platform](https://iot.tuya.com/) for definition of function points of products. See the following figure.

![功能点](./images/ios_dp_sample.png)

The control instructions shall be sent in the format given below:

`{"<dpId>":"<dpValue>"}`

According to the definition of function points of the product in the back end, the example codes are as follows.

**Example**

Objc:

```objc
- (void)publishDps {
  // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

  NSDictionary *dps;
  
  // Set bool dp value to true
	dps = @{@"1": @(YES)};

  // Set string dp value to "ff5500"
	dps = @{@"4": @"ff5500"};

  // Set enum dp value to "Medium"
	dps = @{@"5": @"Medium"};

  // Set number dp value to 20
	dps = @{@"6": @(20)};

  // Set byte dp value to "1122"
	dps = @{@"15": @"1122"};

  // Send multiple dp values together
	dps = @{@"1": @(YES), @"4": @"ff5500"};

	[self.device publishDps:dps success:^{
		NSLog(@"publishDps success");

    // Publish dp success. device state change will be reported from deviceDpsUpdate delegate callback.

	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];


}
```
Swift:

```swift
func publishDps() {
    var dps = [String : Any]()
 
    // dps: Please refers to the specific product definition
  
    device?.publishDps(dps, success: {
 	    print("publishDps success")
        
      // Publish dp success. device state change will be reported from deviceDpsUpdate delegate callback.
    }, failure: { (error) in
        if let e = error {
            print("publishDps failure: \(e)")
        }
    })
}
```

#### Precautions

- Special attention shall be paid to the type of data in sending the control commands. For example, the data type of function points shall be value, and the `@{@"2": @(25)}` instead of `@{@"2": @"25"}` shall be sent for the control command.
- In the transparent transmission, the byte string shall be the string format, and all letters shall be in the lower case, and the string must have even bits. The correct format shall be: `@{@"1": @"011f"}` instead of `@{@"1": @"11f"}`


For more concepts of function points, please refer to the [QuickStart-Related Concepts of Function Points](https://docs.tuya.com/en/product/function.html)

#### Device Control

Device control supports three kinds of channel control, LAN control, cloud control, and automatic mode (if LAN is online, first go LAN control, LAN is not online, go cloud control)

LAN Control

```objc
	[self.device publishDps:dps mode:TYDevicePublishModeLocal success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

Cloud Control

```objc
	[self.device publishDps:dps mode:TYDevicePublishModeInternet success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

Auto Mode

```objc
	[self.device publishDps:dps mode:TYDevicePublishModeAuto success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

#### Update Device Status

After the `TuyaSmartDeviceDelegate` delegate protocol is realized, user can update the UI of the App device control in the callback of device status change.

**Example**

Objc:

```objc
- (void)initDevice {
	self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
	NSLog(@"deviceDpsUpdate: %@", dps);
	// device dp state was updated
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
  // device name, device online state change, etc.
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
  // device was removed.
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
    // device dp state was updated
}

func deviceInfoUpdate(_ device: TuyaSmartDevice!) {
    // device name, device online state change, etc.
}

func deviceRemoved(_ device: TuyaSmartDevice!) {
    // device was removed.
}
```

## Modify the Device Name

**Declaration**

```objective-c
- (void)updateName:(NSString *)name success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description     |
| --------- | --------------- |
| name      | New device name |
| success   | Success block   |
| failure   | Failure block   |

**Example**

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

## Remove Device

After a device is removed, it will be in the to-be-network-configured status (quick connection mode).

**Declaration**

```objective-c
- (void)remove:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| success   | Success block |
| failure   | Failure block |

**Example**

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

## Obtain Wi-Fi Signal Strength of Device

**Declaration**

After calling Get Device Wi-Fi Signal,  `TuyaSmartDeviceDelegate`  `device:signal:` will be called

```objective-c
- (void)getWifiSignalStrengthWithSuccess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description        |
| --------- | ------------------ |
| success   | Send success block |
| failure   | Failure block      |

**Example**

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

## Obtain the Sub-Device List of a Gateway

**Declaration**

```objective-c
- (void)getSubDeviceListFromCloudWithSuccess:(nullable void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| success   | Success block |
| failure   | Failure block |

**Example**

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

## Firmware Upgrade

**Firmware upgrade process:**

Obtain device upgrade information -> send module upgrade instructions -> module upgrade succeeds -> send upgrade instructions to the device control module -> the upgrade of device control module succeeds

User obtain device upgrade information interface to get TuyaSmartFirmwareUpgradeModel, you can get firmware type from type property, get type description from typeDesc property.

### Obtain Device Upgrade Information

**Declaration**

```objective-c
- (void)getFirmwareUpgradeInfo:(nullable void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| success   | Success block |
| failure   | Failure block |

**`TuyaSmartFirmwareUpgradeModel` Description**

| Field         | Type      | Description                                                  |
| ------------- | --------- | ------------------------------------------------------------ |
| desc          | NSString  | Upgrade title                                                |
| typeDesc      | NSString  | Device type upgrade content                                  |
| upgradeStatus | NSInteger | 0:No upgrade 1:Has new version 2:Upgrading 5:Waiting for wake up |
| version       | NSString  | Firmware version                                             |
| upgradeType   | NSInteger | 0:App Remind upgrade 2:app force upgrade 3:check upgrade     |
| url           | NSString  | URL for firmware                                             |
| fileSize      | NSString  | Firmware size                                                |
| md5           | NSString  | MD5 for Firmware                                             |
| upgradingDesc | NSString  | The content when upgrading                                   |

**Example**

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

Send Upgrade Instruction

**Example**

Objc:

```objc
- (void)upgradeFirmware {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	// type: get firmware type from getFirmwareUpgradeInfo interface
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
    // type: get firmware type from getFirmwareUpgradeInfo interface
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

Callback Interface

**Example**

Objc:

```objc
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type {
	// firmware upgrade success
}

- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type {
	// firmware upgrade failure
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
	// firmware upgrade progress
}

```

Swift:

```swift
func deviceFirmwareUpgradeSuccess(_ device: TuyaSmartDevice!, type: Int) {
    // firmware upgrade success
}

func deviceFirmwareUpgradeFailure(_ device: TuyaSmartDevice!, type: Int) {
    // firmware upgrade failure
}

func device(_ device: TuyaSmartDevice!, firmwareUpgradeProgress type: Int, progress: Double) {
    // firmware upgrade progress
}
```

