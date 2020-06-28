## 摄像机

通过家庭获取到设备列表后，就可以根据设备的类型来判断是否是智能摄像机设备，如果是智能摄像机设备，则可以根据`TuyaSmartDeviceModel`中的信息来创建摄像机对象。

### 判断是否是智能摄像机

可以根据`TuyaSmartDeviceModel`的`category`属性来判断设备的类型，智能摄像机的类型是`sp`。

**示例代码**

ObjC

```objc
[[TuyaSmartHomeManager new] getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
		[homes enumerateObjectsUsingBlock:^(TuyaSmartHomeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:obj.homeId];
				[home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
						[home.deviceList enumerateObjectsUsingBlock:^(TuyaSmartDeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            		if ([obj.category isEqualToString:@"sp"]) {
                		NSLog(@"%@ 是一个智能摄像机设备", obj.name);
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
                    print(deviceModel.name!, "是一个智能摄像机设备")
                }
            })
        }, failure: { error in

        })
    })
}) { error in

}
```

> 注意，这里的示例代码只是展示筛选出摄像头设备的最简单流程，实际开发中，应该根据 UI 交互的逻辑来展示和管理设备。

### 摄像机配置信息

筛选出智能摄像机设备后，就可以根据设备 id，即`TuyaSmartDeviceModel`的`devId`属性来获取摄像机的配置信息。

配置信息需要通过涂鸦云端 open api 来获取。

**接口说明**

| 接口名                              | 版本 | 说明                                                         |
| ----------------------------------- | ---- | ------------------------------------------------------------ |
| ~~tuya.m.ipc.config.get~~（已废弃） | 2.0  | 获取摄像机设备的 p2p 配置信息                                |
| tuya.m.rtc.session.init             | 1.0  | 获取摄像机设备的 p2p 配置信息，涂鸦云端会同时发送一个信令给设备，加速 p2p 连接过程 |

**参数说明**

| 参数名 | 类型   | 说明    | 是否必须 |
| ------ | ------ | ------- | -------- |
| devId  | String | 设备 id | 是       |

需要使用`TuyaSmartRequest`类来调用涂鸦云端的 api，参考文档[通用接口](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/CommonInterface.html)。

### 摄像机实例

Camera SDK 提供创建摄像机配置对象和摄像机控制对象的工厂方法。

**类（协议）说明**

| 类名（协议名）          | 说明                                                     |
| ----------------------- | -------------------------------------------------------- |
| TuyaSmartCameraFactory  | 创建摄像机配置和摄像机对象的工具类                       |
| TuyaSmartCameraConfig   | 摄像机配置类，开发者不用关心它的属性                     |
| TuyaSmartCameraType     | 摄像机接口协议，根据摄像机固件类型不同，有不同的具体实现 |
| TuyaSmartCameraDelegate | 摄像机代理，摄像机功能方法的结果反馈都将通过代理方法回调 |



根据接口返回的数据，使用`TuyaSmartCameraFactory`工具类创建`TuyaSmartCameraConfig`对象，以作为创建摄像机对象的参数。`TuyaSmartCameraFactory`相关接口如下：

**TuyaSmartCameraFactory 接口说明**

创建摄像机配置对象

```objc
+ (TuyaSmartCameraConfig *)ipcConfigWithUid:(NSString *)uid localKey:(NSString *)localKey configData:(NSDictionary *)data;
```

**参数说明**

| 参数     | 说明                                                     |
| -------- | -------------------------------------------------------- |
| uid      | 用户 `uid`，通过`[TuyaSmartUser sharedInstance].uid`获取 |
| localKey | 设备的密钥，通过`TuyaSmartDeviceModel.localKey`获取      |
| data     | 通过`tuya.m.ipc.config.get`接口获取到的配置信息          |

**返回值**

| 类型                  | 说明           |
| --------------------- | -------------- |
| TuyaSmartCameraConfig | 摄像机配置对象 |



创建摄像机实例对象

```objc
+ (id<TuyaSmartCameraType>)cameraWithP2PType:(id)type config:(TuyaSmartCameraConfig *)ipcConfig delegate:(id<TuyaSmartCameraDelegate>)delegate;
```

**参数说明**

| 参数      | 说明              |
| --------- | ----------------- |
| type      | 摄像机的 p2p 类型 |
| ipcConfig | 摄像机配置对象    |
| delegate  | 摄像机代理        |

**返回值**

| 类型                    | 说明                     |
| ----------------------- | ------------------------ |
| id<TuyaSmartCameraType> | 摄像机接口的具体实现对象 |



### P2P 类型

涂鸦智能摄像机支持三种 p2p 通道实现方案，Camera SDK 会根据 p2p 类型来初始化不同的摄像机具体实现的对象，通过下面的方式获取设备的 p2p 类型。

ObjC

```objc
id p2pType = [deviceModel.skills objectForKey:@"p2pType"];
```

Swift

```swift
let p2pType = deviceModel.skills["p2pType"]
```

**示例代码**

ObjC

```objc
// deviceModel 为设备列表中的摄像机设备的数据模型
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

> 注意，上面代码中，`delegate` 参数传入的 `self` 需要实现 `TuyaSmartCameraDelegate` 协议。