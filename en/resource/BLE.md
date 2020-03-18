

## Guidelines for Single BLE SDK 



### Single BLE Introduce

Single BLE Device is a devcie that able to **one-to-one connect to smart phone by bluetooth**。Such as Bluetooth bracelet, Bluetooth headset, Bluetooth speaker, etc. Each device can connect to one smart phone by bluetooth at most at the same time，At present, **the number of bluetooth connections for each mobile phone terminal is controlled within 6 ~ 7**

|        Class Name         |      Description       |
| :-----------------------: | :--------------------: |
|    TuyaSmartBLEManager    |    BLE device class    |
| TuyaSmartBLEWifiActivator | Dual mode device class |

`TuyaSmartBLEManager` contains all the features of the BLE SDK，Includes Bluetooth status monitor, ble device scan, query ble device name, ble device activator, device OTA upgrade, etc.

`TuyaSmartBLEWifiActivator`  supports dual mode device activator



### Preparatory Work

Tuya iOS Single BLE SDK （ Hereinafter referred to as BLE SDK or Single BLE SDK ），is developed on the basis of [TuyaSmart SDK](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/)



## BLE Device Management


#### Bluetooth Status Monitor

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



#### BLE Device Scan

**Declaration**

The BLE device to be active will continuously send Bluetooth broadcast packets to the surrounding area, and the client can discover these broadcast packet, BLE SDK will filter the target device by the rule of Tuya BLE device information in the broadcast packet

```objective-c
/**
 * Start scan
 *
 * @param clearCache   wheather clean up the caches of scaned devices 
 */
- (void)startListening:(BOOL)clearCache;

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



#### Active Device

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
[[TuyaSmartBLEManager sharedInstance] activeBLE:deviceInfo homeId:#<当前家庭的 home id> success:^(TuyaSmartDeviceModel *deviceModel) {
        // active success
        
    } failure:^{
        // active fail
    }];
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().activeBLE(<deviceInfo: deviceInfo, homeId: #<当前家庭的 home id>, success: { (deviceModel) in
        // active success
        }) {
        // active fail
        }
```



#### BLE Device OTA Upgrade

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



#### Query Device Name

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



#### Device DP Publish

Dp publish refer to [Functions of device](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#functions-of-device)



##Dual Mode Device Activator


#### Dual Mode Device Scan

**Declaration**

BLE SDK provides the method of scan dual mode BLE device，while discover device，you can receive the device information by setting delegate

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
 * @param deviceInfo  inactive device Model
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo {
      // scaned inactive device
}
```

Swift:

```swift
// Set delegate
TuyaSmartBLEManager.sharedInstance().delegate = self

// Start scan
TuyaSmartBLEManager.sharedInstance().startListening(true)

/**
 * The inactive device that discovered
 *
 * @param deviceInfo  inactive device Model
 */
func didDiscoveryDevice(withDeviceInfo deviceInfo: TYBLEAdvModel) {
    // scaned inactive device
}
```



#### Dual Mode Device Active

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



#### Callback of Dual Mode Device Activator

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



#### Stop Discover Dual Mode Device

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
TuyaSmartBLEWifiActivator.sharedInstance() .stopDiscover
```