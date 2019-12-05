## Bluetooth Mesh SDK Guide

```objective-c
// import header file
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
```

### Introduction

Bluetooth Special Interest Group use bluetooth technology began to fully support Mesh networks. Bluetooth Mesh, that is, a Bluetooth device is formed into a network. Each Bluetooth device can communicate through Bluetooth devices in the network, and transmit Bluetooth information at one end to the other end through the mesh network.

The standard Bluetooth Mesh, also called SIG Mesh, is a communication standard for the Mesh network proposed by the Bluetooth Technology Alliance. The use of Bluetooth Mesh for networking and function point updates must meet the standards of standard Bluetooth Mesh

### Basic Notion


- pcc

  Each mesh device corresponds to a product, and each product has its own size class label. The SDK uses `pcc` and` type` as the size class label.

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

- mesh node Id， 2 bytes

  The node id is used to distinguish the "unique identifier" of each mesh device in the mesh network. For example, if you want to control a device, you can send the nodeId command corresponding to this device to the mesh network

- mesh group local Id，2 bytes

  The local Id is used to distinguish the `` unique identifier '' of each mesh group in the mesh network.For example, if you want to control the devices in a group, you can send the localId command corresponding to this group to the mesh network.

- Equipment operation requires multiple steps

  Because device operations, such as adding and deleting operations, and group operations, require the local Bluetooth command to be executed once and recorded in the cloud once. The operation information needs to be synchronized to the local mesh network as well.

- Local connection and gateway connection

  Local connection: The networked device is connected via Bluetooth to control mesh and command operations

  Gateway connection: The networked devices are connected through the gateway (the gateway needs to be with the device, and the distance cannot be too far) to control the mesh and command operations



### Management

>  `TuyaSmartBleMesh+SIGMesh.h` 

#### Create Mesh

A family can have multiple sig meshes (it is recommended to create only one family). All operations in the sig mesh are based on the family data being initialized.

> Init home [See](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management)

```objective-c
/**
 create sig mesh

 @param homeId homeId
 @param success success block
 @param failure failure block
 */
+ (void)createSIGMeshWithHomeId:(long long)homeId
                        success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                        failure:(TYFailureError)failure;
```

「Example」

```objective-c
TuyaSmartHome *home = #< home instance >;
long long homeId = home.homeModel.homeId;
[TuyaSmartBleMesh createSIGMeshWithHomeId:homeId success:^(TuyaSmartBleMeshModel *meshModel) {
    // success do...
} failure:^(NSError *error) {
    NSLog(@"create mesh error: %@", error);
}];
```

####  Delete Mesh

```
/**
 Delete the mesh. If there are devices in the mesh group, the child devices are also removed.

 @param success success block
 @param failure failure block
 */
- (void)removeMeshWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

「Example」

```objective-c
self.mesh = #<TuyaSmartBleMesh instance>;
[self.mesh removeMeshWithSuccess:^{
    // success do...
} failure:^(NSError *error) {
    XCTFail(@"test remove mesh failure: %@", error);
}];
```

#### Get the list of SIG Mesh in the family

After initializing the home instance, you can get the mesh list of the corresponding family

```objective-c
/**
 *  Get the list of SIG Mesh in the family
 *
 *  @param success success block
 *  @param failure failure block
 */
- (void)getSIGMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                          failure:(TYFailureError)failure;
```

「Example」

```objective-c
TuyaSmartHome *home = #<home instance>
[home getSIGMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
    // success do
} failure:^(NSError *error) {
    NSLog(@"get sig mesh list error: %@", error);
}];
```

#### Get Mesh instance

```objective-c
/**
 Get Mesh instance

 @param meshId mesh id
 @param homeId home id
 */
+ (instancetype)bleMeshWithMeshId:(NSString *)meshId homeId:(long long)homeId;
```

「Example」

The home instance (TuyaSmartHome instance) can get the sigMeshModel under the class

```objective-c
TuyaSmartBleMeshModel *sigMeshModel = [self getCurrentHome].sigMeshModel;
```

### Configuration

>  `TuyaSmartSIGMeshManager` 

The distribution network refers to adding devices that are in the reset state and not connected to the sig mesh network.

The following is a list of common device reset methods

| Product | reset                      | show            |
| ------- | -------------------------- | --------------- |
| Light   | Three consecutive switches | flashes quickly |
| Switch  | Long press 3s              | flashes quickly |

####Bluetooth Scan

Scan for nearby SIG-compliant Bluetooth devices

> ⚠️ Note: The meshModel here needs to be passed in the sigMeshModel parameter in TuyaSmartHome, not the meshModel

```
/**
 Start scan
 
 @param scanType Scanning type, currently divided into unconfigured network and configured network, the scanned network will automatically enter the network
 @param meshModel mesh model 
 */
- (void)startScanWithScanType:(TuyaSmartSIGScanType)scanType 
          meshModel:(TuyaSmartBleMeshModel *)meshModel;
```

「Example」

```objective-c
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
// ScanForUnprovision, // Scan for unconfigured devices
// ScanForProxyed, // Scan for devices that have been configured
[[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForUnprovision 
                            meshModel:home.sigMeshModel];
```



After scanning the device, you can implement the following methods in the TuyaSmartSIGMeshManagerDelegate callback to get the scanned device.

```objective-c
/**
 Scanning to devices to be configured
 
 @param manager mesh manager
 @param device Network equipment information to be allocated
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
     didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device;
```

#### Sub Device Bluetooth distribution network

After scanning the surrounding network devices that meet the protocol specifications, you can configure the network (s).

Networking is to add Bluetooth devices that have not joined the mesh network to the mesh network through a certain communication process.

* Active

  ```
  /**
   Start Active
   
   @param devList List of devices to be activated
   @param meshModel mesh model
   */
  - (void)startActive:(NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)devList
        meshModel:(TuyaSmartBleMeshModel *)meshModel;
  ```

* delegate

  When a device is activated successfully or fails, the following methods will be called back through TuyaSmartSIGMeshManagerDelegate:

  ```objc
  /**
   Activate child device successfully callback
   
   @param manager mesh manager
   @param device Device
   @param devId dev Id
   @param error active error，`name` or `deviceId` is empty
   */
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
      didActiveSubDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
                   devId:(NSString *)devId
                   error:(NSError *)error;
                   
  /**
   Activate child device failure callback

   @param manager mesh manager
   @param device 
   @param error errors 
   */
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
      didFailToActiveDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device 
           error:(NSError *)error;
  ```
  
* Deactivate device

  At any stage in the scanning device and network configuration, calling the following methods will stop the network configuration process for Bluetooth devices.

  ```objective-c

  - (void)stopActiveDevice;
  ```
#### Sub-device network connection

After entering the network, it is scanned first, but the scan type is changed to ScanForProxyed, and then the network can be automatically connected

* mesh connection flag

  In the process of operation, it is often judged whether the existing equipment of the mesh is connected to the network through Bluetooth to determine the method of issuing control commands and operation commands.

  ```objective-c
  // mesh local connection identifier, there is a device connected via Bluetooth, this attribute is yes
  BOOL isLogin = [TuyaSmartSIGMeshManager sharedInstance].isLogin;
  ```


#### SIG Mesh gateway active

SIG Mesh gateway active EZ , see [ EZ mode](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#activate-the-zigbee-sub-device)

SIG Mesh gateway atcive sub device, see [sub-device](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#activate-the-zigbee-sub-device)

### Mesh Device

> Like the Home SDK, the device class is TuyaSmartDevice. The deviceType information in TuyaSmartDeviceModel inside can distinguish the device type.
>
> Here the mesh device corresponds to the deviceType type TuyaSmartDeviceModelTypeSIGMeshSubDev

#### Get device instance

```objective-c
+ (instancetype)deviceWithDeviceId:(NSString *)devId;
```

#### Local connection and gateway connection

- Local connection

  The Bluetooth of the mobile phone is turned on and the mesh device is controlled by Bluetooth.

   `deviceModel.isOnline && deviceModel.isMeshBleOnline`

- gateway connection

  The mobile phone's Bluetooth is not turned on or is far away from the device. The mesh device controls the connection through the gateway and issues commands by Wi-Fi.

   `deviceModel.isOnline && !deviceModel.isMeshBleOnline`

#### Get device status
  ```
/**
 Get device status

 @param deviceModel device model
 */
- (void)getDeviceStatusWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel;
  ```

#### Remove Device

[See](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#remove-device)

### Mesh Group

In the Bluetooth Mesh network, you can group some devices into groups and use group commands to control the devices in the group. For example, you can add all light groups to a group, and control the group's switches, colors, etc. directly. All lights in the control group have the same properties

#### 1. Add Group

> For the addition of SIG Mesh groups, in order to ensure consistent functions, it is recommended to add devices of the same category to the group

Before adding a group, you need to get the group address from the server: You can call the following of TuyaSmartBleMeshGroup

```objective-c
/**
 Assign a group ID to the cloud

 @param meshId mesh id
 @param success localid 10 进制
 @param failure failure block
 */
+ (void)getBleMeshGroupAddressFromCluondWithMeshId:(NSString *)meshId
                                           success:(TYSuccessInt)success
                                           failure:(TYFailureError)failure;
```

⚠️ The group address returned from the server needs to be added with 0x4000, and then called to get a group named by groupName under the current sigMeshModel

```objective-c


/**
 create mesh group

 @param groupName mesh name
 @param meshId    meshId
 @param localId    2 bytes hex string
 @param pcc pcc
 @param success GroupId
 @param failure 
 */
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;
```



#### 2.Add device to group

>   `groupAddress = [localId inValue] ` 

* Local Bluetooth

  If you need to add a device to the group, you need to call the following method of `TuyaSmartSIGMeshManager`


  ```objc
  
  /**
   Add device to group
   
   @param devId dev id
   @param groupAddress 
   */
  - (void)addDeviceToGroupWithDevId:(NSString *)devId
                       groupAddress:(uint32_t)groupAddress;
  
  
  //  TuyaSmartSIGMeshManagerDelegate 
  /**
   group callback
   
   @param manager manager
   @param groupAddress group mesh address， 16 进制
   @param nodeId device mesh address，16 进制
   @param error 
   */
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
  ```

* Gateway

  Adding sub-devices to the mesh group through the gateway can be operated through TuyaSmartBleMeshGroup

  ```objective-c
  /**
   Adding a sig mesh sub-device group through a sig mesh gateway
    Need to ensure that the sub-device relationship belongs to the sig mesh gateway

   @param subList Sub-devices under the gateway to be operated
   @param success
   @param failure 
   */
  - (void)addSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

  //  TuyaSmartBleMeshGroupDelegate 
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>

  /// Group Response of Zigbee Devices Joining Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group addResponseCode:(NSArray <NSNumber *> *)responseCode;

  @end
  ```

#### 3. Remove device from group

* Local Bluetooth

  If you need to remove a device from the group, you can use the following methods:

  ```objective-c
  /**
   Remove device from group

   @param devId dev id
   @param groupAddress group address
   */
  - (void)deleteDeviceToGroupWithDevId:(NSString *)devId groupAddress:(uint32_t)groupAddress;

  //  TuyaSmartSIGMeshManagerDelegate 
  /**
   group callback
   
   @param manager manager
   @param groupAddress group mesh address， 16 进制
   @param nodeId group mesh address，16 进制
   @param error 
   */
  - (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager 
  didHandleGroupWithGroupAddress:(nonnull NSString *)groupAddress 
            deviceNodeId:(nonnull NSString *)nodeId 
               error:(NSError *)error;
  ```

* Gateway

  Deleting devices into the mesh group through the gateway can be operated through `TuyaSmartBleMeshGroup`

  ```objective-c
  /**
   Adding a sig mesh sub-device group through a sig mesh gateway
    Need to ensure that the sub-device relationship belongs to the sig mesh gateway

   @param subList Sub-devices under the gateway to be operated
   @param success 
   @param failure 
   */
  - (void)removeSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

  //  TuyaSmartBleMeshGroupDelegate callback
  @protocol TuyaSmartBleMeshGroupDelegate <NSObject>

  /// Group Response of Zigbee Devices removing Gateway
  /// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
  - (void)meshGroup:(TuyaSmartBleMeshGroup *)group removeResponseCode:(NSArray <NSNumber *> *)responseCode;
    
  @end
  ```

#### 4. Sync group info

If the add \ deletion succeeds or fails, you can receive the result through the proxy method, and use the group instance to change the cloud device synchronization within the group.

```objective-c
// TuyaSmartBleMeshGroup 

/**
 ADD device

 @param success 
 @param failure 
 */
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 Remove device

 @param success 
 @param failure 
 */
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

```

#### 5. Query Group Device

`TuyaSmartSIGMeshManager`

  ```objc
/**
 Query devices in a group by group address

 @param groupAddress group address
 */
- (void)queryGroupMemberWithGroupAddress:(uint32_t)groupAddress;
  ```


Callback：

  ```objc
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
      queryDeviceModel:(TuyaSmartDeviceModel *)deviceModel
          groupAddress:(uint32_t)groupAddress;
  ```

###  Mesh Control

#### DP publish

`{"(dpId)" : "(dpValue)"}`,  `@{@"101" : @"44"}`

* Control Device

  ```objc
  // TuyaSmartDevice 
  /**
   *  dp command publish.
   *
   *  @param dps     dp dictionary
   *  @param success Success block
   *  @param failure Failure block
   */
  - (void)publishDps:(NSDictionary *)dps
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
  ```

* Control Group

  ```objective-c
  // TuyaSmartBleMeshGroup

  - (void)publishDps:(NSDictionary *)dps success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
  ```



### Firmware Upgrade

#### Query firmware info

```objective-c
//  TuyaSmartDevice 
/**
 *  get device upgrade info
 *
 *  @param success 
 *  @param failure 
 */
- (void)getFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(TYFailureError)failure;

/*
type 
     0  updrading
     1  no upgrade
     2  force or remind upgrade
     3  check upgrade
*/
```

#### Sub-Device Upgrade

##### 1. Ensure device online

The sub-devices are upgraded through Bluetooth, so you need to determine whether the device is locally connected, and confirm the local online before performing subsequent operations.

```objective-c
// BOOL isBLEOnline = device.deviceModel.isMeshBleOnline;
```

##### 2. Tell sdk upgrade device node id

```objc
[TuyaSmartSIGMeshManager sharedInstance].delegate = self;
[[TuyaSmartSIGMeshManager sharedInstance] prepareForOTAWithTargetNodeId:self.device.deviceModel.nodeId];
```

##### 3. Wait device upgrade success callback

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

#####4. Update Device Version

```objective-c
- (void)updateVersion {
    [self.device updateDeviceVersion:_upgradeModel.version type:_upgradeModel.type success:^{
        // ota success
    } failure:^(NSError *error) {
        // log error
    }];
}
```



#### Mesh Gateway upgrade

See [firmware upgrade](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#firmware-upgrade)