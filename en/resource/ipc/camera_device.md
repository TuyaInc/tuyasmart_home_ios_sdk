## Camera device

After get the device list in home, you can determine whether it is a smart camera device based on the type of device. If it is a smart camera device, you can create a camera object based on the information in `TuyaSmartDeviceModel`.

### Determine if it is a smart camera

You can determine the type of device according to the `category` property of` TuyaSmartDeviceModel`. The category of the smart camera is `sp`.

**Example**

ObjC

```objc
[[TuyaSmartHomeManager new] getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
		[homes enumerateObjectsUsingBlock:^(TuyaSmartHomeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:obj.homeId];
				[home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
						[home.deviceList enumerateObjectsUsingBlock:^(TuyaSmartDeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            		if ([obj.category isEqualToString:@"sp"]) {
                		NSLog(@"%@ is a smart camera", obj.name);
            		}
        }];
        } failure:^(NSError *error) {

        }];
    }];
} failure:^(NSError *error) {

}];
```

Swift

```swift
let homeManager = TuyaSmartHomeManager()
homeManager.getHomeList(success: { homeList in
    homeList?.forEach({ homeModel in
        let home = TuyaSmartHome(homeId: homeModel.homeId)
        home?.getDetailWithSuccess({ _ in
            home?.deviceList.forEach({ deviceModel in
                if deviceModel.category == "sp" {
                    print(deviceModel.name!, "is a smart camera")
                }
            })
        }, failure: { error in

        })
    })
}) { error in

}
```

> Note that the sample code here is only to show the simplest process of filtering out the camera device. In actual development, the device should be displayed and managed according to the logic of UI interaction.

### Camera configuration information

After filtering out the smart camera devices, you can get the camera configuration information according to the device id, that is, the `devId` attribute of` TuyaSmartDeviceModel`.

Configuration information needs to be obtained through Tuya open api.

**Declaration**

|API | Version | Description |
| --------------------- | ---- | ---------------------- ----- |
|~~tuya.m.ipc.config.get~~ (Deprecated) | 2.0 | Get p2p configuration information of camera |
|tuya.m.rtc.session.init | 1.0 | Get p2p configuration information of camera, and Tuya Cloud will send a offer to device, speed up the connection process |

**Parameters**

|Parameter | Type | Description | Required |
| ------ | ------ | ------ | -------- |
|devId | String | Device id | Yes |

You need to use the `TuyaSmartRequest` class to request the Tuya open api, refer to the document [Common Interface](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/CommonInterface.html).

### Camera instance

The SDK provides factory methods for creating camera configuration objects and camera control objects.

**Class and Protocol**

|Class (Protocol) | Description |
| ----------------------- | ------------------------- ------------------------------- |
|TuyaSmartCameraFactory | Utility class for creating camera configurations and camera objects |
|TuyaSmartCameraConfig | Camera configuration class, developers do not need to care about its properties |
|TuyaSmartCameraType | Camera interface protocol, there are different specific implementations depending on the type of camera firmware |
|TuyaSmartCameraDelegate | Camera delegate, the result feedback of camera function method will be callback through delegate method |



According to the data returned by the interface, use the `TuyaSmartCameraFactory` to create a` TuyaSmartCameraConfig` object as a parameter for creating a camera object. `TuyaSmartCameraFactory` related interfaces are as follows:

**Declaration**

Create camera configuration object.

```objc
+ (TuyaSmartCameraConfig *)ipcConfigWithUid: (NSString *) uid localKey: (NSString *) localKey configData: (NSDictionary *) data;
```

**Parameters**

|Parameter | Description |
| -------- | ---------------------------------------- ---------------- |
|uid | User `uid`,  `[[TuyaSmartUser sharedInstance] .uid` |
|localKey | Device key, `TuyaSmartDeviceModel.localKey` |
|data | Configuration information obtained through the `tuya.m.ipc.config.get` api |

**Return**

| Type | Description |
| --------------------- | -------------- |
|TuyaSmartCameraConfig | Camera configuration object |

**Declaration**

Create a camera instance object.

```objc
+ (id<TuyaSmartCameraType>)cameraWithP2PType:(id)type config:(TuyaSmartCameraConfig *)ipcConfig delegate:(id<TuyaSmartCameraDelegate>)delegate;
```

**Parameters**

| Parameter | Description                 |
| --------- | --------------------------- |
| type      | P2p type of camera          |
| ipcConfig | Camera configuration object |
| delegate  | Camera delegate             |

**Return**

| Type                    | Description                                                |
| ----------------------- | ---------------------------------------------------------- |
| id<TuyaSmartCameraType> | The concrete implementation object of the camera interface |



### P2p type

The IPC SDK supports three p2p channel implementation. The SDK initializes different camera specific implementation objects according to the p2p type.

ObjC

```objc
id p2pType = [deviceModel.skills objectForKey:@"p2pType"];
```

Swift

```swift
let p2pType = deviceModel.skills["p2pType"]
```

**Example**

ObjC

```objc
id p2pType = [deviceModel.skills objectForKey:@"p2pType"];
[[TuyaSmartRequest new] requestWithApiName:@"tuya.m.ipc.config.get" postData:@{@"devId": deviceModel.devId} version:@"2.0" success:^(id result) {
    TuyaSmartCameraConfig *config = [TuyaSmartCameraFactory ipcConfigWithUid:[TuyaSmartUser sharedInstance].uid localKey:deviceModel.localKey configData:result];
    id<TuyaSmartCameraType> camera = [TuyaSmartCameraFactory cameraWithP2PType:p2pType config:config delegate:self];
} failure:^(NSError *error) {
    
}];
```

Swift

```swift
let p2pType = deviceModel.skills["p2pType"]
TuyaSmartRequest().request(withApiName: "tuya.m.ipc.config.get", postData: ["devId" : deviceModel.devId], version: "2.0", success: { result in
    let config = TuyaSmartCameraFactory.ipcConfig(withUid: TuyaSmartUser.sharedInstance().uid, localKey: deviceModel.localKey, configData: result as? [AnyHashable : Any])
    let camera = TuyaSmartCameraFactory.camera(withP2PType: p2pType!, config: config!, delegate: self)
}) { error in
    
}
```

> Note that in the above code, the `self` passed in the delegate parameter needs to implement the `TuyaSmartCameraDelegate` protocol.
