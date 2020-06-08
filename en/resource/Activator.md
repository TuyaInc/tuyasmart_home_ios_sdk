# Device Configuration

## Functional Overview

The network configuration modes supported by Tuya SDK including:

- Quick Connection (EZ) Mode 
-  Hotspot (AP) Mode
-  Camera Scan Code Network Configuration
-  Wired Network Configuration
- Sub-device Configuration 
- Bluetooth Configuration




| Attributes                             | Description                                                  |
| -------------------------------------- | ------------------------------------------------------------ |
| Wi-Fi Device                           | The device that use Wi-Fi module to connect the router, and interact with APP and cloud. |
| EZ mode                                | Also known as the quick connection mode, the APP packs the network data packets into the designated area of the 802.11 data packets and sends them to the surrounding environment. The Wi-Fi module of the smart device is in the promiscuous model and monitors and captures all the packets in the network. According to the agreed protocol data format, it can parse out the network information packet sent by the APP. |
| AP mode                                | Also known as hotspot mode. The mobile phone connects the smart device's hotspot, and the two parties establish a Socket connection to exchange data through the agreed port. |
| Camera scan code configuration network | The camera device obtains the configuration data information by scanning the QR code on the APP. |
| Wired Devices                          | Devices connected to the router via a wired network, such as ZigBee wired gateway, wired camera, etc. |
| Sub-device                             | Devices that interact with APP and cloud data through gateways, such as ZigBee sub-devices |
| ZigBee                                 | ZigBee technology is a short-range, low-complexity, low-power, low-speed, low-cost two-way wireless communication technology. It is mainly used for data transmission between various electronic devices with short distances, low power consumption and low transmission rates, as well as typical applications with periodic data, intermittent data and low response time data transmission. |
| ZigBee Gateway                         | The device that integrates the coordinator and WiFi functions in the ZigBee network is responsible for the establishment of the ZigBee network and the storage of data information. |
| ZigBee sub-device                      | Routing or terminal equipment in ZigBee network, responsible for data forwarding or terminal control response. |

## 

## Instructions 

Before configuring the device, you need to understand the basic logic of the iOS Home SDK, and use the iOS Home SDK to complete basic operations such as login and family creation

| Class Name                      | Description                                                  | Note                      |
| :------------------------------ | :----------------------------------------------------------- | :------------------------ |
| TuyaSmartActivator（Singleton） | Provides Quick Connection Mode, Hotspot Mode, Wired  Network Configuration and Sub-device Configuration. | Called in the main thread |



## Implementation



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



### Camera Scan Code Network Configuration

The smart camera's unique QR code mode refer to [QR code mode](https://tuyainc.github.io/tuyasmart_camera_ios_sdk_doc/en/resource/activitor.html#qr-code-mode)



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
// message the receiver sends observer likes: @{@"productId":productId, @"gwId":gwId}
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


### Sub-Device Configuration

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



### Bluetooth Configuration

For Bluetooth device configuration, you can refer to the document [BLE](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/BLE.html).





