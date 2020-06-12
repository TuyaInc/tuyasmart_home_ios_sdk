# Bluetooth Mesh(TUYA)

Generally speaking, Bluetooth mesh is to form a mesh network with multiple Bluetooth single-point devices. Each node can communicate with other nodes freely. By directly connecting to any device in the mesh network via mobile phone **, you can access and control the mesh network All equipment **

| Class name                 | Description                  |
| --------------                | ----------------              |
| TYBLEMeshManager | Bluetooth Mesh Class  |


## Prepare


Tuya iOS Single BLE SDK （ Hereinafter referred to as BLE SDK or Single BLE SDK ），is developed on the basis of [TuyaSmart SDK](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/)


  ```objective-c

  // set sdk open mesh, need to be set during initialization
  [[TuyaSmartSDK sharedInstance] setValue:@(YES) forKey:@"bleMeshEnable"]; 
  ```


## Basic Notion


| Basic Notion                 | Description                  |
| --------------                | ----------------              |
| pcc | Each mesh device corresponds to a product, and each product has its own size class label. The SDK uses pcc andtype as the size class label.  |
|mesh node Id|   The node id is used to distinguish the "unique identifier" of each mesh device in the mesh network. For example, if you want to control a device, you can send the nodeId command corresponding to this device to the mesh network|
| mesh group local Id|The local Id is used to distinguish the `` unique identifier '' of each mesh group in the mesh network.For example, if you want to control the devices in a group, you can send the localId command corresponding to this group to the mesh network.|
|Local Connection| The networked device is connected via Bluetooth to control mesh and command operations|
|Gateway Connection|The networked devices are connected through the gateway (the gateway needs to be with the device, and the distance cannot be too far) to control the mesh and command operations. |


  Mesh product type

  ```objective-c
    light(01): 1-5  RGBWC 
    switch(02): 1-6 
    sensor(04): 
    Actuator(10): Alarm
    adapter(08): gateway（
  ```

  sub product type

  ```objective-c
    1-5 light（01-05）
    1-6 swicth（01-06)
    .....
  ```

  pcc example

  ```objective-c
     rgb light   0301
     rgbwc light 0501
     5 switch    0502
     gateway     0108
     ......
  ```

**Equipment operation requires multiple steps**

Because device operations, such as adding and deleting operations, and group operations, require the local Bluetooth command to be executed once and recorded in the cloud once. The operation information needs to be synchronized to the local mesh network as well.

## Management

> `TuyaSmartBleMesh.h`

### Create Mesh

A family can have multiple sig meshes (it is recommended to create only one family). All operations in the sig mesh are based on the family data being initialized.

> Init home [See](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management)

**Declaration**

```objective-c
+ (void)createBleMeshWithMeshName:(NSString *)meshName
                           homeId:(long long)homeId
                          success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                          failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| meshName       | mesh name|
| homeId         | homeId          |
| success        | success block         |
| failure        | failure block         |

**Example**

```objective-c
TuyaSmartHome *home = #< home instance>;
long long homeId = home.homeModel.homeId;
[TuyaSmartBleMesh createBleMeshWithMeshName:@"yourMeshName" homeId:homeId success:^(TuyaSmartBleMeshModel *meshModel) {
    // success do...
} failure:^(NSError *error) {
    NSLog(@"create mesh error: %@", error);
}];
```

>The meshName of this method is custom, and it is recommended to set it with unique parameters, such as "mesh + timestamp form"



### Delete Mesh

**Declaration**

Delete the mesh. If there are devices in the mesh group, the child devices are also removed. The Wi-Fi connector was also removed.

```objective-c
- (void)removeMeshWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success        | success block         |
| failure        | failure block         |

**Example**

```objective-c
self.mesh = #<TuyaSmartBleMesh instance>;
[self.mesh removeMeshWithSuccess:^{
    // success do...
} failure:^(NSError *error) {
    XCTFail(@"test remove mesh failure: %@", error);
}];
```

### Get The List Of Mesh In The Family

After initializing the home instance, you can get the mesh list of the corresponding family

Get the list of meshes under the family

**Declaration**

```objective-c
- (void)getMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                       failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| success        | success block         |
| failure        | failure block         |

**Example**

```objective-c
TuyaSmartHome *home = #<home instance>
[home getMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
	// success do
} failure:^(NSError *error) {
	NSLog(@"get mesh list error: %@", error);
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
| meshId        | mesh id         |
| homeId        | home id         |

**Example**

Through the family (TuyaSmartHome instance), home can get the meshModel under the class, which can be created through this, and after the creation is completed, it is assigned to the current TuyaSmartUser, and the SDK and upper layers take the value of TuyaSmartUser as the judgment criterion:

```objective-c

if ([TuyaSmartUser sharedInstance].meshModel == nil) {
    TuyaSmartHome *home = #<home instance>
    [home getMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
            if (list.count > 0) {
              
                [TuyaSmartUser sharedInstance].meshModel = home.meshModel;
                [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:home.meshModel.meshId homeId:home.meshModel.homeId];
                
   
            } else {
              
                NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                NSString *meshName = [NSString stringWithFormat:@"tymesh%.0f", interval];
                
                [TuyaSmartBleMesh createBleMeshWithMeshName:meshName homeId:home.homeModel.homeId success:^(TuyaSmartBleMeshModel *meshModel) {
            
                    [TuyaSmartUser sharedInstance].meshModel = meshModel;
                    [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:meshModel.meshId homeId:home.homeModel.homeId];
                         
                
                } failure:^(NSError *error) {
            
                }];
            }
        } failure:^(NSError *error) {
          
        }];
} else {
    
}

```


###  Mesh Sub-devices's Connect

Network access is the operation of connecting to the mesh network through a networked device. This process requires Bluetooth to be turned on.

If the operation is distribution network, fill in the default mesh name and password. At this time, it will only pass the `TYBLEMeshManagerDelegate`
`- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 

If the operation is to enter the network, fill in the created mesh name and password. This information is returned from the cloud interface. It can automatically connect, enter the network, and automatically obtain the online status of each device in the mesh network.

**Declaration**

mesh start

```objective-c
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| name        | mesh name |
| pwd        | mesh password |
| active        | is active |
| wifiAddress        |Wi-Fi address, required for gateway network configuration, the rest is 0 |
| otaAddress        |ota device address, required for ota upgrade, the rest is 0 |

**Declaration**

Successful network access will automatically obtain the online status of the devices in the mesh network and trigger the `TuyaSmartHomeDelegate` delegate method to call back information

```objective-c
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device;
```

**Example**

```objective-c

[[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:0];

- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    // callback
}
```


## Activation   

>  `TYBLEMeshManager` 

The distribution network refers to adding devices that are in the reset state and not connected to the sig mesh network.

The following is a list of common device reset methods

###  Device Reset

| Product | reset                      | show            |
| ------- | -------------------------- | --------------- |
| Light   | Three consecutive switches | flashes quickly |
| Switch  | Long press 3s              | flashes quickly |
| Gateway | Long press 3s              | flashes quickly |

The device in the reset state, the default name is `out_of_mesh`, and the default password is `123456`



### Scan Mesh Device

> In order to simplify scanning and subsequent distribution operations, all operations are unified into one interface.

If the operation is distribution network, fill in the default mesh name and password. At this time, it will only pass the `TYBLEMeshManagerDelegate`
`- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 

If the operation is to enter the network, fill in the created mesh name and password. This information is returned from the cloud interface. It can automatically connect, enter the network, and automatically obtain the online status of each device in the mesh network.

**Declaration**

```objective-c
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| name        | mesh name         |
| pwd        | mesh password         |
| wifiAddress        | Wi-Fi address, required for gateway network configuration, the rest is 0         |
| otaAddress        | ota device address, required for ota upgrade, the rest is 0         |



If the name passed in is the default value out_of_mesh, and it is an activation operation, it will scan the surrounding devices to be configured, and the result of the scan will be called back by the method in TYBLEMeshManagerDelegate

**Declaration**

```objective-c
/**
 Scanning to devices to be configured
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;
```

**Parameters**


| parameter           | Description                 |
| -------------- | ----------------     |
| manager        | mesh manager         |
| device        | un active devices         |

If it is a network access operation, subsequent operations will be performed automatically without callback.

**Example**

```objective-c
// start scan
[[TYBLEMeshManager sharedInstance] startScanWithName:@"out_of_mesh" pwd:@"123456" active:YES wifiAddress:0 otaAddress:0];

// TYBLEMeshManagerDelegate 
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device {
   
    // The scanned gateway devices and sub-devices will be called back by this method
    // Use device.type and device.vendorInfo to determine if it is a mesh gateway
    if (device.type == [TPUtils getIntValueByHex:@"0x0108"] || ([TPUtils getIntValueByHex:[device.vendorInfo substringWithRange:NSMakeRange(0, 2)]] & 0x08) == 0x08) {
      	// mesh gateway
        return;
    } else {
        // mesh sub node device 
    }
}

// getIntValueByHex
+ (uint32_t)getIntValueByHex:(NSString *)getStr
{
    NSScanner *tempScaner=[[NSScanner alloc] initWithString:getStr];
    uint32_t tempValue;
    [tempScaner scanHexInt:&tempValue];
    return tempValue;
}

```



### Active Mesh Device By Bluetooth

Mesh distribution networks are mainly divided into two types. One is for ordinary Bluetooth mesh devices (also called mesh sub-devices), such as lights, sockets, and low power consumption. It can be understood that as long as there is no gateway, it is an ordinary Bluetooth device. Networking for mesh gateways

**Declaration**

```objective-c
- (void)activeMeshDeviceIncludeGateway:(BOOL)includeGateway;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| includeGateway        | Whether to activate the gateway. If it is `yes', the gateway device that has been recorded in the device will be activated, and the remaining sub-devices will not be activated   Conversely activate all scanned ordinary mesh sub-devices, do not activate the gateway      |

**Declaration**

```objective-c
/**
 Activate specific devices
 */
- (void)activeMeshDevice:(TYBleMeshDeviceModel *)deviceModel;
```

**Parameters**


| parameter           | Description                 |
| -------------- | ----------------     |
| deviceModel        | model |
 The distribution result will be called back through `TYBLEMeshManagerDelegate`

**Declaration**

```objective-c
/**
 Activate sub device callback 
 */
- (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| name        | device name |
| deviceId        | dev Id |
| error        | error |

Activate gateway device callback

**Declaration**

```objective-c
- (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| name        | device name |
| address        | device address |
| error        | error |

### Active Mesh Gateway Device

If the gateway device is activated, you need to configure the network with the Wi-Fi module after receiving the callback `activeWifiDeviceWithName` method. At this time, you need to call the method in `TuyaSmartActivator` to perform the operation.

#### Get Token

**Declaration**

mesh Wi-Fi gateway join mesh
get Token（10 minutes)

```objective-c
- (void)getTokenWithMeshId:(NSString *)meshI- (void)getTokenWithMeshId:(NSString *)meshI我- (void)getTokenWithMeshId:(NSString *)meshI- (void)getTokenWithMeshId:(NSString *)meshI我d
                    nodeId:(NSString *)nodeId
                 productId:(NSString *)productId
                      uuid:(NSString *)uuid
                   authKey:(NSString *)authKey
                   version:(NSString *)version
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;
```

#### Active Gateway

**Declaration**

Gateway, router account, and password for gateway access

After activating the gateway, you can call this method after receiving the `activeWifiDeviceWithName` of `TYBLEMeshManagerDelegate`

```objective-c
- (void)startBleMeshConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;
```

**Parameters**

| parameter           | Description                 |
| -------------- | ----------------     |
| ssid        | Wi-Fi ssid |
| password        | Wi-Fi password |
| token        | Token |
| timeout        | default 100s |


**Example**

Mesh sub-devices (devices without gateways) are connected to the network

```objective-c
// 1. Activate sub device/ 1. Activate sub w
[[TYBLEMeshManager sharedInstance] activeMeshDeviceIncludeGateway:NO];

// 2. TYBLEMeshManagerDelegate 
- (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error {
    
    if (error) {
        NSLog(@"error : %@", error);
        return;
    }
    
    // 3. Activation was successful. At this point, the activation of a sub device is complete.
}

```

```objective-c
// 1. Activate sub device
[[TYBLEMeshManager sharedInstance] activeMeshDeviceIncludeGateway:NO];

// 2. TYBLEMeshManagerDelegate 
- (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error {
    if (error) {
       NSLog(@"error : %@", error);
       return;
    }
    
    // The gateway was successfully activated. Currently, only the Bluetooth module is successful. You need to continue to configure the Wi-Fi module to activate.
    // 3. The user enters the password and then reconnects, and then resends the ssid, pwd, token,
    // ！！！！Note that this operation must be done, otherwise it will affect the writing of Wi-Fi information and cause the distribution network to fail.
    [TYBLEMeshManager sharedInstance].wifiMac = (int)mac;
    
    // 4. get token
    NSString *nodeId = [NSString stringWithFormat:@"%02x", (int)address];
    [[TuyaSmartActivator sharedInstance] getTokenWithMeshId:[TuyaSmartUser sharedInstance].meshModel.meshId
                                                 nodeId:nodeId
                                              productId:[TYBLEMeshManager sharedInstance].productId
                                                   uuid:[TYBLEMeshManager sharedInstance].uuid
                                                authKey:[TYBLEMeshManager sharedInstance].authKey
                                                version:[TYBLEMeshManager sharedInstance].version
                                                success:^(NSString *token) {
                                                    // 5. Set up a network distribution agent and receive activation results through the agent
                                                    [TuyaSmartActivator sharedInstance].delegate = self;
                                                    // 6. start Wi-Fi config
                                                    [[TuyaSmartActivator sharedInstance] startBleMeshConfigWiFiWithSsid:@"Wi-Fi ssid" password:@"Wi-Fi password" token:token timeout:100];
                                                } failure:^(NSError *error) {
                                                    NSLog(@"error: %@", error);
                                                }];
}

- (void)meshActivator:(TuyaSmartActivator *)activator didReceiveDeviceId:(NSString *)deviceId meshId:(NSString *)meshId error:(NSError *)error {
      // 7. Receive activation result
      
  }
```


#### Mesh Connection Flag

In the process of operation, it is often judged whether the existing equipment of the mesh is connected to the network through Bluetooth to determine the method of issuing control commands and operation commands.

```objective-c
BOOL isLogin = [TYBLEMeshManager sharedInstance].isLogin;
```
### Error Code

|  Error Code           | Description                      |
| --------------- | --------------------------|
| 3088            | Active device failed            |
| 3090        | wrong mesh name or password             |
| 3091           | login failed                 |
| 3092         | login decode failed     |
| 3093         | fetch auth key failed     |
| 3094         | address beyond limit      |
| 3095         | update address failed     |
| 3096         | input mesh description failed     |
| 3097         | mesh description is empty    |
| 3098         | device has out in mesh      |
| 3099         | write failed     |
| 4000         | wrong Wi-Fi decription     |
| 4001         | wrong Wi-Fi token    |
| 4010         | login timeout     |
| 4011         | fetch auth key timeout     |
| 4012         | update address timeout     |
| 4013         | input mesh description timeout     |
| 4014         | input Wi-Fi description timeout         |



## Device

> Like the Home SDK, the device class is TuyaSmartDevice. The deviceType information in TuyaSmartDeviceModel inside can distinguish the device type.
>
> Here the mesh device corresponds to the deviceType type TuyaSmartDeviceModelTypeMeshBleSubDev


### Rename Device

**Declaration**

```objective-c
- (void)renameMeshSubDeviceWithDeviceId:(NSString *)deviceId name:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| deviceId        | dev id |
| name        | new name |
| success        | success block |
| failure        | failure block |


**Example**

```objective-c
[[TuyaSmartUser sharedInstance].mesh renameMeshSubDeviceWithDeviceId:self.device.devId name:name success:^{
            // success do
        } failure:^(NSError *error) {
            // failure do
        }];
```

### Local Connection and Gateway Connection

**Local connection**

The Bluetooth of the mobile phone is turned on and the mesh device is controlled by Bluetooth.

 `deviceModel.isOnline && deviceModel.isMeshBleOnline`

**Gateway connection**

The mobile phone's Bluetooth is not turned on or is far away from the device. The mesh device controls the connection through the gateway and issues commands by Wi-Fi.

 `deviceModel.isOnline && !deviceModel.isMeshBleOnline`


### Remove Device

Remove device requires cloud delete, local delete

#### Local Remove

**Declaration**

```objective-c
// use ble
- (void)kickoutLightWithAddress:(uint32_t)address type:(NSString *)type;

// use gateway
- (NSString *)rawDataKickoutLightWithAddress:(uint32_t)address type:(NSString *)type;

- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;
```

  

#### Remote Remove

**Declaration**

```objective-c
- (void)removeMeshSubDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Example**

```objective-c
 int address = [smartDevice.deviceModel.nodeId intValue] << 8;
        
        // 1.  remote remove
        [[TuyaSmartUser sharedInstance].mesh removeMeshSubDeviceWithDeviceId:[smartDevice.deviceModel.devId success:^{
            
        } failure:^(NSError *error) {
           
        }];
        
        // 2. local remove
        // Judge the connection, use gateway or Bluetooth

        if ([TYBLEMeshManager sharedInstance].isLogin) {
            
            [[TYBLEMeshManager sharedInstance] kickoutLightWithAddress:address type:[smartDevice.deviceModel.pcc];
             
        } else {
            
            [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataKickoutLightWithAddress:address type:[smartDevice.deviceModel.pcc] pcc:[smartDevice.deviceModel.pcc success:^{
                
            } failure:^(NSError *error) {
                
            }];
        }
```


### Query Mesh Device Status

```objective-c
- (void)getDeviceStatusAllWithAddress:(uint32_t)address
                                 type:(NSString *)type;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| address        | mesh device address |
| type        | type |


## Group

A group is one of the features of a mesh. After adding devices to the group, you can control all the devices in the group with one command.

### Create Group

> When creating the group address, the local Id starts from 0x8001, and is superimposed in order.
>
> The size of the group is the same as that of the device. Incoming means that this group agrees that such devices are organized into a group.
>
> Note: If other categories are forcibly added, control may fail due to different dp

Currently, each mesh supports a maximum of 255 groups, and a device can only join a maximum of 8 groups.

**Declaration**

```objective-c
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| groupName        | group name |
| meshId        | meshId |
| localId        | group address |
| pcc        | pcc |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c

NSInteger localId = 0x8001;
[TuyaSmartBleMeshGroup createMeshGroupWithGroupName:@<group name> meshId:[TuyaSmartUser sharedInstance].meshModel.meshId localId:[NSString stringWithFormat:@"%lx", localId] pcc:#<pcc> success:^(int result) {
     // success do
     self.meshGroup = [TuyaSmartBleMeshGroup meshGroupWithGroupId:result];
       
    } failure:^(NSError *error) {
       // failure do
    }];
```


### Add Device to Group

> Adding a device to a group requires local and cloud double verification before it can be counted as a device successfully joining the group. Results
>
> Operations are performed one by one by the device and performed sequentially. Not concurrent

Local add

```objective-c
// Local connection
- (void)addDeviceAddress:(uint32_t)deviceAddress type:(NSString *)type groupAddress:(uint32_t)groupAddress;

// TYBLEMeshManagerDelegate
- (void)deviceAddGroupAddress:(uint32_t)address error:(NSError *)error;



// Gateway connection

- (NSString *)rawDataAddDeviceAddress:(uint32_t)deviceAddress groupAddress:(uint32_t)groupAddress type:(NSString *)type;

- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;

// TuyaSmartBleMeshDelegate 
- (void)bleMeshReceiveRawData:(NSString *)raw;
```

Remote add

**Declaration**

After the above verification is completed, you can use this method to record the operation to the cloud and then proceed to the next device operation

```objective-c
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c
- (void)addDeviceToGroup:(TuyaSmartDeviceModel *)model {
        int nodeId = [model.nodeId intValue] << 8;
        // ...
        _address = nodeId >> 8;
    
        if ([TYBLEMeshManager sharedInstance].isLogin) {
            // ble
            [[TYBLEMeshManager sharedInstance] addDeviceAddress:nodeId type:self.meshGroup.meshGroupModel.pcc groupAddress:[self.meshGroup.meshGroupModel.localId intValue]];
        } else {
            // Wi-Fi
            [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataAddDeviceAddress:nodeId groupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc] pcc:self.meshGroup.meshGroupModel.pcc success:^{
            } failure:^(NSError *error) {
            }];
        }

        // add flag
        _isAdd = YES;
    
    // Here you can do the timeout yourself. It is recommended to fail if it is not received within 5s, and execute the next one.
}


#pragma mark - TYBLEMeshManagerDelegate
- (void)deviceAddGroupAddress:(uint32_t)address; {
    NSLog(@" --- deviceAddGroupAddress %d ", address);
    
    if (_address == address) {
        
            [self.meshGroup addDeviceWithDeviceId:_devId success:^{
                // success, next
            } failure:^(NSError *error) {
                
            }];
    }
}


#pragma mark - TuyaSmartBleMeshDelegate

// This method will be triggered under the gateway connection 
- (void)bleMeshReceiveRawData:(NSString *)raw {
    if ([[raw substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"d4"] && _address == [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(0, 2)]]) {
        
        if (raw.length < 14) {
            NSLog(@"raw error");
            return;
        }
        
        BOOL isNewProtocol = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(10, 2)]] == 255;
        
        if (isNewProtocol) {
            int state = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(12, 2)]];
            
            if (state == 1 || state == 255) {
                NSLog(@"success");
            } else {
                   // next
                return;
            }
            
        }

            [self.meshGroup addDeviceWithDeviceId:_devId success:^{
                // next
            } failure:^(NSError *error) {
            }];
    }
}
```



### Remove Device From Group

**Declaration**

Bluetooth

```objective-c
- (void)deleteDeviceAddress:(uint32_t)deviceAddress type:(NSString *)type groupAddress:(uint32_t)groupAddress;

// TYBLEMeshManagerDelegate callback
- (void)deviceAddGroupAddress:(uint32_t)address error:(NSError *)error;
```

**Declaration**

Gateway

```objective-c
- (NSString *)rawDataDeleteDeviceAddress:(uint32_t)deviceAddress groupAddress:(uint32_t)groupAddress type:(NSString *)type

- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;

// `TuyaSmartBleMeshDelegate` - (void)bleMeshReceiveRawData:(NSString *)raw callback
// TuyaSmartBleMeshDelegate 
- (void)bleMeshReceiveRawData:(NSString *)raw;
```

**Declaration**

Remote delete

After the above verification is completed, you can use this method to record the operation to the cloud and then proceed to the next device operation

```objective-c
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Example**

```objective-c
- (void)deleteDeviceFromGroup:(TuyaSmartDeviceModel *)model {

        int nodeId = [model.nodeId intValue] << 8;
    
        // Record the device address of the current operation for subsequent callback judgment
        _address = nodeId >> 8;
        if ([TYBLEMeshManager sharedInstance].isLogin) {
            // ble
            [[TYBLEMeshManager sharedInstance] deleteDeviceAddress:nodeId type:self.meshGroup.meshGroupModel.pcc groupAddress:[self.meshGroup.meshGroupModel.localId intValue]];
        } else {
            // wifi
            [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataDeleteDeviceAddress:nodeId groupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc] pcc:self.meshGroup.meshGroupModel.pcc success:^{
            } failure:^(NSError *error) {
            }];
        }
    
        // delete flag
        _isAdd = NO;
    
  //Here you can do the timeout yourself. It is recommended to fail if it is not received within 5s, and execute the next one.
}


#pragma mark - TYBLEMeshManagerDelegate
- (void)deviceAddGroupAddress:(uint32_t)address; {
    NSLog(@" --- deviceAddGroupAddress %d ", address);
    
    if (_address == address) {
        
            [self.meshGroup removeDeviceWithDeviceId:_devId success:^{
                //  success next
            } failure:^(NSError *error) {
            }];
    }
}


#pragma mark - TuyaSmartBleMeshDelegate

// This method will be triggered under the gateway connection 
- (void)bleMeshReceiveRawData:(NSString *)raw {
    if ([[raw substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"d4"] && _address == [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(0, 2)]]) {
        
        if (raw.length < 14) {
            NSLog(@"raw error");
            return;
        }
        
        BOOL isNewProtocol = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(10, 2)]] == 255;
        
        if (isNewProtocol) {
            int state = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(12, 2)]];
            
            if (state == 1 || state == 255) {
                NSLog(@"success");
            } else {
                   // next
                return;
            }
            
        }

            [self.meshGroup removeDeviceWithDeviceId:_devId success:^{
                // success next 
            } failure:^(NSError *error) {
            }];
    }
}
```

### Get Group Instance

```objective-c
+ (instancetype)meshGroupWithGroupId:(NSInteger)groupId;
```

> Note: The `groupId` here is not the `localId` described above. This is the field given by the server after the group is successfully added.
>
> All addresses issued by group operations are only related to `localId`

### Update Group Name

**Declaration**

```objective-c
- (void)updateMeshGroupName:(NSString *)meshGroupName success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| meshGroupName        | new name |
| success        | success block |
| failure        | failure block |

### Remove Device From Group 

**Declaration**

```objective-c
// Bluetooth
- (void)deleteGroupAddress:(uint32_t)groupAddress type:(NSString *)type;

// Gateway
- (NSString *)rawDataDeleteGroupAddress:(uint32_t)groupAddress type:(NSString *)type
 
- (void)publishRawDataWithRaw:(NSString *)raw
       pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;
```

Remote delete

**Declaration**

```objective-c
- (void)removeMeshGroupWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c

    [self.meshGroup removeMeshGroupWithSuccess:^{
       	//
    } failure:^(NSError *error) {
        // 
    }];
    
    // if local connection
    if ([TYBLEMeshManager sharedInstance].isLogin) {
    	
    	// use ble 
        [[TYBLEMeshManager sharedInstance] deleteGroupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc];
    } else {
        // Wi-Fi
        // use gateway
        [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataDeleteGroupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc] pcc:self.meshGroup.meshGroupModel.pcc success:^{
        } failure:^(NSError *error) {
        }];
    }
```




### Get Devices From Group

**Declaration**

```objective-c
- (void)getDeviveListInfoWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *deviceList))success failure:(TYFailureError)failure;
```

**Parameters**


| parameter           | Description     |
| -------------- | ----------------     |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c
[self.meshGroup getDeviveListInfoWithSuccess:^(NSArray<TuyaSmartDeviceModel *> *deviceList) {
   	 // success
} failure:^(NSError *error) {
            // fail
        }];
```

## Control

#### Command

`{"(dpId)" : "(dpValue)"} `，  `@{@"101" : @"44"}`

### Control Command - Control Devices

**Declaration**

```objective-c
- (void)publishNodeId:(NSString *)nodeId
                  pcc:(NSString *)pcc
                  dps:(NSDictionary *)dps
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| nodeId        | device node |
| pcc        | pcc |
| dps        | dps dictionary |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c
int address = [[self.smartDevice deviceModel].nodeId intValue] << 8;

[self.mesh publishNodeId:[NSString stringWithFormat:@"%d", address] pcc:self.smartDevice.deviceModel.pcc dps:@{@"1":@(1)} success:^{
	// success do 
	} failure:^(NSError *error) {
    // error do
}];
```



### Control Command - Control Group

**Declaration**

```objective-c
- (void)multiPublishWithLocalId:(NSString *)localId
                            pcc:(NSString *)pcc
                            dps:(NSDictionary *)dps
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
```

**Example**

```objective-c
int address = [[self.meshGroup meshGroupModel].localId intValue];

[self.mesh multiPublishWithLocalId:[NSString stringWithFormat:@"%d", address] pcc:self.meshGroup.meshGroupModel.pcc dps:@{@"1":@(1)} success:^{
	// success do 
	} failure:^(NSError *error) {
    // error do
}];
```



#### Gateway Raw Command

> TYBLEMeshManager support raw command

**Declaration**

```objective-c
- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;
```

#### Device Info Update

After sending the command, if there is a returned command, the device's data reply is called back through the proxy in `TuyaSmartHomeDelegate`

**Declaration**

```objective-c
// dps update
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps;
```

## Firmware Upgrade

### Query Firmware Info

**Declaration**

get device upgrade info

```objective-c
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

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| success        | success block |
| failure        | failure block |



### Sub-Device Upgrade

Ensure device online

**connect target device**

**Declaration**

```objective-c
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
```

  

**After setting, it will be connected. You can receive the connection through the `TYBLEMeshManagerDelegate` proxy method**

**Declaration**

```objective-c
- (void)notifyLoginSuccessWithAddress:(uint32_t)address;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| address        | node address |

**Send upgrade package after receiving callback**


```
- (void)sendOTAPackWithAddress:(NSInteger)address version:(NSString *)version otaData:(NSData *)otaData success:(TYSuccessHandler)success failure:(TYFailureHandler)failure;
```
**Update version number to the remote**

**Declaration**

```objective-c
- (void)updateDeviceVersion:(NSString *)version type:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| parameter           | Description     |
| -------------- | ----------------     |
| version        | version |
| type        | upgradeModel.type |
| success        | success block |
| failure        | failure block |

**Example**

```objective-c
1. prepare
int otaAddress = [self.device.deviceModel.nodeId intValue] << 8;
// ble connect
    [[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:otaAddress];
    [TYBLEMeshManager sharedInstance].delegate = self;


2. 3. callback and send pack
- (void)notifyLoginSuccessWithAddress:(uint32_t)address {
    [[TYBLEMeshManager sharedInstance] sendOTAPackWithAddress:address version:#<version> otaData:_otaData success:^{
        [self updateVersion];
    } failure:^{
        NSLog(@"ota failure!");
    }];
}

4. Update version
- (void)updateVersion {
    WEAKSELF_AT
    [self.smartDevice updateDeviceVersion:_upgradeModel.version type:_upgradeModel.type success:^{
       // success do..
    } failure:^(NSError *error) {
       // error do.. 
    }];
}
```
