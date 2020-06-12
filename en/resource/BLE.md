

# Bluetooth Low Energy 




Single BLE Device is a devcie that able to **one-to-one connect to smart phone by bluetooth**。Such as Bluetooth bracelet, Bluetooth headset, Bluetooth speaker, etc. Each device can connect to one smart phone by bluetooth at most at the same time，At present, **the number of bluetooth connections for each mobile phone terminal is controlled within 6 ~ 7**

|        Class Name         |      Description       |
| :-----------------------: | :--------------------: |
|    TuyaSmartBLEManager    |    BLE device class    |
| TuyaSmartBLEWifiActivator | Dual mode device class |

`TuyaSmartBLEManager` contains all the features of the BLE SDK，Includes scanning device, single BLE device activation, dual-mode device activation, BLE device function, BLE ota, error code,  etc.

`TuyaSmartBLEWifiActivator`  supports dual mode device activator



## Preparatory Work


### Bluetooth Status Monitor

**Declaration**

BLE SDK provides the method of Bluetooth status monitor，while bluetooth state changing （turn on or turn off ），you can receive the notification by setting delegate

**Example**

Objc:

```objective-c
// Set delegate
[TuyaSmartBLEManager sharedInstance].delegate = self;


/**
 * Notification of bluetooth state change
 *
 * @param isPoweredOn   bluetooth state，turn on or turn off  
 */
- (void)bluetoothDidUpdateState:(BOOL)isPoweredOn {
    NSLog(@"bluetooth state: %d", isPoweredOn ? 1 : 0);
}
```

Swift:

```swift
// Set delegate
TuyaSmartBLEManager.sharedInstance().delegate = self

/**
  * Notification of bluetooth state change
  *
  * @param isPoweredOn   bluetooth state，turn on or turn off  
 */
func bluetoothDidUpdateState(_ isPoweredOn: Bool) {
   print("bluetooth state: \(isPoweredOn ? 1 : 0)");
}

```



## Scanning Device


### Start Scanning

**Declaration**

The BLE device to be active will continuously send Bluetooth broadcast packets to the surrounding area, and the client can discover these broadcast packet, BLE SDK will filter the target device by the rule of Tuya BLE device information in the broadcast packet

```objective-c
/**
 * Start scan
 *
 * @param clearCache   wheather clean up the caches of scaned devices 
 */
- (void)startListening:(BOOL)clearCache;

```

**Parameters**

| Parameter  | Description                                    |
| ---------- | ---------------------------------------------- |
| clearCache | Wheather clean up the caches of scaned devices |

**Example**

Objc:

```objective-c
// Set delegate
[TuyaSmartBLEManager sharedInstance].delegate = self;
// Start scan
[[TuyaSmartBLEManager sharedInstance] startListening:YES];


/**
 * The inactive device that discovered
 *
 * @param deviceInfo 	inactive device Model 
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo {
    // scaned inactive device successfully
    // if the device has actived，it will not in this callback，BLE SDK will connect and active this device automatically
}
```

Swift:

```swift
// set delegate
TuyaSmartBLEManager.sharedInstance().delegate = self
// Start scan
TuyaSmartBLEManager.sharedInstance().startListening(true)

/**
 * The inactive device that discovered
 * 
 * @param deviceInfo 	inactive device Model 
 */
func didDiscoveryDevice(withDeviceInfo deviceInfo: TYBLEAdvModel) {
    // scaned inactive device successfully
    // if the device has actived，it will not in this callback，BLE SDK will connect and active this device automatically
}
```


### Stop Scanning

Stop scanning devices, such as exiting the activation page

**Declaration**

```objective-c
/**
 * Stop scan
 *
 * @param clearCache   wheather clean up the caches of scaned devices 
 */
- (void)stopListening:(BOOL)clearCache;
```

**Parameters**

| Parameter  | Description                                    |
| ---------- | ---------------------------------------------- |
| clearCache | Wheather clean up the caches of scaned devices |
**Example**

Objc:

```objective-c
[[TuyaSmartBLEManager sharedInstance] stopListening:YES];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().stopListening(true)
```



## BLE Device Activation


### Start Activation

**Declaration**

After scanning an inactive device, the device can be activated and registered to the Tuya cloud

```objective-c
/**
 * Active device
 * The activation process will register device to the tuya cloud
 */
- (void)activeBLE:(TYBLEAdvModel *)deviceInfo
           homeId:(long long)homeId
          success:(void(^)(TuyaSmartDeviceModel *deviceModel))success
          failure:(TYFailureHandler)failure;
```

**Parameters**

| Parameter  | Description                                       |
| ---------- | ------------------------------------------------- |
| deviceInfo | Device Model，is from the delegate of scan method |
| homeId     | Currect home Id                                   |
| success    | Success callback                                  |
| failure    | Failure callback                                  |

**Example**

Objc:

```objective-c
[[TuyaSmartBLEManager sharedInstance] activeBLE:deviceInfo homeId:homeId success:^(TuyaSmartDeviceModel *deviceModel) {
        // active success
        
    } failure:^{
        // active fail
    }];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().activeBLE(<deviceInfo: deviceInfo, homeId:homeId, success: { (deviceModel) in
        // active success
        }) {
        // active fail
        }
```



## Dual-mode Device Activation


### Start Dual-mode Device Activation

**Declaration**

After scanning an inactive device, the device can be activated and registered to the Tuya cloud

```objective-c
/**
 *  connect ble wifi device
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

**Parameters**

| Parameter | Description             |
| --------- | ----------------------- |
| UUID      | Device uuid             |
| homeId    | Currect home Id         |
| productId | Product Id              |
| ssid      | Router hotspot name     |
| password  | Router hotspot password |
| timeout   | Scan timeout            |
| success   | Success callback        |
| failure   | Failure callback        |

**Example**

Objc:

```objective-c
  [[TuyaSmartBLEWifiActivator sharedInstance] startConfigBLEWifiDeviceWithUUID:TYBLEAdvModel.uuid homeId:homeId productId:TYBLEAdvModel.productId ssid:ssid password:password  timeout:100 success:^{
     // active success
        } failure:^{
     // active fail
        }];
```

Swift:

```swift
  TuyaSmartBLEWifiActivator.sharedInstance() .startConfigBLEWifiDevice(withUUID: TYBLEAdvModel.uuid, homeId: homeId, productId:TYBLEAdvModel.productId, ssid: ssid, password: password, timeout: 100, success: {
     // active success
        }) {
     // active fail
        }
```


### Callback of Dual Mode Device Activator

**Declaration**

You can get the result of device activator by setting delegate

**Example**

Objc:

```objective-c
- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    if (!error && deviceModel) {
		// activator success
    }
  
    if (error) {
    // activator fail
    }
}
```

Swift:

```swift
func bleWifiActivator(_ activator: TuyaSmartBLEWifiActivator, didReceiveBLEWifiConfigDevice deviceModel: TuyaSmartDeviceModel, error: Error) {
    if (!error && deviceModel) {
		// activator success
    }

    if (error) {
    // activator fail
    }
}
```


### Cancel Dual-mode Device Activation

**Declaration**

Stop discover device

**Example**

Objc:

```objective-c
// use after activator finished
[[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
```

Swift:

```swift
// use after activator finished
TuyaSmartBLEWifiActivator.sharedInstance().stopDiscover
```



## BLE Device Function


### Device Status Query

**Declaration**

Query if the device is locally connected

```objective-c
- (BOOL)deviceStatueWithUUID:(NSString *)uuid;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| uuid      | Device uuid      |


**Example**

Objc:

```objective-c
  BOOL isOnline = [TuyaSmartBLEManager.sharedInstance deviceStatueWithUUID:uuid];
```

Swift:

```swift
  var isOnline:BOOL = TuyaSmartBLEManager.sharedInstance().deviceStatue(withUUID: "uuid")
```


### Connect Device

**Declaration**

If the device is offline, you can call the connection method to connect the device.

```objective-c
- (void)connectBLEWithUUID:(NSString *)uuid
                productKey:(NSString *)productKey
                   success:(TYSuccessHandler)success
                   failure:(TYFailureHandler)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| uuid      | Device uuid      |
| productKey       | Product Id       |
| success   | Success callback |
| failure   | Failure callback |

**Example**

Objc:

```objective-c
  [[TuyaSmartBLEManager sharedInstance] connectBLEWithUUID:@"your_device_uuid" productKey:@"your_device_productKey" success:success failure:failure];
```

Swift:

```swift
  TuyaSmartBLEManager.sharedInstance().connectBLE(withUUID: @"your_device_uuid", productKey: @"your_device_productKey", success: success, failure: failure)
```


### Device DP Publish

Dp publish refer to [Functions of device](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#functions-of-device)


### Query Device Name

**Declaration**

After receiving the device broadcast package, the device name can be queried by this method

```objective-c
/**
 * Query device name
 */
- (void)queryNameWithUUID:(NSString *)uuid
               productKey:(NSString *)productKey
                  success:(void(^)(NSString *name))success
                  failure:(TYFailureError)failure;
```

**Parameters**

| Parameter  | Description      |
| ---------- | ---------------- |
| uuid       | Device uuid      |
| productKey | Product Id       |
| success    | Success callback |
| failure    | Failure callback |

**Example**

Objc:

```objective-c
[[TuyaSmartBLEManager sharedInstance] queryNameWithUUID:bleAdvInfo.uuid productKey:bleAdvInfo.productId success:^(NSString *name) {
        // query device name success
        
    } failure:^{
        // query device name failure
    }];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().queryName(withUUID: bleAdvInfo.uuid, productKey: bleAdvInfo.productId, success: { (name) in
        // query device name success                                                                                      
}, failure: { (error) in
        // query device name failure
})
```



## BLE OTA


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
| upgradeType   | NSInteger | 0:App remind upgrade 2:App force upgrade 3:Check upgrade     |
| url           | NSString  | URL for firmware                                             |
| fileSize      | NSString  | Firmware size                                                |
| md5           | NSString  | MD5 for firmware                                             |
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


### OTA Upgrade

**Declaration**

For device with firmware upgrade, the device can be upgraded by sending firmware upgrade packets. The firmware upgrade packets information needs to be requested form cloud

```objective-c
/**
 * Send OTA package, make sure the device is connected before upgrading
 */
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| uuid      | Device uuid      |
| pid       | Product Id       |
| otaData   | OTA upgrade data |
| success   | Success callback |
| failure   | Failure callback |

**Example**

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

[[TuyaSmartBLEManager sharedInstance] sendOTAPack:deviceModel.uuid pid:deviceModel.pid otaData:data success:^{
       NSLog(@"OTA success");
    } failure:^{
       NSLog(@"OTA failure");
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

TuyaSmartBLEManager.sharedInstance().sendOTAPack(deviceModel.uuid, pid: deviceModel.pid, otaData: data, success: {
    print("OTA success");
}) {
    print("OTA failure");
}
```



## Error Code

| Code | Description                                                 |
| ---- | ----------------------------------------------------------- |
| 1    | Format of the packet received by the device is incorrect    |
| 2    | The device cannot find the router                           |
| 3    | Wi-Fi password error                                        |
| 4    | Device cannot connect to router                             |
| 5    | Device DHCP failed                                          |
| 6    | The device fails to connect to the cloud                    |
| 100  | User cancels activation                                     |
| 101  | Bluetooth connection error                                  |
| 102  | Bluetooth service error found                               |
| 103  | Failed to open Bluetooth communication channel              |
| 104  | Bluetooth failed to get device information                  |
| 105  | Bluetooth pairing failed                                    |
| 106  | Activation timeout                                          |
| 107  | Wi-Fi information transmission failed                       |
| 108  | Token is invalid                                            |
| 109  | Failed to get Bluetooth encryption key                      |
| 110  | Device does not exist                                       |
| 111  | Device cloud registration failed                            |
| 112  | Device cloud activation failed                              |
| 113  | Cloud device has been bound                                 |
| 114  | Active disconnect                                           |
| 115  | Failed to get device information in the cloud               |
| 116  | The device is being networked by other methods at this time |
| 117  | OTA upgrade failed                                          |
| 118  | OTA upgrade timeout                                         |
| 119  | Wi-Fi parameter verification failed                         |