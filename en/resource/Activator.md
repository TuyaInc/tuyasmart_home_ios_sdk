# Network Configuration

## Functional Overview

The network configuration modes supported by Tuya SDK including:

- Quick Connection Mode 
-  Hotspot Mode
-  Wired Network Configuration
- Sub-device Configuration 
- Bluetooth Wi-Fi Configuration



## Instructions 

| Class Name                         | Description                                                | Note                   |
| :--------------------------------- | :--------------------------------------------------------- | :--------------------- |
| TuyaSmartActivator（单例）         | 提供快连模式、热点模式、有线设备激活、子设备激活等配网能力 | 需要在主线程中调用该类 |
| TuyaSmartBLEManager （单例）       | 提供扫描蓝牙能力                                           | 需要在主线程中调用该类 |
| TuyaSmartBLEWifiActivator （单例） | 提供蓝牙-WiFi 双模配网能力                                 | 需要在主线程中调用该类 |



### Quick Connection Mode

**Process of Quick Connection Mode network configuration:**

```sequence

Title: Quick Connection Mode

participant APP
participant SDK
participant Device
participant Service

Note over APP: Connect to the Wifi of router
Note over Device: Switch to the EZ mode

APP->SDK: Get Token
SDK->Service: Get Token
Service-->SDK: Response Token
SDK-->APP: Response Token

APP->SDK: Start network configuration (send configuration data)
Note over SDK: broadcast configuration data
Device->Device: Get configuration data

Device->Service: Activate the device
Service-->Device: Network configuration succeeds

Device-->SDK: Network configuration succeeds
SDK-->APP: Network configuration succeeds

```



#### Get Token

Before the Quick Connection Mode network configuration, SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 10 minutes, and Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network.



**Declaration**

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```



**Parameters**

| Parameters | **Description**             |
| :--------- | :-------------------------- |
| homeId     | Home Id                     |
| success    | Success block, return Token |
| failure    | Failure block               |

**Example**

Objc:

```objc
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

#### Start network configuration.

**Declaration**

```objc
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;
```

**Parameters**

| Parameters | Description                  |
| :--------- | :--------------------------- |
| mode       | Config mode                  |
| ssid       | Name of route                |
| password   | Password of route            |
| token      | Config Token                 |
| timeout    | Timeout, default 100 seconds |



**Declaration**

Callback of config network status update.

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;
```



**Example**

Objc:

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// Set TuyaSmartActivator delegate，impl delegate method
	[TuyaSmartActivator sharedInstance].delegate = self;

	// start activator
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeEZ ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//active success
    }

    if (error) {
        //active failure
    }
}

```

Swift:

```swift
func startConfigWiFi(withSsid ssid: String, password: String, token: String) {
    // Set TuyaSmartActivator delegate，impl delegate method
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // start activator
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeEZ, ssid: ssid, password: password, token: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //active success
    }
        
    if let e = error {
        //active failure
        print("\(e)")
    }
}
```



#### Stop network configuration.

The App will continuously broadcast the network configuration information until the network configuration succeeds or the timeout is reached once the network configuration starts. The `[TuyaSmartActivator stopConfigWiFi]` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

**Declaration**

```objc
- (void)stopConfigWiFi;
```



**Example**

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


## Hotsopt Mode

**Process of hotsopt mode network configuration**

```sequence

Title: Hotsopt Mode

participant APP
participant SDK
participant Device
participant Service

Note over Device: Switch to the hotspot mode
APP->SDK: Get Token
SDK->Service: Get Token
Service-->SDK: Response Token
SDK-->APP: Response Token

Note over APP: Connect the hotspot device

APP->SDK: Start network configuration (send configuration data)
SDK->Device: send configuration data
Note over Device: Device turns off hotspot automatically

Note over Device: The device is connected to the Wifi of router

Device->Service: Activate the device
Service-->Device: Network configuration succeeds

Device-->SDK: Network configuration succeeds
SDK-->APP: Network configuration succeeds

```



#### Get Token

Before the hotsopt mode network configuration, the SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 10 minutes, and the Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network.

**Declaration**

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | **Description**             |
| :--------- | :-------------------------- |
| homeId     | Home Id                     |
| success    | Success block, return Token |
| failure    | Failure block               |

**Example**

Objc:

```objc
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

#### Start network configuration.

Hotsopt mode network configuration:

**Declaration**

```objc
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;
```



**Parameters**

| Parameters | Description                  |
| :--------- | :--------------------------- |
| mode       | Config mode                  |
| ssid       | Name of route                |
| password   | Password of route            |
| token      | Config Token                 |
| timeout    | Timeout, default 100 seconds |

**Example**

Objc:

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// Set TuyaSmartActivator delegate，impl delegate method
	[TuyaSmartActivator sharedInstance].delegate = self;

	// Start activator
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeAP ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//active success
    }

    if (error) {
        //active failure
    }
}

```

Swift:

```swift
func startConfigWiFi(withSsid ssid: String, password: String, token: String) {
    // Set TuyaSmartActivator delegate，impl delegate method
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // Start activator
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeAP, ssid: ssid, password: password, token: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //active success
    }
        
    if let e = error {
        //active failure
        print("\(e)")
    }
}
```

The hotspot mode network configuration is the same to the quick connection mode network configuration. You just need to change the first parameter of the `[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]` to TYActivatorModeAP. But the `ssid` and `password` needs to be the name and password of router hotspot instead of the device hotspot.

#### Stop network configuration.

The App will continuously broadcast the network configuration information until the network configuration succeeds or the timeout is reached once the network configuration starts. The `[TuyaSmartActivator stopConfigWiFi]` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

**Declaration**

```
- (void)stopConfigWiFi;
```

**Example**

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

#### Wired network configuration 



```sequence

Title: Zigbee Gateway configuration

participant APP
participant SDK
participant Zigbee Gateway
participant Service

Note over Zigbee Gateway: Reset zigbee gateway
APP->SDK: Get Token
SDK->Service: Get Token
Service-->SDK: Response Token
SDK-->APP: Response Token

APP->APP: connect mobile phone to the same hotspot of the gateway

APP->SDK: sends the activation instruction
SDK->Zigbee Gateway: sends the activation instruction
Note over Zigbee Gateway: device receives the activation data

Zigbee Gateway->Service: activate the device
Service-->Zigbee Gateway: network configuration succeeds

Zigbee Gateway-->SDK: network configuration succeeds
SDK-->APP: network configuration succeeds

```

#### Get Token

Before the EZ/AP mode network configuration, the SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 10 minutes, and the Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network.

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

##### Wired network configuration of zigbee

Objc:

```objc
- (void)startConfigWiFiToken:(NSString *)token {
	// Set TuyaSmartActivator delegate，impl delegate method
	[TuyaSmartActivator sharedInstance].delegate = self;

	// Start activator
	[[TuyaSmartActivator sharedInstance] startConfigWiFiWithToken:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

	if (!error && deviceModel) {
		//active success
    }

    if (error) {
        //active failure
    }

}

```

Swift:

```swift
func startConfigWifiToken(_ token: String) {
    // Set TuyaSmartActivator delegate，impl delegate method
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    // Start activator
    TuyaSmartActivator.sharedInstance()?.startConfigWiFi(withToken: token, timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //active success
    }
        
    if let e = error {
        //active failure
        print("\(e)")
    }
}
```

#### Stop network configuration.

The App will continuously broadcast the network configuration information until the network configuration succeeds or the timeout is reached once the network configuration starts. The `[TuyaSmartActivator stopConfigWiFi]` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

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


### Activate the  sub-device

```sequence

Title: Zigbee sub-device configuration

participant APP
participant SDK
participant Zigbee Gateway
participant Service

Note over Zigbee Gateway: Reset zigbee sub device
APP->SDK: sends the subdevice activation instruction
SDK->Zigbee Gateway: sends the activation instruction

Note over Zigbee Gateway: zigbee gateway receives the activation data

Zigbee Gateway->Service: activate the sub device
Service-->Zigbee Gateway: network configuration succeeds

Zigbee Gateway-->SDK: network configuration succeeds
SDK-->APP: network configuration succeeds

```

The `stopActiveSubDeviceWithGwId` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

```objc
- (void)activeSubDevice {
    // Set TuyaSmartActivator delegate，impl delegate method
	[TuyaSmartActivator sharedInstance].delegate = self;

	[[TuyaSmartActivator sharedInstance] activeSubDeviceWithGwId:@"your_device_id" timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {

    if (!error && deviceModel) {
		//active success
    }

    if (error) {
        //active failure
    }
}
```

Swift:

```swift
func activeSubDevice() {
    // Set TuyaSmartActivator delegate，impl delegate method
    TuyaSmartActivator.sharedInstance()?.delegate = self
    
    TuyaSmartActivator.sharedInstance()?.activeSubDevice(withGwId: "your_device_id", timeout: 100)
}

#pragma mark - TuyaSmartActivatorDelegate
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
    if deviceModel != nil && error == nil {
        //active success
    }
        
    if let e = error {
        //active failure
        print("\(e)")
    }
}
```

#### Stop activating the sub-device

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



### Bluetooth-Wifi configuration

If Tuya wifi hardwares support Bluetooth protocol,  Bluetooth-Wifi configuration method can be used to connect  devices. Use bluetooth to transfer information about wifi,  success rate is higher.



```sequence
Title: Bluetooth-WiFi configuration

participant APP
participant SDK
participant device
participant Service

Note over device: reset device
APP->SDK: sends the discovery instruction 
SDK->device: discovery device through bluetooth
device->SDK: return device infomation
SDK->APP: return device infomation

APP->SDK: sends the activation instruction
SDK->device: sends the activation instruction
Note over device: Successfully connected to the router
device->Service: active the device
Service-->device: network configuration succeeds

device->SDK: network configuration succeeds
SDK->APP: network configuration succeeds

Note over APP: stop discovery
			
```

#### Discovery device

Objc:

```objective-c
// set delegate
[TuyaSmartBLEManager sharedInstance].delegate = self;

// start scanning device
[[TuyaSmartBLEManager sharedInstance] startListening:YES];


/**
  get unactive device
 @param deviceInfo unactive device Model
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo {
   // get device -- deviceInfo
}
```

Swift:

```swift
TuyaSmartBLEManager.sharedInstance().delegate = self
TuyaSmartBLEManager.sharedInstance().startListening(true)

/**
  get unactive device
 @param deviceInfo unactive device Model
 */
func didDiscoveryDevice(withDeviceInfo deviceInfo: TYBLEAdvModel) {
   // get device -- deviceInfo
}
```



#### Device Active

Can use the following API to active the Discovered  devices and register them to Tuya Cloud.

```objective-c
/**
 *  connect ble wifi device
 *
 *  @param UUID        Unique identifier of the Bluetooth device
 *  @param homeId      current homeId
 *  @param productId   productId
 *  @param ssid        name of wifi
 *  @param password    password of wifi
 *  @param timeout     time 
 *  @param success     success handler
 *  @param failure     failure handler
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

Objc :

```objective-c
  [[TuyaSmartBLEWifiActivator sharedInstance] startConfigBLEWifiDeviceWithUUID:TYBLEAdvModel.uuid homeId:homeId productId:TYBLEAdvModel.productId ssid:ssid password:password  timeout:100 success:^{
     // active success
        } failure:^{
     // active failure
        }];
```

Swift :

```swift
  TuyaSmartBLEWifiActivator.sharedInstance() .startConfigBLEWifiDevice(withUUID: TYBLEAdvModel.uuid, homeId: homeId, productId:TYBLEAdvModel.productId, ssid: ssid, password: password, timeout: 100, success: {
            // active success
        }) {
            // active failure
        }
```



#### Callback of Device Active

Objc :

```objective-c
 - (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    if (!error && deviceModel) {
		// active success
    }
  
    if (error) {
    // active failure
    }
}
```

Swift :

```swift
func bleWifiActivator(_ activator: TuyaSmartBLEWifiActivator, didReceiveBLEWifiConfigDevice deviceModel: TuyaSmartDeviceModel, error: Error) {
    if (!error && deviceModel) {
		// active success
    }

    if (error) {
       // active failure
    }
}
```



#### Stop discovery

Objc :

```objective-c
[[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
```

Swift :

```swift
TuyaSmartBLEWifiActivator.sharedInstance() .stopDiscover
```

