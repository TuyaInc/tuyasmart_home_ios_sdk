# 标准蓝牙(SIG) Mesh SDK 使用说明

> 下文将标准蓝牙 Mesh 称作 SIG Mesh

## 项目简介

```objective-c
// 导入头文件
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
```

## 标准蓝牙(SIG) Mesh 介绍

蓝牙技术联盟（Bluetooth Special Interest Group, 简称 SIG）蓝牙技术开始全面支持 Mesh 网状网络。蓝牙Mesh，也就是将蓝牙设备组成网络，每个蓝牙设备可以通过网络内的蓝牙设备进行通讯，将一端的蓝牙信息通过mesh 网络传到较远的另一端。

标准蓝牙 Mesh 也叫做 SIG Mesh，是蓝牙技术联盟提出的 Mesh 网络的通讯标准。使用蓝牙 Mesh 进行组网及功能点的更新，均需要满足标准蓝牙 Mesh 的标准

### 标准蓝牙(SIG) Mesh 的基本概念

- 大小类

  每个 mesh 设备都对应一款产品，每个产品都有自己的大小类标示，sdk 中以 `pcc`、`type` 作为大小类标示

  SIG Mesh 产品目前按以下规则
  

  | 类型 |                   设备类型                   |                     产品类型                      |                           产品子类                           |
  | :--: | :------------------------------------------: | :-----------------------------------------------: | :----------------------------------------------------------: |
  | 取值 | 1=标准型Tuya设备<br />2=透传型Tuya设备<br /> | 0x01=灯类 <br />0x02=插座 <br />0x05=遥控器<br /> | 以灯为例：<br /> 1=一路灯<br /> 2=二路灯<br /> 3=三路灯<br /> 4=四路灯<br /> 5=五路灯<br /> |

  设备 pcc 举例（2 字节，4 字符）

  ```objective-c
     标准涂鸦 四路灯     1410 // 当作 1 01 4 解读， 1 代表设备类型，01 代表产品类型 4 代表子类型   
     标准涂鸦 五路灯     1510
     标准涂鸦 五路插座   2510
     透传型 Tuya 设备 四路灯 1420
     ......
  ```

- mesh 节点 node Id， 2 字节

  node id 用于区分每个 mesh 设备在 mesh 网中的「唯一标识」，比如想控制某个设备就向 mesh 网发此设备对应的 nodeId 命令即可

- mesh 群组 local Id，2 字节

  local Id 用于区分每个 mesh 群组在 mesh 网中的「唯一标识」，比如想控制某个群组中的设备就向 mesh 网发此群组对应的 localId 命令即可

- 设备操作需要多步操作

  因为设备的操作，例如增删操作、群组操作，都需要本地蓝牙命令执行一次、云端记录一次 向本地 mesh 网同步操作信息的同时也需要向云端同步操作信息

- 本地连接和网关连接 

  本地连接：已配网设备通过蓝牙连接，来控制 mesh 和指令操作

  网关连接：已配网设备通过网关连接（网关需和设备在一起，距离不能太远）,来控制 mesh 和指令操作



## 标准蓝牙(SIG) Mesh 管理

> `SIG Mesh` 的主要操作类都在 `TuyaSmartBleMesh+SIGMesh.h` 文件中

### 创建 mesh

一个家庭里可以拥有多个 `sig mesh`（建议一个家庭只创建一个），`sig mesh` 中所有操作都建立在家庭数据已经初始化的基础上

> 完全初始化家庭操作可以在查看[此处](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#家庭管理)


创建 sig mesh
一个家庭建议只创建一个 mesh，创建前需判断下是否已经创建，若尚未创建可以通过此方法进行创建

|  参数           | 说明            |
| --------------- | ----------------|
| homeId         | 家庭 homeId     |
| success         | 成功回调        |
| failure         | 失败回调        |

```objective-c
+ (void)createSIGMeshWithHomeId:(long long)homeId
                        success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                        failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
TuyaSmartHome *home = #<上文初始化的 home 实例>;
long long homeId = home.homeModel.homeId;
[TuyaSmartBleMesh createSIGMeshWithHomeId:homeId success:^(TuyaSmartBleMeshModel *meshModel) {
    // success do...
} failure:^(NSError *error) {
    NSLog(@"create mesh error: %@", error);
}];
```

###  删除 mesh

删除mesh，如果mesh组下有设备，子设备也移除掉

|  参数           | 说明            |
| --------------- | ----------------|
| success         | 成功回调        |
| failure         | 失败回调        |

```
- (void)removeMeshWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
self.mesh = #<TuyaSmartBleMesh 实例>;
[self.mesh removeMeshWithSuccess:^{
    // success do...
} failure:^(NSError *error) {
    XCTFail(@"test remove mesh failure: %@", error);
}];
```

### 获取家庭下的 SIG Mesh 列表

通过初始化 `home` 实例后，可以拿到对应家庭下的 `mesh` 列表

|  参数           | 说明            |
| --------------- | ----------------|
| success         | 成功回调        |
| failure         | 失败回调        |

```objective-c
- (void)getSIGMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                          failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
TuyaSmartHome *home = #<home 实例>
[home getSIGMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
    // success do
} failure:^(NSError *error) {
    NSLog(@"get sig mesh list error: %@", error);
}];
```

### 获取 Mesh 实例

|  参数           | 说明            |
| --------------- | ----------------|
| meshId         | mesh id        |
| homeId         | 当前 home id        |

```objective-c
+ (instancetype)bleMeshWithMeshId:(NSString *)meshId homeId:(long long)homeId;
```

「代码示例」

通过家庭（`TuyaSmartHome` 实例）`home` 实例可以拿到类下的 `sigMeshModel`

```objective-c
TuyaSmartBleMeshModel *sigMeshModel = [self getCurrentHome].sigMeshModel;
```

## 配网与入网

> sig mesh 的操作类集中在 `TuyaSmartSIGMeshManager` 中，且此类为单例

配网指的是将处于重置状态、未入网的设备，添加到 sig mesh 网中

下面列举了常用设备的重置方式

| 产品类型 | 重置操作     | 可配网现象     |
| -------- | ------------ | -------------- |
| 灯       | 连续开关三次 | 灯快闪         |
| 插座     | 长按开关 3s  | 插座指示灯快闪 |

### 蓝牙扫描

扫描附近符合 SIG 标准的蓝牙设备

> ⚠️ 注意：这里的 meshModel 需要传入 TuyaSmartHome 中的 sigMeshModel 参数，而不是 meshModel


开始扫描设备

|  参数           | 说明            |
| --------------- | ----------------|
| scanType         | 扫描类型，目前分为未配网和已配网，已配网扫描到结果会自动入网        |
| meshModel         | mesh model 信息        |

```
- (void)startScanWithScanType:(TuyaSmartSIGScanType)scanType 
          meshModel:(TuyaSmartBleMeshModel *)meshModel;
```

「代码示例」

```objective-c
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
// ScanForUnprovision, // 扫描未配网设备
// ScanForProxyed, // 扫描已经配网的设备
[[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForUnprovision 
                            meshModel:home.sigMeshModel];
```



扫描到设备后，可在 `TuyaSmartSIGMeshManagerDelegate` 回调中实现以下方法，获取扫描到的设备。

 扫描到待配网的设备

|  参数           | 说明            |
| --------------- | ----------------|
| manager         | mesh manager        |
| device         | 待配网设备信息       |

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
     didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device;
```

### 子设备蓝牙配网

当扫描到周围有符合协议规范的待配网设备后，可以对这(些)进行配网

配网，就是把未加入到 mesh 网络的蓝牙设备通过一定的通讯过程将其加入到 mesh 网络中

- 激活设备

|  参数           | 说明            |
| --------------- | ----------------|
| devList         | 待激活设备列表        |
| meshModel         | mesh model 信息       |

  ```
  - (void)startActive:(NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)devList
        meshModel:(TuyaSmartBleMeshModel *)meshModel;
 ```

  > 激活设备过程是标准的蓝牙 Mesh 配网过程



- 激活回调
  
  当某一设备激活成功或者失败会通过 `TuyaSmartSIGMeshManagerDelegate` 回调以下方法：
  
  
  激活子设备成功回调

  |  参数           | 说明            |
  | --------------- | ----------------|
  | manager         | mesh manager        |
  | device         | 设备       |
  | devId         | 设备 Id       |
  | error         | 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空       |
  
  ```
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
      didActiveSubDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
                   devId:(NSString *)devId
                   error:(NSError *)error;
  
  ```
  
激活设备失败回调
|  参数           | 说明            |
| --------------- | ----------------|
| manager         | mesh manager        |
| device         | 设备       |
| error         |  激活中的错误      |

  ```
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
   didFailToActiveDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
           error:(NSError *)error;
  ```
  
  
  
- 停止激活设备

  在扫描设备和配网中任意阶段，调用以下方法，均会停止对蓝牙设备的配网流程

  ```objective-c
  - (void)stopActiveDevice;
  ```

### 子设备入网连接

入网还是先经过扫描，只不过把扫描的类型换成 `ScanForProxyed`，后续即可自动入网连接

- mesh 连接标识

  在操作的过程中，会经常判断是否是 mesh 已有设备通过蓝牙入网，来决定使用何种方式下发控制命令和操作命令

  ```objective-c
  // mesh 本地连接标识，有设备通过蓝牙连接，此属性为 yes
  BOOL isLogin = [TuyaSmartSIGMeshManager sharedInstance].isLogin;
  ```

### SIG Mesh 网关配网

SIG Mesh 网关配网为 EZ 配网，具体请参考 [ 快连模式（EZ配网）](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#快连模式（ez配网）)

SIG Mesh 网关激活子设备具体参考 [激活子设备](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#zigbee-子设备激活)

## Mesh 设备

> 和全屋 sdk 一样，设备类都是 `TuyaSmartDevice`，里面的 `TuyaSmartDeviceModel` 中的 `deviceType` 信息可以区分设备类型
>
> 这里 mesh 设备对应 `deviceType` 类型为 TuyaSmartDeviceModelTypeSIGMeshSubDev`

### 获取设备实例

|  参数           | 说明            |
| --------------- | ----------------|
| devId         | 设备Id        |

```objective-c
+ (instancetype)deviceWithDeviceId:(NSString *)devId;
```

### 本地连接和网关连接

sig mesh 设备的在线情况分为两种

- 本地连接

  手机蓝牙开启且 mesh 设备通过蓝牙进行连接控制，下发命令走蓝牙

  判断条件为: `deviceModel.isOnline && deviceModel.isMeshBleOnline`

- 网关连接

  手机蓝牙未开启或距离设备远， mesh 设备通过网关进行连接控制，下发命令走 Wi-Fi

  判断条件为: `deviceModel.isOnline && !deviceModel.isMeshBleOnline`

### 获取设备状态

|  参数           | 说明            |
| --------------- | ----------------|
| deviceModel         | 设备 model       |

```objective-c
- (void)getDeviceStatusWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel;
```

## 移除设备

移除设备简化了，所有的设备移除都保持一致，详细参考 [移除设备](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#修改设备名称)

## Mesh 群组

在蓝牙Mesh网中，可以将一些设备组成群组，使用群组命令控制群组中的设备，例如，将所有灯组添加到某个群组中，通过控制群组的开关、颜色等，直接控制群组中所有的灯具有相同的属性

> 具体的添加、删除流程图可以参考 [mesh 群组流程图](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Mesh.html#向群组内添加设备)

### 1. 添加群组

> 对于 SIG Mesh 群组的添加，为保证功能一致，建议同一品类的设备添加进群组

在添加群组前，需要从服务端获取群组地址：可以调用 `TuyaSmartBleMeshGroup` 的以下

向云端分配群组 Id

|  参数           | 说明            |
| --------------- | ----------------|
| meshId         | mesh id       |
| success         | 成功回调 localid 10 进制       |
| failure         | 失败回调       |

```objective-c
+ (void)getBleMeshGroupAddressFromCluondWithMeshId:(NSString *)meshId
                                           success:(TYSuccessInt)success
                                           failure:(TYFailureError)failure;
```



⚠️ 从服务端返回的群组地址需要加上  `0x4000` 之后，调用即可获得当前 sigMeshMode l下的一个已 groupName 命名的群组


创建mesh群组
|  参数           | 说明            |
| --------------- | ----------------|
| groupName         | mesh群组名字 |
| meshId         | meshId |
| localId         | 群组的本地短地址, 2 字节的 hex string |
| pcc         | 群组设备大小类 |
| success         | 成功回调 localid 10 进制       |
| failure         | 失败回调       |

```objective-c
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;
```



### 2.将设备加入群组

>   `groupAddress = [localId inValue] ` 

- 本地蓝牙方式

  如果需要将某个设备加入群组中，需要调用 `TuyaSmartSIGMeshManager` 以下方法

   把设备加入到群组
   |  参数           | 说明            |
   | --------------- | ----------------|
   | devId         | 设备 id |
   | groupAddress         | 群组地址 |

  ```objc
  - (void)addDeviceToGroupWithDevId:(NSString *)devId
                       groupAddress:(uint32_t)groupAddress;
  
  ```
  
  群组操作回调
  |  参数           | 说明            |
  | --------------- | ----------------|
  | manager         | manager|
  | groupAddress         |  群组 mesh 地址， 16 进制 |
  | nodeId         |  设备 mesh 节点地址，16 进制 |
  | error         |  错误 |
  
  ```
  
  //  TuyaSmartSIGMeshManagerDelegate 回调
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
  ```

- 网关方式

  通过网关向 mesh 群组内加子设备可以通过 `TuyaSmartBleMeshGroup` 进行操作

通过 sig mesh 网关添加 sig mesh 子设备群组
需要保证子设备的关系归属在在 sig mesh 网关下

|  参数           | 说明            |
| --------------- | ----------------|
| subList         | 待操作的网关下子设备|
| success         |  操作成功回调 |
| failure         |  操作失败回调 |

  ```objective-c
  - (void)addSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
  
```

TuyaSmartBleMeshGroupDelegate 回调

```
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>
  
  /// sig mesh 设备加入到网关的群组响应
  /// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
  /// Group Response of Zigbee Devices Joining Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group addResponseCode:(NSArray <NSNumber *> *)responseCode;
  
  @end
  ```

### 3. 将设备移除出群组

- 本地蓝牙方式

  若需要将某个设备移除出群组，可以使用以下方法：

    把设备从群组内移除
    |  参数           | 说明            |
    | --------------- | ----------------|
    | devId         | 设备 id |
    | groupAddress         |  群组地址 |

  ```objective-c
  - (void)deleteDeviceToGroupWithDevId:(NSString *)devId groupAddress:(uint32_t)groupAddress;
  
  ```
  
  TuyaSmartSIGMeshManagerDelegate 回调
  群组操作回调
  
  |  参数           | 说明            |
  | --------------- | ----------------|
  | manager         | manager |
  | groupAddress         |  群组 mesh 地址， 16 进制 |
  | nodeId         |  设备 mesh 节点地址，16 进制 |
  | error         |  错误|
  
  
  ```
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
  ```

- 网关方式

  通过网关向 mesh 群组内删除设备可以通过 `TuyaSmartBleMeshGroup` 进行操作
  
  通过 sig mesh 网关删除 sig mesh 子设备群组
  需要保证子设备的关系归属在在 sig mesh 网关下

  |  参数           | 说明            |
  | --------------- | ----------------|
  | subList         | 待操作的网关下子设备 |
  | success         |  操作成功回调|
  | failure         |  操作失败回调|

  ```objective-c
  - (void)removeSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
  ```
   
   TuyaSmartBleMeshGroupDelegate 回调
  
  ```
  
  //  TuyaSmartBleMeshGroupDelegate 回调
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>
  
  /// sig mesh 设备从网关群组移除响应
  /// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
  /// Group Response of Zigbee Devices removing Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group removeResponseCode:(NSArray <NSNumber *> *)responseCode;
    
  @end
  ```

### 4. 同步群组操作到云

若添加\删除成功或者失败，可以通过代理方法收到结果，同时使用 group 实例进行群组内设备关系变更云端同步


添加设备

|  类名           | 说明            |
| --------------- | ----------------|
| TuyaSmartBleMeshGroup         |  群组类|

```objective-c
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

删除设备
```
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

```

### 5. 查询群组内的设备

调用`TuyaSmartSIGMeshManager`以下方法，并配合回调（需固件支持）

通过群组地址查询群组中的设备

|  参数           | 说明            |
| --------------- | ----------------|
| groupAddress         | 群组地址 |

```objc
- (void)queryGroupMemberWithGroupAddress:(uint32_t)groupAddress;
```

回调：

```objc
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
      queryDeviceModel:(TuyaSmartDeviceModel *)deviceModel
          groupAddress:(uint32_t)groupAddress;
```



##  Mesh 控制

> mesh 指令下发是根据设备的 dp 信息来进行操作

### 指令发送格式

发送控制指令按照以下格式：`{"(dpId)" : "(dpValue)"}`， 如 `@{@"101" : @"44"}`

> Dp  指令可以参考 [设备管理DP点](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#更新设备信息)

### 指令下发控制

> 指令下发我们已作简化，不需要关注是网关连接、还是本地连接，只要在线就可以通过以下方法选择下发

- 控制单设备

  由于tuya中使用DP点管理设备的控制点，因此可以使用向设备发送DP点的方式对设备的功能进行控制。

dp命令下发

|  参数           | 说明            |
| --------------- | ----------------|
| dps         | dp dictionary |
| success         | Success block |
| failure         | Failure block |


  ```objc
  // TuyaSmartDevice 
  - (void)publishDps:(NSDictionary *)dps
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
  ```

- 控制群组

  ```objective-c
  // TuyaSmartBleMeshGroup
  - (void)publishDps:(NSDictionary *)dps success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
  ```



## 固件升级

### 设备升级固件信息查询

|  参数           | 说明            |
| --------------- | ----------------|
| success         | Success block |
| failure         | Failure block |

获取设备升级信息

```objective-c
// 通过 TuyaSmartDevice 实例进行查询
- (void)getFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(TYFailureError)failure;

/*
升级的信息会通过结果值返回，可以根据 type 信息去确定是否需要升级
     0  升级中
     1  无升级
     2  有强制或提醒升级
     3  有检测升级

// 判断为需要升级后，具体的固件地址在返回值中，下载之后转成固件 data 进行后续操作
*/
```

### 子设备升级

#### 1. 确认升级的设备在线情况

子设备升级都是通过蓝牙升级，所以需要判断设备是否处于本地连接，确认本地在线后再进行后续操作

```objective-c
// BOOL isBLEOnline = device.deviceModel.isMeshBleOnline;
```

#### 2. 告知 sdk 准备要升级的设备（每次都是 1v1 升级）

```objc
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
[[TuyaSmartSIGMeshManager sharedInstance] prepareForOTAWithTargetNodeId:self.device.deviceModel.nodeId];
```

#### 3. 等待待升级设备连接成功回调

```objective-c
// TuyaSmartSIGMeshManagerDelegate 

- (void)notifySIGLoginSuccess {
    [TuyaSmartSIGMeshManager sharedInstance].delegate = nil;
    //weakify(self);
    [[TuyaSmartSIGMeshManager sharedInstance] startSendOTAPack:_otaData targetVersion:_upgradeModel.version success:^{
        //strongify(self);
      // 更新版本号
        [self updateVersion];
    } failure:^{
        // log error
    }];
}
```

#### 4. 更新设备版本号

```objective-c
- (void)updateVersion {
    [self.device updateDeviceVersion:_upgradeModel.version type:_upgradeModel.type success:^{
        // ota success
    } failure:^(NSError *error) {
        // log error
    }];
}
```



### mesh 网关升级

mesh 网关升级和普通的设备升级一样，参考 [固件升级](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#固件升级)
