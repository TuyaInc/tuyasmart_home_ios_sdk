# Bluetooth Mesh SDK Guide

## Introduction

Bluetooth Special Interest Group use bluetooth technology began to fully support Mesh networks. Bluetooth Mesh, that is, a Bluetooth device is formed into a network. Each Bluetooth device can communicate through Bluetooth devices in the network, and transmit Bluetooth information at one end to the other end through the mesh network.

The standard Bluetooth Mesh, also called SIG Mesh, is a communication standard for the Mesh network proposed by the Bluetooth Technology Alliance. The use of Bluetooth Mesh for networking and function point updates must meet the standards of standard Bluetooth Mesh

## Basic Notion

| Basic Notion           | Description                 |
| -------------- | ----------------     |
| pcc         | Each mesh device corresponds to a product, and each product has its own size class label. The SDK uses `pcc` and` type` as the size class label.          |
| mesh node Id         | 2 bytes. The node id is used to distinguish the "unique identifier" of each mesh device in the mesh network. For example, if you want to control a device, you can send the nodeId command corresponding to this device to the mesh network|
| mesh group local Id| 2 bytes. The local Id is used to distinguish the `` unique identifier '' of each mesh group in the mesh network.For example, if you want to control the devices in a group, you can send the localId command corresponding to this group to the mesh network.|
| Local connection| The networked device is connected via Bluetooth to control mesh and command operations|
| Gateway connection| The networked devices are connected through the gateway (the gateway needs to be with the device, and the distance cannot be too far) to control the mesh and command operations |

 The product currently follows the rules

| Type |                         Device Type                          |                         Product Type                         |                       Sub Product Type                       |
| :--: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|      | 1=Tuya's standard device<br />2=Tuya's penetrate device<br /> | 0x01=light <br />0x02=switch <br />0x05=remote control re<br /> | Like：<br /> 1= light <br /> 2= wc light<br /> 3= rgb light <br /> 4=<br /> |

ex. pcc（2 bytes，4 charac）

  ```objective-c
     Tuya's standard device rgb light   1310 // 1 01 4 read， 1 means device type，01 means product type, 4 means sub product type
     Tuya's standard device rgbwc light     1510
     ......
  ```

Equipment operation requires multiple steps

Because device operations, such as adding and deleting operations, and group operations, require the local Bluetooth command to be executed once and recorded in the cloud once. The operation information needs to be synchronized to the local mesh network as well.


## Management

>  `TuyaSmartBleMesh+SIGMesh.h` 

### Create Mesh

A family can have multiple sig meshes (it is recommended to create only one family). All operations in the sig mesh are based on the family data being initialized.

> Init home [See](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management)



**Declaration**

```objective-c
+ (void)createSIGMeshWithHomeId:(long long)homeId
                        success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                        failure:(TYFailureError)failure;
```

**Parameters**


| parameter           | Description                 |
| -------------- | ----------------     |
| homeId         | homeId          |
| success       | success block|
| failure       | failure block|

**Example**

```objective-c
TuyaSmartHome *home = #< home instance >;
long long homeId = home.homeModel.homeId;
[TuyaSmartBleMesh createSIGMeshWithHomeId:homeId success:^(TuyaSmartBleMeshModel *meshModel) {
    // success do...
} failure:^(NSError *error) {
    NSLog(@"create mesh error: %@", error);
}];
```

###  Delete Mesh

**Declaration**

Delete the mesh. If there are devices in the mesh group, the child devices are also removed.

```objective-c
- (void)removeMeshWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success       | success block|
| failure       | failure block|

**Example**

```objective-c
self.mesh = #<TuyaSmartBleMesh instance>;
[self.mesh removeMeshWithSuccess:^{
    // success do...
} failure:^(NSError *error) {
    XCTFail(@"test remove mesh failure: %@", error);
}];
```

#### Get the List of SIG Mesh in the Family

**Declaration**

After initializing the home instance, you can get the mesh list of the corresponding family

```objective-c
- (void)getSIGMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                          failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success       | success block|
| failure       | failure block|

**Example**

```objective-c
TuyaSmartHome *home = #<home instance>
[home getSIGMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
    // success do
} failure:^(NSError *error) {
    NSLog(@"get sig mesh list error: %@", error);
}];
```

### Get Mesh Instance

**Declaration**

```objective-c
+ (instancetype)bleMeshWithMeshId:(NSString *)meshId homeId:(long long)homeId;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| meshId       | mesh id|
| homeId       | home id|

**Example**

```objective-c
// The home instance (TuyaSmartHome instance) can get the sigMeshModel under the class
TuyaSmartBleMeshModel *sigMeshModel = [self getCurrentHome].sigMeshModel;
```

## Configuration

>  `TuyaSmartSIGMeshManager` 

The distribution network refers to adding devices that are in the reset state and not connected to the sig mesh network.

The following is a list of common device reset methods

| Product | reset                      | show            |
| ------- | -------------------------- | --------------- |
| Light   | Three consecutive switches | flashes quickly |
| Switch  | Long press 3s              | flashes quickly |

####Bluetooth Scan

**Declaration**

Scan for nearby SIG-compliant Bluetooth devices

> The meshModel here needs to be passed in the sigMeshModel parameter in TuyaSmartHome, not the meshModel

```objective-c
- (void)startScanWithScanType:(TuyaSmartSIGScanType)scanType 
          meshModel:(TuyaSmartBleMeshModel *)meshModel;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| scanType       | Scanning type, currently divided into unconfigured network and configured network, the scanned network will automatically enter the network|
| meshModel       | mesh model|

**Example**

```objective-c
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
// ScanForUnprovision, // Scan for unconfigured devices
// ScanForProxyed, // Scan for devices that have been configured
[[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForUnprovision 
                            meshModel:home.sigMeshModel];
```

**Declaration**

After scanning the device, you can implement the following methods in the TuyaSmartSIGMeshManagerDelegate callback to get the scanned device.

```objective-c
/**
 Scanning to devices to be configured
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
     didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device;
```

**Parameters**


| parameter           | Description                 |
| -------------- | ----------------     |
| manager       | mesh manager|
| device       | Network equipment information to be allocated|

**Sub Device Bluetooth distribution network**

After scanning the surrounding network devices that meet the protocol specifications, you can configure the network (s).

Networking is to add Bluetooth devices that have not joined the mesh network to the mesh network through a certain communication process.

#### Active

**Declaration**

```objective-c
- (void)startActive:(NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)devList
          meshModel:(TuyaSmartBleMeshModel *)meshModel;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| devList       | List of devices to be activated|
| meshModel       | mesh model|

**delegate**

**Declaration**

When a device is activated successfully or fails, the following methods will be called back through TuyaSmartSIGMeshManagerDelegate: Activate child device successfully callback

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
    didActiveSubDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
                 devId:(NSString *)devId
                 error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| manager       | mesh manager|
| device       | Device|
| devId       | dev Id|
| error       | active error，`name` or `deviceId` is empty|



**Declaration**

 Activate child device failure callback

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
 didFailToActiveDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
                 error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| manager       | mesh manager|
| device       | Device|
| error       | errors|

#### Deactivate Device

**Declaration**

At any stage in the scanning device and network configuration, calling the following methods will stop the network configuration process for Bluetooth devices.

```objective-c
- (void)stopActiveDevice;
```

### Sub-Device Network Connection

After entering the network, it is scanned first, but the scan type is changed to ScanForProxyed, and then the network can be automatically connected

#### Mesh Connection Flag

In the process of operation, it is often judged whether the existing equipment of the mesh is connected to the network through Bluetooth to determine the method of issuing control commands and operation commands.

```objective-c
// mesh local connection identifier, there is a device connected via Bluetooth, this attribute is yes
BOOL isLogin = [TuyaSmartSIGMeshManager sharedInstance].isLogin;
```


### SIG Mesh Gateway Active

SIG Mesh gateway active EZ , see [ EZ mode](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#activate-the-zigbee-sub-device)

SIG Mesh gateway atcive sub device, see [sub-device](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#activate-the-zigbee-sub-device)

## Mesh Device

> Like the Home SDK, the device class is TuyaSmartDevice. The deviceType information in TuyaSmartDeviceModel inside can distinguish the device type.
>
> Here the mesh device corresponds to the deviceType type TuyaSmartDeviceModelTypeSIGMeshSubDev

#### Get Device Instance

```objective-c
+ (instancetype)deviceWithDeviceId:(NSString *)devId;
```

### Local Connection and Gateway Connection

#### Local Connection

The Bluetooth of the mobile phone is turned on and the mesh device is controlled by Bluetooth.

 `deviceModel.isOnline && deviceModel.isMeshBleOnline`

#### Gateway Connection

The mobile phone's Bluetooth is not turned on or is far away from the device. The mesh device controls the connection through the gateway and issues commands by Wi-Fi.

 `deviceModel.isOnline && !deviceModel.isMeshBleOnline`

### Get Device Status

**Declaration**

```objective-c
- (void)getDeviceStatusWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| deviceModel       | device model|

### Remove Device

[See](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#remove-device)

## Mesh Group

In the Bluetooth Mesh network, you can group some devices into groups and use group commands to control the devices in the group. For example, you can add all light groups to a group, and control the group's switches, colors, etc. directly. All lights in the control group have the same properties

### Add Group

> For the addition of SIG Mesh groups, in order to ensure consistent functions, it is recommended to add devices of the same category to the group

Before adding a group, you need to get the group address from the server: You can call the following of TuyaSmartBleMeshGroup

**Declaration**

Assign a group ID to the cloud

```objective-c
+ (void)getBleMeshGroupAddressFromCluondWithMeshId:(NSString *)meshId
                                           success:(TYSuccessInt)success
                                           failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| meshId       | mesh id|
| success       | success block|
| failure       | failure block|

**Declaration**

The group address returned from the server needs to be added with 0x4000, and then called to get a group named by groupName under the current sigMeshModel

```objective-c
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| groupName       | mesh group name|
| meshId       | meshId|
| localId       | 2 bytes hex string|
| pcc       | pcc|
| success       | success block , groupId|
| failure       | failure|

### Add Device to Group

>   `groupAddress = [localId inValue] ` 

#### Bluetooth

If you need to add a device to the group, you need to call the following method of `TuyaSmartSIGMeshManager`

**Declaration**

```objective-c
- (void)addDeviceToGroupWithDevId:(NSString *)devId
                     groupAddress:(uint32_t)groupAddress;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| devId       | dev id|
| groupAddress       | group address |

**TuyaSmartSIGMeshManagerDelegate**

**Declaration**

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| manager       | manager|
| groupAddress       | group mesh address |
| nodeId       | device mesh address |
| error       | error |



#### Gateway

Adding sub-devices to the mesh group through the gateway can be operated through 

**Declaration**

```objective-c
  /**
   Adding a sig mesh sub-device group through a sig mesh gateway
    Need to ensure that the sub-device relationship belongs to the sig mesh gateway
   */
  - (void)addSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

  //  TuyaSmartBleMeshGroupDelegate 
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>

  /// Group Response of Zigbee Devices Joining Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group addResponseCode:(NSArray <NSNumber *> *)responseCode;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| subList       | Sub-devices under the gateway to be operated|
| success       | success block |
| failure       | failure block |



### Remove Device From Group

#### Bluetooth

**Declaration**

If you need to remove a device from the group, you can use the following methods:

```objective-c
- (void)deleteDeviceToGroupWithDevId:(NSString *)devId groupAddress:(uint32_t)groupAddress;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| devId       | dev id|
| groupAddress       | group address |

**TuyaSmartSIGMeshManagerDelegate**

**Declaration**

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| manager       | manager|
| groupAddress       | group mesh address |
| nodeId       | device mesh address |
| error       | error |

####Gateway

Deleting devices into the mesh group through the gateway can be operated through `TuyaSmartBleMeshGroup`

**Declaration**

```objective-c
  /**
   Adding a sig mesh sub-device group through a sig mesh gateway
    Need to ensure that the sub-device relationship belongs to the sig mesh gateway
   */
- (void)removeSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| subList       | Sub-devices under the gateway to be operated|
| success       | success block |
| failure       | failure block |

**TuyaSmartBleMeshGroupDelegate**

```objective-c
  //  TuyaSmartBleMeshGroupDelegate callback
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>

  /// Group Response of Zigbee Devices removing Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group removeResponseCode:(NSArray <NSNumber *> *)responseCode;
    
  @end
```



### Sync Group Info

If the add \ deletion succeeds or fails, you can receive the result through the proxy method, and use the group instance to change the cloud device synchronization within the group.

#### Add Device

**Declaration**

```objective-c
// TuyaSmartBleMeshGroup 
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success       | success block |
| failure       | failure block |



#### Remove Device

**Declaration**

```objective-c
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success       | success block |
| failure       | failure block |



### Query Group Device

**Declaration**

Query devices in a group by group address

```objective-c
- (void)queryGroupMemberWithGroupAddress:(uint32_t)groupAddress;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| groupAddress       | group address |

**Callback**

**Declaration**

```objective-c
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
      queryDeviceModel:(TuyaSmartDeviceModel *)deviceModel
          groupAddress:(uint32_t)groupAddress;
```

##  Mesh Control

### DP Publish

`{"(dpId)" : "(dpValue)"}`,  `@{@"101" : @"44"}`

#### Device Control

**Declaration**

```objective-c
// TuyaSmartDevice 
- (void)publishDps:(NSDictionary *)dps
           success:(nullable TYSuccessHandler)success
           failure:(nullable TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| dps       | dp dictionary |
| success       | success block |
| failure       | failure block |

#### Group Control

**Declaration**

```objective-c
// TuyaSmartBleMeshGroup

- (void)publishDps:(NSDictionary *)dps success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

## Firmware Upgrade

### Query Firmware Info

**Declaration**

```objective-c
//  TuyaSmartDevice 
- (void)getFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(TYFailureError)failure;

/*
type 
     0  updrading
     1  no upgrade
     2  force or remind upgrade
     3  check upgrade
*/
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success       | success block |
| failure       | failure block |



### Sub-Device Upgrade

#### Ensure Device Online

The sub-devices are upgraded through Bluetooth, so you need to determine whether the device is locally connected, and confirm the local online before performing subsequent operations.

```objective-c
// BOOL isBLEOnline = device.deviceModel.isMeshBleOnline;
```

#### Tell SDK Upgrade Device Node Id

```objc
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
[[TuyaSmartSIGMeshManager sharedInstance] prepareForOTAWithTargetNodeId:self.device.deviceModel.nodeId];
```

#### Wait Device Upgrade Success Callback

```objective-c
// TuyaSmartSIGMeshManagerDelegate 

- (void)notifySIGLoginSuccess {
    [TuyaSmartSIGMeshManager sharedInstance].delegate = nil;
    //weakify(self);
    [[TuyaSmartSIGMeshManager sharedInstance] startSendOTAPack:_otaData targetVersion:_upgradeModel.version success:^{
        //strongify(self);
      // update version
        [self updateVersion];
    } failure:^{
        // log error
    }];
}
```

#### Update Device Version

```objective-c
- (void)updateVersion {
    [self.device updateDeviceVersion:_upgradeModel.version type:_upgradeModel.type success:^{
        // ota success
    } failure:^(NSError *error) {
        // log error
    }];
}
```



### Mesh Gateway upgrade

See [firmware upgrade](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#firmware-upgrade)
