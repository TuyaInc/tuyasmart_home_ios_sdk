# Device Configuration

The network configuration modes supported by Tuya smart camera hardware module including:

* Quick connection mode（TLink, it is referred to as the EZ mode）
* Hotspot mode (AP mode)
* Qr code mode

> Qr code mode is relatively simple, it is recommended to use the qr code mode, if the device can not scan the qr code, then try quick connection mode.

Due to Mini SDK and Full SDK, the device activation process and code will be slightly different.

**EZ mode** and **AP mode** is same as other Tuya device，Mini SDK solution refer to [TuyaSmartActivator iOS SDK](https://github.com/TuyaInc/tuyasmart_ios_activator_sdk/blob/master/README.md), Full SDK solution refer to [ Network Configuration](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#network-configuration).

The following focuses on the smart camera's unique Qr code mode.

## Qr code mode

**Flow chart**

```sequence

Title: Qr code mode

participant APP
participant SDK
participant Device
participant Service

Note over APP: Connect to the Wifi of router
Note over Device: Reset device

APP->SDK: Get token
SDK->Service: Get token
Service-->SDK: Response token
SDK-->APP: Response token

APP-->APP: Concatenate the ssid, PWD, token string to generate the qr code
Device-->APP: Camera scan qr code get ssid, PWD, token
Device->Service: Activate the device

APP->SDK: Start network configuration

Service-->Device: Network configuration succeeds
Device-->SDK: Network configuration succeeds
SDK-->APP: Network configuration succeeds

```

**Class and Protocol**

| Class (Protocol)           | Description                           |
| -------------------------- | ------------------------------------- |
| TuyaSmartActivator         | Network configuration package         |
| TuyaSmartActivatorDelegate | Network configuration result delegate |

**Declaration**

Get token from service.

```objc
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                                             |
| --------- | ------------------------------------------------------- |
| homeId    | The home id of which the device will be bound           |
| success   | Success callback, response token                        |
| failure   | Failure callback，error indicates the reason of failure |

**Declaration**

Start network configuration.

```objc
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;
```
**Parameters**

| Parameter | Description        |
| --------- | ------------------ |
| mode      | Configuration mode |
| ssid      | Ssid of Wi-Fi      |
| password  | Password  of Wi-Fi |
| token     | Token              |
| timeout   | Timeout            |

**Declaration**

Stop network configuration.

```objc
- (void)stopConfigWiFi;
```

**Declaration**

Network configuration result delegate callback.

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;
```
**Parameters**

| Parameter   | Description                                     |
| ----------- | ----------------------------------------------- |
| activator   | TuyaSmartActivator object                       |
| deviceModel | TuyaSmartDeviceModel object, nil if failed      |
| error       | Indicates the reason of failure, nil if succeed |



### Get token

Before starting network configuration, the SDK needs to get the token from the service, and then generate the qr code with the ssid of wi-fi and the password. The Token is valid for 10 minutes and will be invalidated upon successful configuration (reconfiguration requires reacquisition). The  device must be bound in a Home, so the token is associated to the home id. After the device successfully activates with this token, it will be bound in the device list of this Home.

**Example**

ObjC

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

Swift

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

### Concatenated Wi-Fi string

After got the token, the ssid and password of the wi-fi  which the device is expected to connect are also needed, which are concatenated into a string in the following way, and then a qr code picture is generated according to this string.

**Example**

ObjC

```objc
NSDictionary *dictionary = @{
@"s": self.ssid,
@"p": self.pwd,
@"t": self.token
};
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
self.wifiJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
```

Swift

```swift
let dictionary = [
    "s": self.ssid,
    "p": self.pwd,
    "t": self.token
]
let jsonData = JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.Element)
self.wifiJsonStr = String(data: jsonData, encoding: String.Encoding.utf8)
```

### Start configuration 

Use the `wifiJsonStr` to generate the qr code, reset the device , point the qr code at the camera, and the device will sound a prompt after capturing the information of the qr code. At this point, start listening for the distribution results through the following interface.

**Example**

ObjC

```objc
[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeQRCode ssid:self.ssid password:self.pwd token:self.token timeout:100];
```

Swift

```swift
TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeQRCode, ssid: self.ssid, password: self.pwd, token: self.token, timeout: 100)
```

### Stop configuration

Stop configuration by this method.

**Example**

ObjC

```objc
[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
```

Swift

```swift
TuyaSmartActivator.sharedInstance()?.stopConfigWiFi()
```

### Delegate callback

The result of network configuration response by `TuyaSmartActivatorDelegate`.

**Example**

ObjC

```objc
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
  	if (deviceModel) {
      	// success
    }else {
      	// error
    }
}
```

Swift

```swift
func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel?, error: Error!) {
		if deviceModel != nil {
      	// success
    }else {
      	// error
    }
}
```

### Mini SDK  solution

If you use Mini SDK solution，can not get token with `TuyaSmartActivator`, your service could get token by Tuya open api，refer to [Open API-Pair Device Management](https://docs.tuya.com/en/iot/open-api/api-list/api/paring-management).

### Binding mode

Tuya smart camera support three binding modes: strong, medium and weak. After the device is successfully activated into the home of the corresponding account, different binding modes and different verification methods are required for unbinding.

* **Strong mode**：Only after the previous user removes the device from the App, the device can be reconfigured and bound to another account.
* **Medium mode**：Without the previous user removing the device from the App, the device can be reconfigured and bound to another account, but a PUSH notification will be sent to the previous account.
* **Weak mode**：Without the previous user removing the device from the App, you can reconfigure the device to bind to another account.

Tuya smart camera just support strong binding mode, and can't change to other mode. If you has a strong demand and has evaluated the impact of modifying to other modes, you can submit an order to the Tuya developer platform.

