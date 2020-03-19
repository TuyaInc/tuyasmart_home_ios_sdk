# Network Configuration

## Functional Overview

The network configuration modes supported by Tuya SDK including:

- Quick Connection Mode 
-  Hotspot Mode
-  Wired Network Configuration
- Sub-device Configuration 
- Bluetooth Wi-Fi Configuration



## Instructions 

| Class Name                              | Description                                                  | Note                      |
| :-------------------------------------- | :----------------------------------------------------------- | :------------------------ |
| TuyaSmartActivator（Singleton）         | Provides Quick Connection Mode, Hotspot Mode, Wired  Network Configuration and Sub-device Configuration. | Called in the main thread |
| TuyaSmartBLEManager （Singleton）       | Provides the ability to scan Bluetooth                       | Called in the main thread |
| TuyaSmartBLEWifiActivator （Singleton） | Provides Bluetooth Wi-Fi dual-mode network configuration     | Called in the main thread |



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

#### Start Network Configuration

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



#### Stop Network Configuration.

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

### HotSpot Mode

**Process of HotSpot mode network configuration**

```sequence

Title: HotSpot Mode

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

Before the HotSpot Mode network configuration, the SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 10 minutes, and the Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network.

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

**Declaration**

Callback of config network status update.

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

```

**Parameters**

| Parameters  | **Description**                                  |
| :---------- | :----------------------------------------------- |
| activator   | Instance object of TuyaSmartActivator            |
| deviceModel | Return deviceModel when network config successed |
| error       | Retrun error message when network config failed  |

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

#### Start Network Configuration

HotSpot mode network configuration

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

The Hotspot Mode network configuration is the same to the Quick Connection Mode network configuration. You just need to change the first parameter of the `[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]` to TYActivatorModeAP. But the `ssid` and `password` needs to be the name and password of router hotspot instead of the device hotspot.

#### Stop Network Configuration.

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

### Wired Network Configuration 

The wired device is connected to the network, not need the name and password of router during the network configuration.  The figure below uses ZigBee wired gateway as an example to describe the wired gateway network configuration process.

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



#### Discovery Device

Tuya SDK provides the function of discovering the wired devices. You should register the notification of the wired device to get device infomation. Before obtaining the device, the phone must be connected to the same network as the device. 

**Notification**

```objc
// Notification name 
// Receiving device infomation from wired config network 
TuyaSmartActivatorNotificationFindGatewayDevice;
```

#### Get Token

Before the Wired Network Configuration, the SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 10 minutes, and the Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network.

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

#### Wired Network Configuration 

**Declaration**

```objc
- (void)startConfigWiFiWithToken:(NSString *)token timeout:(NSTimeInterval)timeout
```



**Parameters**

| **Parameters** | **Description**              |
| :------------- | :--------------------------- |
| token          | Config Token                 |
| timeout        | Timeout, default 100 seconds |

**Example**

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


### Activate the Sub-Device

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

#### Start Network Configuration

**Declaration**

```objc
- (void)activeSubDeviceWithGwId:(NSString *)gwId timeout:(NSTimeInterval)timeout
```

**Parameters**

| **Parameters** | **Description**              |
| :------------- | :--------------------------- |
| gwId           | Gateway Id                   |
| timeout        | Timeout, default 100 seconds |

**Example**

Objc:

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

#### Stop Activating the Sub-Device

The `stopActiveSubDeviceWithGwId` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

**Declaration**

```objc
- (void)stopActiveSubDeviceWithGwId:(NSString *)gwId
```

**Parameters**

| Parameters | **Description** |
| ---------- | --------------- |
| gwId       | Gateway Id      |

**Example**

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



### Bluetooth Wi-Fi Configuration

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

#### Discovery Device

**Declaration**

```objc
- (void)startListening:(BOOL)clearCache
```

**Parameters**

| Parameters | **Description**                   |
| :--------- | :-------------------------------- |
| clearCache | Whether to clear the cache device |

**Example**

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

**Declaration**

```objc
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

| **Parameters** | **Description**                           |
| :------------- | :---------------------------------------- |
| UUID           | Unique identifier of the Bluetooth device |
| homeId         | Current homeId                            |
| productId      | Product Id                                |
| ssid           | Name of router                            |
| password       | Password of router                        |
| timeout        | Timeout                                   |
| success        | Success callback                          |
| failure        | Failure callback                          |

**Example**
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

**Declaration**

```objc
- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error
```

**Parameters**

| **Parameters** | **Description**                                  |
| :------------- | :----------------------------------------------- |
| activator      | Instance object of  TuyaSmartBLEWifiActivator    |
| deviceModel    | Return deviceModel when network config successed |
| error          | Retrun error message when network config failed  |

**Example**

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



#### Stop Discovery

**Declaration**

```objc
- (void)stopDiscover;
```

**Example**

Objc :

```objective-c
[[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
```

Swift :

```swift
TuyaSmartBLEWifiActivator.sharedInstance() .stopDiscover
```

