## BLE Mesh SDK 使用说明

> 下文将 `BLE Mesh` 称作 `mesh` 或 `蓝牙 mesh`

### 蓝牙 Mesh 介绍

蓝牙 mesh 通俗点讲，就是把多个蓝牙单点设备组成一个 mesh 网络，每个节点可以和别的节点自由通讯，通过手机**直连 mesh 网中任意一个设备，即能访问控制 mesh 网中所有的设备**



### 使用提示

- 导入头文件

  ```objective-c
  使用
  #import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
  ```

- 开启 mesh

  ```objective-c
  // 设置 sdk 开启 mesh，需要在初始化的时候设置！！！！
  [[TuyaSmartSDK sharedInstance] setValue:@(YES) forKey:@"bleMeshEnable"];
  ```


### Mesh 部分基础概念

* 大小类

  每个 mesh 设备都对应一款产品，每个产品都有自己的大小类标示，sdk 中以 `pcc`、`type` 作为大小类标示

  Mesh 产品目前分为五大类

  ```objective-c
    灯大类(01): 1-5 路 RGBWC 彩灯
    电工类(02): 1-6 路插座
    传感器类(04): 门磁、PIR（传感类主要是一些周期性上报的传感数据）
    执行器类(10): 马达、报警器之类用于执行的设备
    适配器(08): 网关（带有mesh及其他通信节点的适配器）
  ```

  小类编号

  ```objective-c
    1-5 路灯（01-05）
    1-6 路排插（01-06)
    .....
  ```

  设备类型举例（小类在前，大类在后）

  ```objective-c
     四路灯     0401
     五路灯     0501
     五路插座   0502
     网关      0108
     ......
  ```

* mesh 节点 node Id

  node id 用于区分每个 mesh 设备在 mesh 网中的「唯一标识」，比如想控制某个设备就向 mesh 网发此设备对应的 nodeId 命令即可

* mesh 群组 local Id
  local Id 用于区分每个 mesh 群组在 mesh 网中的「唯一标识」，比如想控制某个群组中的设备就向 mesh 网发此群组对应的 localId 命令即可

* 设备操作需要多步操作

  因为设备的操作，例如增删操作、群组操作，都需要本地蓝牙命令执行一次、云端记录一次
  向本地 mesh 网同步操作信息的同时也需要向云端同步操作信息

* 本地连接和网关连接
  本地连接：已配网设备通过蓝牙连接，来控制 mesh 和指令操作

  网关连接:  已配网设备通过网关连接（网关需和设备在一起，距离不能太远）,来控制 mesh 和指令操作


### Mesh 操作

> `mesh` 的主要操作类都在 `TuyaSmartBleMesh.h` 文件中

#### 创建 mesh

一个家庭里可以拥有多个 `mesh`（建议一个家庭只创建一个），`mesh` 中所有操作都建立在家庭数据已经初始化的基础上

> 完全初始化家庭操作可以在查看[此处](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#%E5%AE%B6%E5%BA%AD%E7%AE%A1%E7%90%86)

```objective-c
/**
 创建 mesh
 一个家庭建议只创建一个 mesh，创建前需判断下是否已经创建，若尚未创建可以通过此方法进行创建

 @param meshName mesh 名字，用户自定义
 @param homeId 家庭 homeId
 @param success 操作成功回调
 @param failure 操作失败回调
 */
+ (void)createBleMeshWithMeshName:(NSString *)meshName
                           homeId:(long long)homeId
                          success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                          failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
TuyaSmartHome *home = #<上文初始化的 home 实例>;
long long homeId = home.homeModel.homeId;
[TuyaSmartBleMesh createBleMeshWithMeshName:@"yourMeshName" homeId:homeId success:^(TuyaSmartBleMeshModel *meshModel) {
    // success do...
} failure:^(NSError *error) {
    NSLog(@"create mesh error: %@", error);
}];
```

>此方法的 meshName 为自定义，建议使用唯一参数进行设置，例如 “mesh+时间戳形式”



#### 删除 mesh

```
/**
 删除mesh，如果mesh组下有设备，子设备也移除掉。wifi连接器也一并移除掉。
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
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



### Mesh 数据获取

#### 获取家庭下的 mesh 列表

通过初始化 `home` 实例后，可以拿到对应家庭下的 `mesh` 列表

```objective-c
/**
 *  获取家庭下的mesh列表
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                       failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
TuyaSmartHome *home = #<home 实例>
[home getMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
	// success do
} failure:^(NSError *error) {
	NSLog(@"get mesh list error: %@", error);
}];
```



#### 获取 Mesh 实例

```objective-c
/**
 获取 mesh 实例

 @param meshId mesh id
 @param homeId 当前 home id
 */
+ (instancetype)bleMeshWithMeshId:(NSString *)meshId homeId:(long long)homeId;
```

「代码示例」

通过家庭（`TuyaSmartHome` 实例）`home` 可以拿到类下的 `meshModel`，可以通过此进行创建，并且在创建完成之后，赋值给当前的 `TuyaSmartUser` 中，SDK 中以及上层以 `TuyaSmartUser` 是否有值为判断基准:

```objective-c
// 如果还未获取 mesh
if ([TuyaSmartUser sharedInstance].meshModel == nil) {
    TuyaSmartHome *home = #<home 实例>
    [home getMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
            if (list.count > 0) {
                // 赋值
                [TuyaSmartUser sharedInstance].meshModel = home.meshModel;
                [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:home.meshModel.meshId homeId:home.meshModel.homeId];
                
                // 接下来的操作
            } else {
                // 如果云端没有 mesh 信息，则为用户创建 mesh
                NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                NSString *meshName = [NSString stringWithFormat:@"tymesh%.0f", interval];
                
                [TuyaSmartBleMesh createBleMeshWithMeshName:meshName homeId:home.homeModel.homeId success:^(TuyaSmartBleMeshModel *meshModel) {
                    // 赋值
                    [TuyaSmartUser sharedInstance].meshModel = meshModel;
                    [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:meshModel.meshId homeId:home.homeModel.homeId];
                         
                    // 接下来的操作
                } failure:^(NSError *error) {
                    // 错误处理
                }];
            }
        } failure:^(NSError *error) {
            // 错误处理
        }];
} else {
    // 接下来的操作
}

```



### 配网与入网

> mesh 的操作类集中在 `TYBLEMeshManager` 中，且此类为单例

配网指的是将处于重置状态、未入网的设备，添加到 mesh 网中，以下是 mesh 两种设备的配网流程图

![image-20190104194119724](./images/ios-mesh-sub-active.png)



![image-20190104194313461](./images/ios-mesh-gw-active.png)



下面列举了常用设备的重置方式



#### 设备重置

| 产品类型   | 重置操作     | 可配网现象                                       |
| ---------- | ------------ | ------------------------------------------------ |
| 灯         | 连续开关三次 | 灯快闪                                           |
| 插座       | 长按开关 3s  | 插座指示灯快闪                                   |
| 网关       | 长按开关 3s  | 红灯和蓝灯快闪                                   |
| 低功耗设备 | 长按开关 3s  | 再按一次出现长亮即可配网，且配网需在灯亮期间完成 |
| 报警器     | 长按开关 3s  | 灯快闪                                           |

处于重置状态的设备，默认名字为 `out_of_mesh`，默认密码为 `123456`



#### 设备扫描

> 为了简化扫描以及后续的配网操作，将所有的操作统一一个接口进行操作

```objective-c
/**
 mesh 入口
 
 若操作为配网，填入默认 mesh name 和 password，此时只会通过 `TYBLEMeshManagerDelegate` 中的
 `- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 返回扫描结果
 
 若操作为入网，填入已创建的 mesh name 和 password，此信息来自云端接口返回，可以自动进行连接、入网，并自动获取一次 mesh 网中的各个设备在线情况
 
 @param name mesh 名称
 @param pwd mesh 密码
 @param active 是否为配网激活
 @param wifiAddress Wi-Fi 地址，网关配网需要，其余情况传 0
 @param otaAddress ota 设备地址，ota 升级时需要，其余情况传 0
 */
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
```



若传入的 name 为默认值 `out_of_mesh`，且为激活操作，会扫描周围待配网的设备，扫描的结果会以 `TYBLEMeshManagerDelegate` 中的方法进行回调；

```objective-c
/**
 扫描到待配网的设备

 @param manager mesh manager
 @param device 待配网设备信息
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;
```

如果为入网操作，则会自动进行后续操作，不会回调



「代码示例」

待配网的扫描

```objective-c
// 开始扫描待配网的设备
[[TYBLEMeshManager sharedInstance] startScanWithName:@"out_of_mesh" pwd:@"123456" active:YES wifiAddress:0 otaAddress:0];

// TYBLEMeshManagerDelegate 扫描回调方法
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device {
   
    // 扫描到的网关设备和子设备都会通过此方法进行回调
   	// 通过 device.type 和 device.vendorInfo 来判定是否为 mesh 网关
    if (device.type == [TPUtils getIntValueByHex:@"0x0108"] || ([TPUtils getIntValueByHex:[device.vendorInfo substringWithRange:NSMakeRange(0, 2)]] & 0x08) == 0x08) {
      	// mesh 网关
        return;
    } else {
        // mesh 子设备
    }
}

// getIntValueByHex 实现
+ (uint32_t)getIntValueByHex:(NSString *)getStr
{
    NSScanner *tempScaner=[[NSScanner alloc] initWithString:getStr];
    uint32_t tempValue;
    [tempScaner scanHexInt:&tempValue];
    return tempValue;
}

```



入网调用比较简单，见 3.4「入网」



#### 配网

mesh 配网主要分为两种，一种是针对普通蓝牙 mesh 设备（又称 mesh 子设备），例如灯、插座、低功耗等，可以理解为只要不带网关，就是普通蓝牙设备，一种是对 mesh 网关配网

```objective-c
/**
 激活设备
 
 @param includeGateway 是否激活网关，若为 `yes`, 则会激活已记录扫描到设备中的网关设备，其余子设备不激活
                        反之激活所有的已扫描的普通的 mesh 子设备，不激活网关
 */
- (void)activeMeshDeviceIncludeGateway:(BOOL)includeGateway;

/**
 激活特定的设备

 @param deviceModel 设备 model
 */
- (void)activeMeshDevice:(TYBleMeshDeviceModel *)deviceModel;

```



 配网结果会通过 `TYBLEMeshManagerDelegate` 进行回调

```objective-c
/**
 激活子设备回调

 @param name 设备名称
 @param deviceId dev Id
 @param error 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空
 */
- (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error;

/**
 激活网关设备回调

 @param name 设备名称
 @param address 设备地址
 @param mac 网关 mac
 @param error 激活中的错误
 */
- (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error;


```



若激活的为网关设备，需要在收到回调`activeWifiDeviceWithName ` 方法过后，需要再进行与 Wi-Fi 模块进行配网，这时候需要调用 `TuyaSmartActivator` 中方法执行操作

```objective-c
1. 获取 token
/**
 *
 *  wifi 连接器加入 mesh
 *  获取配网 Token（有效期10分钟）
 *
 *  @param meshId
 *  @param nodeId
 *  @param productId
 *  @param uuid
 *  @param authKey
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getTokenWithMeshId:(NSString *)meshId
                    nodeId:(NSString *)nodeId
                 productId:(NSString *)productId
                      uuid:(NSString *)uuid
                   authKey:(NSString *)authKey
                   version:(NSString *)version
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;


2. 将 token、路由器账号、密码进行网关入网
/**
 * 
 * mesh 网关入网
 * 需要实现激活网关后，收到 `TYBLEMeshManagerDelegate` 的 `activeWifiDeviceWithName` 后，方可以调用此方法
 *
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */

- (void)startBleMeshConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;
```







「代码示例」

* mesh 子设备（不带网关的设备）入网

  ```objective-c
  // 1. 激活子设备
  [[TYBLEMeshManager sharedInstance] activeMeshDeviceIncludeGateway:NO];
  
  // 2. TYBLEMeshManagerDelegate 回调
  - (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error {
      
      if (error) {
          NSLog(@"error : %@", error);
          return;
      }
      
      // 3. 激活成功，至此，一个子设备激活完成
  }
  
  ```

* 网关激活



  ```objective-c
  // 1. 激活子设备
  [[TYBLEMeshManager sharedInstance] activeMeshDeviceIncludeGateway:NO];
  
  // 2. TYBLEMeshManagerDelegate 回调
  - (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error {
      
      if (error) {
          NSLog(@"error : %@", error);
          return;
      }
      
      // 激活网关成功，目前只成功蓝牙模块，还需要继续配置 Wi-Fi 模块激活
      
      // 3. 用户输入密码再去重连，重连成功后再发送ssid, pwd, token，
      // ！！！！注意，一定要做此操作，不然会影响 Wi-Fi 信息写入导致配网失败
   	[TYBLEMeshManager sharedInstance].wifiMac = (int)mac;
      
      // 4. 获取 token 
      NSString *nodeId = [NSString stringWithFormat:@"%02x", (int)address];
      
       [[TuyaSmartActivator sharedInstance] getTokenWithMeshId:[TuyaSmartUser sharedInstance].meshModel.meshId
                                                               nodeId:nodeId
                                                            productId:[TYBLEMeshManager sharedInstance].productId
                                                                 uuid:[TYBLEMeshManager sharedInstance].uuid
                                                              authKey:[TYBLEMeshManager sharedInstance].authKey
                                                              version:[TYBLEMeshManager sharedInstance].version
                                                              success:^(NSString *token) {
          
          	// 5. 设置配网代理，通过代理接收激活结果
  	        [TuyaSmartActivator sharedInstance].delegate = self;   
              // 6. 开始 Wi-Fi 配网
              [[TuyaSmartActivator sharedInstance] startBleMeshConfigWiFiWithSsid:@"Wi-Fi 名称" password:@"Wi-Fi 密码" token:token timeout:100];
             
          
          } failure:^(NSError *error) {
              NSLog(@"error: %@", error);
          }];
      
  }
  
  - (void)meshActivator:(TuyaSmartActivator *)activator didReceiveDeviceId:(NSString *)deviceId meshId:(NSString *)meshId error:(NSError *)error {
      // 7. 收到激活结果
      
  }
  
  ```



#### 入网

入网是对通过已配网设备连入 mesh 网的操作，该过程需要开启蓝牙

```objective-c
/**
 mesh 入口
 
 若操作为配网，填入默认 mesh name 和 password，此时只会通过 `TYBLEMeshManagerDelegate` 中的
 `- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 返回扫描结果
 
 若操作为入网，填入已创建的 mesh name 和 password，此信息来自云端接口返回，可以自动进行连接、入网，并自动获取一次 mesh 网中的各个设备在线情况
 
 @param name mesh 名称
 @param pwd mesh 密码
 @param active 是否为配网激活
 @param wifiAddress Wi-Fi 地址，网关配网需要，其余情况传 0
 @param otaAddress ota 设备地址，ota 升级时需要，其余情况传 0
 */
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
```



入网成功会自动获取 mesh 网中设备的在线状态，并触发 `TuyaSmartHomeDelegate` 代理方法进行回调信息

```
// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device;
```



「代码示例」

```objective-c
// 注意，此时的 active、wifiAddress、otaAddress 参数赋值情况
[[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:0];

// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    // 收到回调操作
}
```




#### mesh 连接标识

在操作的过程中，会经常判断是否是 mesh 已有设备通过蓝牙入网，来决定使用何种方式下发控制命令和操作命令

```objective-c
// mesh 本地连接标识，有设备通过蓝牙连接，此属性为 yes
BOOL isLogin = [TYBLEMeshManager sharedInstance].isLogin;
```



### Mesh 设备

> 和全屋 sdk 一样，设备类都是 `TuyaSmartDevice`，里面的 `TuyaSmartDeviceModel` 中的 `deviceType` 信息可以区分设备类型
>
> 这里 mesh 设备对应 `deviceType` 类型为 `TuyaSmartDeviceModelTypeMeshBleSubDev`



#### 获取设备实例

```objective-c
/** 获取设备对象
 @param devId 设备Id
 */
+ (instancetype)deviceWithDeviceId:(NSString *)devId;
```



#### 设备重命名

```objective-c
/**
 重命名mesh子设备
 
 @param deviceId    设备ID
 @param name        新的名字
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)renameMeshSubDeviceWithDeviceId:(NSString *)deviceId name:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
[[TuyaSmartUser sharedInstance].mesh renameMeshSubDeviceWithDeviceId:self.device.devId name:name success:^{
            // success do
        } failure:^(NSError *error) {
            // failure do
        }];
```



#### 向 mesh 网中加入设备（sdk 中配网时已自动处理，若无特殊必要，可忽略）

```objective-c
/**
 蓝牙设备入网 2.0
 
 @param uuid        蓝牙子设备短地址标识
 @param authKey     授权
 @param nodeId      mesh节点id（短地址）
 @param productKey  产品ID
 @param ver         版本号
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addSubDeviceWithUuid:(NSString *)uuid
                      homeId:(long long)homeId
                     authKey:(NSString *)authKey
                      nodeId:(NSString *)nodeId
                  productKey:(NSString *)productKey
                         ver:(NSString *)ver
                     success:(void (^)(NSString *devId, NSString *name))success
                     failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
[[TuyaSmartUser sharedInstance].mesh addSubDeviceWithUuid:_uuid homeId:[TuyaSmartUser sharedInstance].meshModel.homeId authKey:_authKey nodeId:nodeHex productKey:_selectedPeripheral.productId ver:_selectedPeripheral.version success:^(NSString *devId, NSString *name) {
					// success do 
                    } failure:^(NSError *error) {
                    // failure do
                    }];
```



#### 移除设备

移除设备需要云端删除、本地删除

1. 本地删除

   通过蓝牙

   ```objective-c
   - (void)kickoutLightWithAddress:(uint32_t)address type:(NSString *)type;
   ```



   通过网关

   ```objective-c
   - (NSString *)rawDataKickoutLightWithAddress:(uint32_t)address type:(NSString *)type;
   
   /**
    给设备发送透传指令
    
    @param raw 透传值
    @param success 操作成功的回调
    @param failure 操作失败的回调
    */
   - (void)publishRawDataWithRaw:(NSString *)raw
                             pcc:(NSString *)pcc
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;
   ```


2. 云端删除

```objective-c
/**
 移除mesh子设备
 
 @param deviceId    设备ID
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)removeMeshSubDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
 int address = [smartDevice.deviceModel.nodeId intValue] << 8;
        
        //1.  云端删除
        [[TuyaSmartUser sharedInstance].mesh removeMeshSubDeviceWithDeviceId:[smartDevice.deviceModel.devId success:^{
            
            
        } failure:^(NSError *error) {
           
        }];
        
        // 2. 本地删除
        // 判断连接情况，使用网关还是蓝牙
        if ([TYBLEMeshManager sharedInstance].isLogin) {
            
            [[TYBLEMeshManager sharedInstance] kickoutLightWithAddress:address type:[smartDevice.deviceModel.pcc];
             
        } else {
            
            [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataKickoutLightWithAddress:address type:[smartDevice.deviceModel.pcc] pcc:[smartDevice.deviceModel.pcc success:^{
                
            } failure:^(NSError *error) {
                
            }];
        }
         

```



### Mesh 群组

群组作为 mesh 的特色之一，可以将设备添加到群组后，通过一个命令控制群组所有的设备

操作类: `TuyaSmartBleMeshGroup`



#### 创建群组

> 创建时群组地址 local Id 从 `0x8001` 开始，依次叠加
>
> 群组的大小类和设备一样，传入表示此群组约定此类设备组建为群组
>
> 注：若强行加入其他品类，可能会因为 dp 不同导致控制失败

目前每个 mesh 最多支持添加 255 个群组，1 个设备最多只能加入 8 个群组

```objective-c
/**
 创建mesh群组
 
 @param groupName mesh群组名字
 @param meshId    meshId
 @param localId   群组的本地短地址
 @param pcc 群组设备大小类
 @param success 操作成功回调 GroupId
 @param failure 操作失败回调
 */
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;
```

「代码示例」

```objective-c

NSInteger localId = 0x8001;
[TuyaSmartBleMeshGroup createMeshGroupWithGroupName:@<群组名称> meshId:[TuyaSmartUser sharedInstance].meshModel.meshId localId:[NSString stringWithFormat:@"%lx", localId] pcc:#<群组的大小类> success:^(int result) {
     // success do
    // 可以拿到 group 实例
     self.meshGroup = [TuyaSmartBleMeshGroup meshGroupWithGroupId:result];
       
    } failure:^(NSError *error) {
       // failure do
    }];
```



#### 获取群组实例

```objective-c
/**
 获取mesh群组对象
 
 @param groupId 群组Id
 */
+ (instancetype)meshGroupWithGroupId:(NSInteger)groupId;
```

> 注： 此处的 `groupId` 并非上面所述 `localId`，此是由添加群组成功之后，服务端给的字段
>
> 所有的群组操作下发的地址都只是和 `localId` 有关



#### 修改群组名称

```objective-c
/**
 修改mesh群组名字
 
 @param meshGroupName meshGroup名称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateMeshGroupName:(NSString *)meshGroupName success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



#### 删除群组

> 删除群组和设备一样，都需要经过本地删除和云端删除

本地删除:

- 本地连接下

  ```objective-c
  - (void)deleteGroupAddress:(uint32_t)groupAddress type:(NSString *)type;
  ```


* 网关连接下

  ```objective-c
  - (NSString *)rawDataDeleteGroupAddress:(uint32_t)groupAddress type:(NSString *)type
  
  /**
   给设备发送透传指令
   
   @param raw 透传值
   @param success 操作成功的回调
   @param failure 操作失败的回调
   */
  - (void)publishRawDataWithRaw:(NSString *)raw
                            pcc:(NSString *)pcc
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
  ```


云端删除:

```objective-c
/**
 删除mesh群组
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeMeshGroupWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c

    [self.meshGroup removeMeshGroupWithSuccess:^{
       	// 云端删除成功
    } failure:^(NSError *error) {
        // 云端删除失败
    }];
    
    // 如果是本地连接
    if ([TYBLEMeshManager sharedInstance].isLogin) {
    	
    	// 通过蓝牙命令删除群组
        [[TYBLEMeshManager sharedInstance] deleteGroupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc];
    } else {
        // wifi
        // 通过网关删除群组
        [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataDeleteGroupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc] pcc:self.meshGroup.meshGroupModel.pcc success:^{
        } failure:^(NSError *error) {
        }];
    }
```



#### 向群组内添加设备

> 向群组内加设备，需要经过本地、云端双重验证，才能算作一个设备成功加入到群组，结果
>
> 操作是设备一个一个进行，按顺序执行。不能并发进行



流程图

![image-20181110143530597](./images/ios-mesh-addgroup.png)

本地添加

* 本地连接

  ```objective-c
  
  // 添加设备到群组方法，该方法执行后会通过 TYBLEMeshManagerDelegate 方法回调
  - (void)addDeviceAddress:(uint32_t)deviceAddress type:(NSString *)type groupAddress:(uint32_t)groupAddress;
  
  // TYBLEMeshManagerDelegate
  - (void)deviceAddGroupAddress:(uint32_t)address error:(NSError *)error;
  ```

* 网关连接

  ```objective-c
  // 获取添加设备到群组命令 raw
  - (NSString *)rawDataAddDeviceAddress:(uint32_t)deviceAddress groupAddress:(uint32_t)groupAddress type:(NSString *)type;
  
  /**
   给设备发送透传指令
   
   @param raw 透传值
   @param success 操作成功的回调
   @param failure 操作失败的回调
   */
  - (void)publishRawDataWithRaw:(NSString *)raw
                            pcc:(NSString *)pcc
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
  
  //发送的 raw 消息会通过 `TuyaSmartBleMeshDelegate` - (void)bleMeshReceiveRawData:(NSString *)raw 回调
  // TuyaSmartBleMeshDelegate 
  - (void)bleMeshReceiveRawData:(NSString *)raw;
  ```


云端添加

待到上述验证完成后，可通过此方法将操作记录到云端后，可以进行下一个设备的操作

```objective-c
/**
 添加设备到群组
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
- (void)addDeviceToGroup:(TuyaSmartDeviceModel *)model {
        int nodeId = [model.nodeId intValue] << 8;
    	// 记录当前设备的地址，作为后续判断
        _address = nodeId >> 8;
    
        if ([TYBLEMeshManager sharedInstance].isLogin) {
            // ble
            [[TYBLEMeshManager sharedInstance] addDeviceAddress:nodeId type:self.meshGroup.meshGroupModel.pcc groupAddress:[self.meshGroup.meshGroupModel.localId intValue]];
        } else {
            // wifi
            [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:[[TYBLEMeshManager sharedInstance] rawDataAddDeviceAddress:nodeId groupAddress:[self.meshGroup.meshGroupModel.localId intValue] type:self.meshGroup.meshGroupModel.pcc] pcc:self.meshGroup.meshGroupModel.pcc success:^{
            } failure:^(NSError *error) {
            }];
        }

    	// 标记当前操作为新增
        _isAdd = YES;
    
    // 这里可以自己做超时，建议为 5s 未收到表示失败，执行下一个
}


#pragma mark - TYBLEMeshManagerDelegate
- (void)deviceAddGroupAddress:(uint32_t)address; {
    NSLog(@" --- deviceAddGroupAddress %d ", address);
    
    if (_address == address) {
        
            [self.meshGroup addDeviceWithDeviceId:_devId success:^{
                // 操作成功，执行下一个
            } failure:^(NSError *error) {
                
            }];
    }
}


#pragma mark - TuyaSmartBleMeshDelegate

// 网关链接下，组建群组会触发此方法
- (void)bleMeshReceiveRawData:(NSString *)raw {
    if ([[raw substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"d4"] && _address == [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(0, 2)]]) {
        
        if (raw.length < 14) {
            NSLog(@"raw 长度错误");
            return;
        }
        
        BOOL isNewProtocol = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(10, 2)]] == 255;
        
        if (isNewProtocol) {
            int state = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(12, 2)]];
            
            if (state == 1 || state == 255) {
                NSLog(@"设备群组操作成功");
            } else {
           		// 操作失败执行下一个
                return;
            }
            
        }

            [self.meshGroup addDeviceWithDeviceId:_devId success:^{
                // 操作成功，执行下一个
            } failure:^(NSError *error) {
            }];
    }
}
```



#### 向群组内删除设备

> 和向群组内添加设备操作流程类似
>
> 向群组内删除设备，需要经过本地、云端双重验证，才能算作一个设备从群组内删除，结果
>
> 操作是设备一个一个进行，按顺序执行。不能并发进行

流程图

![image-20181110151556211](./images/ios-mesh-delgroup.png)

本地删除

- 本地连接

  ```objective-c
  // 删除群组内某个设备方法，该方法执行后会通过 TYBLEMeshManagerDelegate 方法回调
  - (void)deleteDeviceAddress:(uint32_t)deviceAddress type:(NSString *)type groupAddress:(uint32_t)groupAddress;
  
  // TYBLEMeshManagerDelegate
  - (void)deviceAddGroupAddress:(uint32_t)address error:(NSError *)error;
  ```

- 网关连接

  ```objective-c
  // 获取删除群组内设备命令 raw
  - (NSString *)rawDataDeleteDeviceAddress:(uint32_t)deviceAddress groupAddress:(uint32_t)groupAddress type:(NSString *)type
  
  /**
   给设备发送透传指令
   
   @param raw 透传值
   @param success 操作成功的回调
   @param failure 操作失败的回调
   */
  - (void)publishRawDataWithRaw:(NSString *)raw
                            pcc:(NSString *)pcc
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
  
  //发送的 raw 消息会通过 `TuyaSmartBleMeshDelegate` - (void)bleMeshReceiveRawData:(NSString *)raw 回调
  // TuyaSmartBleMeshDelegate 
  - (void)bleMeshReceiveRawData:(NSString *)raw;
  ```


云端删除

待到上述验证完成后，可通过此方法将操作记录到云端后，可以进行下一个设备的操作

```objective-c
/**
 移除群组内设备
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」



```objective-c
- (void)deleteDeviceFromGroup:(TuyaSmartDeviceModel *)model {

        int nodeId = [model.nodeId intValue] << 8;
    
    	// 记录当前操作的设备地址，用于后续回调判断
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
    
    	// 标记当前操作为删除
        _isAdd = NO;
    
    // 这里可以自己做超时，建议为 5s 未收到表示失败，执行下一个
}


#pragma mark - TYBLEMeshManagerDelegate
- (void)deviceAddGroupAddress:(uint32_t)address; {
    NSLog(@" --- deviceAddGroupAddress %d ", address);
    
    if (_address == address) {
        
            [self.meshGroup removeDeviceWithDeviceId:_devId success:^{
                // 操作成功，执行下一个
            } failure:^(NSError *error) {
            }];
    }
}


#pragma mark - TuyaSmartBleMeshDelegate

// 网关链接下，组建群组会触发此方法
- (void)bleMeshReceiveRawData:(NSString *)raw {
    if ([[raw substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"d4"] && _address == [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(0, 2)]]) {
        
        if (raw.length < 14) {
            NSLog(@"raw 长度错误");
            return;
        }
        
        BOOL isNewProtocol = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(10, 2)]] == 255;
        
        if (isNewProtocol) {
            int state = [TPUtils getIntValueByHex:[raw substringWithRange:NSMakeRange(12, 2)]];
            
            if (state == 1 || state == 255) {
                NSLog(@"设备群组操作成功");
            } else {
           		// 操作失败执行下一个
                return;
            }
            
        }

            [self.meshGroup removeDeviceWithDeviceId:_devId success:^{
                // 删除成功，执行下一个
            } failure:^(NSError *error) {
            }];
    }
}
```

#### 获取群组内设备

```objective-c
/**
 获取群组中设备list信息
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getDeviveListInfoWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *deviceList))success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
[self.meshGroup getDeviveListInfoWithSuccess:^(NSArray<TuyaSmartDeviceModel *> *deviceList) {
   	 // 获取成功
} failure:^(NSError *error) {
            // 获取失败
        }];
```



### Mesh 控制

> mesh 指令下发是根据设备的 dp 信息来进行操作

#### 指令发送格式

发送控制指令按照以下格式：`{"(dpId)" : "(dpValue)"} `， 如 `@{@"101" : @"44"}`

#### 控制单设备

```objective-c
/**
 单个子设备dps命令下发
 
 @param nodeId 蓝牙子设备短地址标识
 @param pcc 大小类标示
 @param dps 命令字典
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)publishNodeId:(NSString *)nodeId
                  pcc:(NSString *)pcc
                  dps:(NSDictionary *)dps
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
int address = [[self.smartDevice deviceModel].nodeId intValue] << 8;

[self.mesh publishNodeId:[NSString stringWithFormat:@"%d", address] pcc:self.smartDevice.deviceModel.pcc dps:@{@"1":@(1)} success:^{
	// success do 
	} failure:^(NSError *error) {
    // error do
}];
```



#### 控制群组

```objective-c
/**
 群控设备
 
 @param localId    localId
 @param pcc      大小类标示
 @param dps      命令字典
 @param success 操作成功的回调
 @param failure 操作失败的回调
 */
- (void)multiPublishWithLocalId:(NSString *)localId
                            pcc:(NSString *)pcc
                            dps:(NSDictionary *)dps
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
```

「代码示例」

```objective-c
int address = [[self.meshGroup meshGroupModel].localId intValue];

[self.mesh multiPublishWithLocalId:[NSString stringWithFormat:@"%d", address] pcc:self.meshGroup.meshGroupModel.pcc dps:@{@"1":@(1)} success:^{
	// success do 
	} failure:^(NSError *error) {
    // error do
}];
```



#### 网关透传 raw 命令

> TYBLEMeshManager 类头中提供了一些设备的 raw 命令

```objective-c
/**
 给设备发送透传指令
 
 @param raw 透传值
 @param success 操作成功的回调
 @param failure 操作失败的回调
 */
- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;
```



#### 设备数据数据更新

发送命令后，如果是有返回的命令，设备的数据回复通过`TuyaSmartHomeDelegate` 中代理回调

```
// 设备dp数据更新
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps;
```



### 场景灯格式

使用前请先确定固件支持场景

```
场景1到场景4是静彩模式
更改场景1
{set_scene1="0ff808000000000E0"}
0：表示是静彩模式
ff:R 
80:G
80:B
00:W  暖
00:C  冷
00:L  亮度值
00:S  step  （暂时都写死0）
E0:V  有效性 （表示上方RGBWCLS的有效性 ）  RGB有效是E0   WCL有效是1C

场景5到场景8是炫彩模式
更改场景5
{set_scene5="180ff560055AA0055AA"}
1：表示是炫彩模式 
80:对于HLS中L亮度
ff:对应HLS中S饱和度
56:二进制01010110，高5bit为渐变时间time=10(单位为200ms)，对应真实时间为10*200ms=2s;低3bit为渐变组数group=6组
00、55、AA、00、55、AA:对应HLS中H色相  6组
根据上面的L和S，再加上每组的H，一共可以计算出六组RGB数据。


0 c7 ed cc c8 37 64 00 e0


进入场景 发送null查询 获取场景具体值
{set_scene1=null}


切换白光：109 = "white"
切换彩光：可以直接发 rgb 命令，也可发 109 = "colour"


切换场景 1: 109 = "scene_1"
切换场景 2: 109 = "scene_2"
切换场景 3: 109 = "scene_3"
...
切换场景 8: 109 = "scene_8"



设置场景 1 - 8: dp 依次为 111 - 118
例如设置场景 5:  115 = "0f19ec27f806400e0"
其中格式可以按照之前的文档格式进行下发设置
```





### 固件升级

#### 设备升级固件信息查询

```objective-c
/**
 *  获取设备升级信息
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success failure:(TYFailureError)failure;
```



```
升级的信息会通过结果值返回，可以根据 type 信息去确定是否需要升级
	 0  升级中
     1  无升级
     2  有强制或提醒升级
     3  有检测升级

判断为需要升级后，具体的固件地址在返回值中，下载之后转成 data 进行后续操作	
```



#### 子设备升级

升级前需要确保蓝牙已开启

```objective-c
1. 连接目标设备，准备升级
/**
 mesh 入口
 
 若操作为配网，填入默认 mesh name 和 password，此时只会通过 `TYBLEMeshManagerDelegate` 中的
 `- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 返回扫描结果
 
 若操作为入网，填入已创建的 mesh name 和 password，此信息来自云端接口返回，可以自动进行连接、入网，并自动获取一次 mesh 网中的各个设备在线情况
 
 @param name mesh 名称
 @param pwd mesh 密码
 @param active 是否为配网激活
 @param wifiAddress Wi-Fi 地址，网关配网需要，其余情况传 0
 @param otaAddress ota 设备地址，ota 升级时需要，其余情况传 0
 */
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;
               
2. 设置完会进行连接，通过 `TYBLEMeshManagerDelegate` 代理方法可以收到连接情况
/**
 mesh 升级时已成功登入 mesh 网

 @param address 设备地址
 */
- (void)notifyLoginSuccessWithAddress:(uint32_t)address;


3. 收到回调后发送升级包
/**
 发送升级包

 @param address 设备地址
 @param version 版本号
 @param otaData 升级数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPackWithAddress:(NSInteger)address version:(NSString *)version otaData:(NSData *)otaData success:(TYSuccessHandler)success failure:(TYFailureHandler)failure;

4. 向云端更新版本号
/**
 *  更新设备固件的版本号
 *
 *  @param version 版本号
 *  @param type    固件类型
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateDeviceVersion:(NSString *)version type:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```



「代码示例」

```objective-c
1. 准备升级
int otaAddress = [self.device.deviceModel.nodeId intValue] << 8;
// 直连
    [[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:otaAddress];
    [TYBLEMeshManager sharedInstance].delegate = self;


2. 3. 回调并发生升级包
- (void)notifyLoginSuccessWithAddress:(uint32_t)address {
    [[TYBLEMeshManager sharedInstance] sendOTAPackWithAddress:address version:@"升级号" otaData:_otaData success:^{
        [self updateVersion];
    } failure:^{
        NSLog(@"ota failure!");
    }];
}

4. 向云端更新版本号
- (void)updateVersion {
    WEAKSELF_AT
    [self.smartDevice updateDeviceVersion:_upgradeModel.version type:_upgradeModel.type success:^{
       // success do..
    } failure:^(NSError *error) {
       // error do.. 
    }];
}
```

