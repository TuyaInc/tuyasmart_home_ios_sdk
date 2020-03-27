## 家庭管理

用户登录成功后需要通过`TuyaSmartHomeManager`去获取整个家庭列表的信息,然后初始化其中的一个家庭`TuyaSmartHome`，获取家庭详情信息，对家庭中的设备进行管理，控制。

|         类名(协议名)         |                 说明                 |
| :--------------------------: | :----------------------------------: |
|     TuyaSmartHomeManager     | 获取家庭列表、家庭列表排序、添加家庭 |
| TuyaSmartHomeManagerDelegate |      增删家庭、MQTT连接成功回调      |



### 获取家庭列表

获取家庭列表，返回数据只是家庭的简单信息。如果要获取具体家庭的详情，需要去`TuyaSmartHome`初始化一个 home，调用接口 `getHomeDetailWithSuccess:failure:`

**接口说明**

```objective-c
- (void)getHomeListWithSuccess:(void(^)(NSArray <TuyaSmartHomeModel *> *homes))success
                       failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| :------ | :------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)getHomeList {

	[self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        // homes 家庭列表
    } failure:^(NSError *error) {
        NSLog(@"get home list failure: %@", error);
    }];
}
```

Swift:

```swift
let homeManager: TuyaSmartHomeManager = TuyaSmartHomeManager()

func getHomeList() {
    homeManager.getHomeList(success: { (homes) in
        // homes 家庭列表
    }) { (error) in
        if let e = error {
            print("get home list failure: \(e)")
        }
    }
}
```



### 添加家庭

**接口说明**

```objective-c
- (void)addHomeWithName:(NSString *)homeName
                geoName:(NSString *)geoName
                  rooms:(NSArray <NSString *>*)rooms
               latitude:(double)latitude
              longitude:(double)longitude
                success:(TYSuccessLongLong)success
                failure:(TYFailureError)failure;
```

**参数说明**

| 参数      | 说明         |
| --------- | ------------ |
| homeName  | 家庭名称     |
| geoName   | 地址名称     |
| rooms     | 房间名称列表 |
| latitude  | 地址纬度     |
| longitude | 地址经度     |
| success   | 成功回调     |
| failure   | 失败回调     |

**示例代码**

Objc:

```objective-c
- (void)addHome {
    [self.homeManager addHomeWithName:@"you_home_name"
                          geoName:@"city_name"
                            rooms:@[@"room_name"]
                         latitude:lat
                        longitude:lon
                          success:^(double homeId) {

        // homeId 创建的家庭的 homeId
        NSLog(@"add home success");
    } failure:^(NSError *error) {
        NSLog(@"add home failure: %@", error);
    }];
}
```

Swift:

```swift
 func addHome() {
    homeManager.addHome(withName: "you_home_name", 
                         geoName: "city_name", 
                           rooms: ["room_name"], 
                        latitude: lat, 
                       longitude: lon, 
                         success: { (homeId) in
        // homeId 创建的家庭的 homeId
        print("add home success")
    }) { (error) in
        if let e = error {
            print("add home failure: \(e)")
        }
    }
}
```




### 家庭列表信息变化回调

实现 `TuyaSmartHomeManagerDelegate` 代理协议后，可以在家庭列表更变的回调中进行处理。



#### 新增一个家庭回调

**接口说明**

```objective-c
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home;
```

**参数说明**

| 参数    | 说明           |
| ------- | -------------- |
| manager | 家庭管理类实例 |
| home    | 添加的家庭模型 |



#### 删除一个家庭回调

**接口说明**

```objective-c
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId;
```

**参数说明**

| 参数    | 说明            |
| ------- | --------------- |
| manager | 家庭管理类实例  |
| homeId  | 被删除的家庭 Id |



#### MQTT 服务连接成功回调

**接口说明**

```objective-c
- (void)serviceConnectedSuccess;
```

**示例代码**

Objc:

```objective-c
#pragma mark - TuyaSmartHomeManagerDelegate


// 添加一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {

}

// 删除一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {

}

// MQTT连接成功
- (void)serviceConnectedSuccess {
    // 刷新当前家庭UI
}
```

Swift:

```swift
extension ViewController: TuyaSmartHomeManagerDelegate {
    
    // 添加一个家庭
    func homeManager(_ manager: TuyaSmartHomeManager!, didAddHome home: TuyaSmartHomeModel!) {
        
    }
    
    // 删除一个家庭
    func homeManager(_ manager: TuyaSmartHomeManager!, didRemoveHome homeId: Int64) {
        
    }
    
    // MQTT连接成功
    func serviceConnectedSuccess() {
        // 刷新当前家庭UI
    }
    
}
```




## 家庭信息管理

主要功能：用来获取和修改，解散家庭。获取，添加和删除家庭的成员。新增，解散房间，房间进行排序。

单个家庭信息管理相关的所有功能对应 `TuyaSmartHome` 类，需要使用正确的家庭 ID 进行初始化。错误的家庭 ID 可能会导致初始化失败，返回 `nil`。

初始化 home 对象之后需要获取家庭的详情接口 `getHomeDetailWithSuccess:failure:`，home 实例对象中的属性 homeModel、roomList、deviceList、groupList 才有数据。

|     类名(协议名)      |                  说明                  |
| :-------------------: | :------------------------------------: |
|     TuyaSmartHome     | 获取和修改家庭信息，管理房间和家庭成员 |
| TuyaSmartHomeDelegate |           家庭下信息变更回调           |



### 获取家庭的详细信息

**接口说明**

```objective-c
- (void)getHomeDetailWithSuccess:(void (^)(TuyaSmartHomeModel *homeModel))success
                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)getHomeDetailInfo {
	self.home = [TuyaSmartHome homeWithHomeId:homeId];
	[self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        // homeModel 家庭信息
        NSLog(@"get home detail success");
    } failure:^(NSError *error) {
        NSLog(@"get home detail failure: %@", error);
    }];
}
```

Swift:

```swift
func getHomeDetailInfo() {
    home?.getDetailWithSuccess({ (homeModel) in
        print("get home detail success")
    }, failure: { (error) in
        if let e = error {
            print("get home detail failure: \(e)")
        }
    })
}
```

 

### 修改家庭信息

**接口说明**

```objective-c
- (void)updateHomeInfoWithName:(NSString *)homeName
                       geoName:(NSString *)geoName
                      latitude:(double)latitude
                     longitude:(double)longitude
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**参数说明**

| 参数      | 说明     |
| --------- | -------- |
| homeName  | 家庭名称 |
| geoName   | 地址名称 |
| latitude  | 地址纬度 |
| longitude | 地址经度 |
| success   | 成功回调 |
| failure   | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)updateHomeInfo {
    self.home = [TuyaSmartHome homeWithHomeId:homeId];
    [self.home updateHomeInfoWithName:@"new_home_name" geoName:@"city_name" latitude:lat longitude:lon success:^{
        NSLog(@"update home info success");
    } failure:^(NSError *error) {
        NSLog(@"update home info failure: %@", error);
    }];
}
```

Swift:

```swift
func updateHomeInfo() {
    home?.updateInfo(withName: "new_home_name", geoName: "city_name", latitude: lat, longitude: lon, success: {
        print("update home info success")
    }, failure: { (error) in
        if let e = error {
            print("update home info failure: \(e)")
        }
    })
}
```



### 解散家庭

**接口说明**

```objective-c
- (void)dismissHomeWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)dismissHome {

	[self.home dismissHomeWithSuccess:^() {
        NSLog(@"dismiss home success");
    } failure:^(NSError *error) {
        NSLog(@"dismiss home failure: %@", error);
    }];
}
```

Swift:

```swift
func dismissHome() {
    home?.dismiss(success: {
        print("dismiss home success")
    }, failure: { (error) in
        if let e = error {
            print("dismiss home failure: \(e)")
        }
    })
}
```



### 新增房间

**接口说明**

```objective-c
- (void)addHomeRoomWithName:(NSString *)name
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| name    | 房间名称 |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)addHomeRoom {
    [self.home addHomeRoomWithName:@"room_name" success:^{
        NSLog(@"add room success");
    } failure:^(NSError *error) {
        NSLog(@"add room failure: %@", error);
    }];
}
```

Swift:

```swift
func addHomeRoom() {
    home?.addRoom(withName: "room_name", success: {
        print("add room success")
    }, failure: { (error) in
        if let e = error {
            print("add room failure: \(e)")
        }
    })
}
```



### 删除房间

**接口说明**

```objective-c
- (void)removeHomeRoomWithRoomId:(long long)roomId
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| roomId  | 房间ID   |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)removeHomeRoom {
    [self.home removeHomeRoomWithRoomId:roomId success:^{
        NSLog(@"remove room success");
    } failure:^(NSError *error) {
        NSLog(@"remove room failure: %@", error);
    }];
}
```

Swift:

```swift
func removeHomeRoom() {
    home?.removeRoom(withRoomId: roomId, success: {
        print("remove room success")
    }, failure: { (error) in
        if let e = error {
            print("remove room failure: \(e)")
        }
    })
}
```



### 房间排序

**接口说明**

```objective-c
- (void)sortRoomList:(NSArray <TuyaSmartRoomModel *> *)roomList
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明         |
| -------- | ------------ |
| roomList | 房间模型列表 |
| success  | 成功回调     |
| failure  | 失败回调     |

**示例代码**

Objc:

```objective-c
- (void)sortHomeRoom {
    [self.home sortRoomList:(NSArray<TuyaSmartRoomModel *> *) success:^{
        NSLog(@"sort room success");
    } failure:^(NSError *error) {
        NSLog(@"sort room failure: %@", error);
    }];
}
```

Swift:

```swift
func sortHomeRoom() {
    home?.sortRoomList([TuyaSmartRoomModel]!, success: {
        print("sort room success")
    }, failure: { (error) in
        if let e = error {
            print("sort room failure: \(e)")
        }
    })
}
```



### 家庭成员管理

家庭成员管理相关的所有功能对应 `TuyaSmartHome` 和  `TuyaSmartHomeMember` 类，成员角色类型 TYHomeRoleType

|    类名(协议名)     |     说明     |
| :-----------------: | :----------: |
| TuyaSmartHomeMember | 家庭成员管理 |



#### 添加家庭成员

> 拥有者 (TYHomeRoleType_Owner) 可以添加管理员及以下角色，管理员 (TYHomeRoleType_Admin) 仅仅可以添加普通成员及以下角色

**接口说明**

`TuyaSmartHomeAddMemberRequestModel` 中 autoAccept 用于控制受是否需要受邀请者同意，若设置为 NO 则受邀请者需要调用 `TuyaSmartHome - joinFamilyWithAccept:success:failure:` 接口同意后才能加入该家庭

```objective-c
- (void)addHomeMemberWithAddMemeberRequestModel:(TuyaSmartHomeAddMemberRequestModel *)requestModel success:(TYSuccessDict)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数         | 说明             |
| ------------ | ---------------- |
| requestModel | 添加成员请求模型 |
| success      | 成功回调         |
| failure      | 失败回调         |

**TuyaSmartHomeAddMemberRequestModel 数据模型**

| 字段        | 类型           | 描述                                                         |
| ----------- | -------------- | ------------------------------------------------------------ |
| name        | NSString       | 为受邀请者设置的昵称                                         |
| account     | NSString       | 受邀请账号                                                   |
| countryCode | NSString       | 受邀请者账号对应国家码                                       |
| role        | TYHomeRoleType | 成员角色                                                     |
| headPic     | UIImage        | 为受邀请者设置的头像 nil 时使用受邀请者个人头像              |
| autoAccept  | BOOL           | 是否需要受邀请者同意接受邀请 YES-受邀请账号自动接受该家庭邀请，无需受邀请者确认 NO-需要受邀请者同意后才可加入该家庭 |

**示例代码**

Objc:

```objective-c
- (void)addShare {
    [self.smartHome addHomeMemberWithAddMemeberRequestModel:requestModel success:^(NSDictionary *dict) {
        NSLog(@"addNewMember success");
    } failure:^(NSError *error) {
        NSLog(@"addNewMember failure");
    }];
}
```

Swift:

```swift
func addShare() {
    home?.addHomeMember(requestModel: requestModel, success: {
        print("addNewMember success")
    }, failure: { (error) in
        if let e = error {
            print("addNewMember failure: \(e)")
        }
    })
}
```



#### 删除家庭成员

> 拥有者 (TYHomeRoleType_Owner) 可以删除管理员及以下角色，管理员 (TYHomeRoleType_Admin) 仅仅可以删除普通成员及以下角色
>

**接口说明**

若成员传入自身 memberId，家庭管理员，普通成员，自定义角色，调用此接口为离开家庭，此时该家庭未解散，设备也不会被重置；拥有者为解散家庭，同时该家庭下所有设备会被重置，效果与上文解散家庭一致。

```objective-c
- (void)removeHomeMemberWithMemberId:(long long)memberId
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| memberId | 家庭成员Id |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

Objc:

```objective-c
- (void)removeMember:(TuyaSmartHomeMemberModel *)memberModel {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	[self.homeMember removeHomeMemberWithMemberId:memberModel.memberId success:^{
        NSLog(@"removeMember success");
    } failure:^(NSError *error) {
        NSLog(@"removeMember failure: %@", error);
    }];
}
```

Swift:

```swift
func removeMember(_ memberModel: TuyaSmartHomeMemberModel) {
    homeMember?.removeHomeMember(withMemberId: memberModel.memberId, success: {
        print("removeMember success")
    }, failure: { (error) in
        if let e = error {
            print("removeMember failure: \(e)")
        }
    })
}
```



#### 获取家庭成员列表

**接口说明**

```objective-c
- (void)getHomeMemberListWithSuccess:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)initMemberList {
  //	_home = [TuyaSmartHome homeWithHomeId:homeId];
    [_home getHomeMemberListWithSuccess:^(NSArray<TuyaSmartHomeMemberModel *> *memberList) {
        NSLog(@"getMemberList success: %@", memberList);
    } failure:^(NSError *error) {
        NSLog(@"getMemberList failure");
    }];
}
```

Swift:

```swift
func initMemberList() {
    home.getHomeMemberList(withSuccess: { memberList in
        print("getMemberList success: \(memberList)")
    }, failure: { (error) in
        if let e = error {
            print("getMemberList failure: \(e)")
        }
    })
}
```



#### 更新家庭成员的信息

> 拥有者 (TYHomeRoleType_Owner) 可以修改管理员及以下角色，管理员 (TYHomeRoleType_Admin) 仅仅可以修改普通成员及以下角色

**接口说明**

```objective-c
- (void)updateHomeMemberInfoWithMemberRequestModel:(TuyaSmartHomeMemberRequestModel *)memberRequestModel success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数               | 说明             |
| ------------------ | ---------------- |
| memberRequestModel | 家庭成员请求模型 |
| success            | 成功回调         |
| failure            | 失败回调         |

**示例代码**

Objc:

```objective-c
- (void)modifyMemberName:(TuyaSmartHomeMemberModel *)memberModel name:(NSString *)name {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
  TuyaSmartHomeMemberRequestModel *requestModel = [[TuyaSmartHomeMemberRequestModel alloc] init];
	[self.homeMember updateHomeMemberInfoWithMemberRequestModel:requestModel  success:^{
        NSLog(@"modifyMemberName success");
    } failure:^(NSError *error) {
        NSLog(@"modifyMemberName failure: %@", error);
    }];
}
```

Swift:

```swift
func modifyMember(_ memberModel: TuyaSmartHomeMemberModel, name: String) {
    homeMember?.updateHomeMemberName(withMemberRequestModel:requestModel, success: {
        print("modifyMemberName success")
    }, failure: { (error) in
        if let e = error {
            print("modifyMemberName failure: \(e)")
        }
    })
}
```



####  接受或拒绝家庭邀请

**接口说明**

成员是否接受该家庭的邀请对应 `TuyaSmartHomeModel` 下的 dealStatus，受邀状态会分别对应TYHomeStatusPending、TYHomeStatusAccept、TYHomeStatusReject，未接受加入的家庭成员将无法使用该家庭下的设备等功能，拒绝加入家庭后将无法在获取家庭列表接口中获取到该家庭信息。

```objective-c
- (void)joinFamilyWithAccept:(BOOL)accept
                     success:(TYSuccessBOOL)success
                     failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| accept  | 是否接受 |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)initMemberList {
  //	_home = [TuyaSmartHome homeWithHomeId:homeId];
  	[_home joinFamilyWithAccept:YES success:^(BOOL result) {
        NSLog(@"join success");
    } failure:^(NSError *error) {
        NSLog(@"join failure");
    }];
}
```
Swift:

```swift
func initMemberList(_ memberModel: TuyaSmartHomeMemberModel) {
    home?.joinFamilyWithAccept(true, success: { (result: Bool) in
        print("join success")
    }, failure: { (error) in
        if let e = error {
            print("join failure: \(e)")
        }
    })
}
```



###对家庭下设备和群组进行排序

**接口说明**

```objective-c
- (void)sortDeviceOrGroupWithOrderList:(NSArray<NSDictionary *> *)orderList
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;
```

**参数说明**

| 参数      | 说明               |
| --------- | ------------------ |
| orderList | 设备或群组排序列表 |
| success   | 成功回调           |
| failure   | 失败回调           |

**示例代码**

Objc:

```objective-c
// orderList: [@{@"bizId": @"XXX", @"bizType": @"XXX"},@{@"bizId": @"XXX",@"bizType": @"XXX"}] 其中bizId为设备的devId或群组的groupId, device的bizType = @"6" group的bizType = @"5"
- (void)sortDeviceOrGroupWithOrderList:(NSArray<NSDictionary *> *)orderList {
	[self.home sortDeviceOrGroupWithOrderList:orderList success:^ {
        NSLog(@"sort device or group success");
    } failure:^(NSError *error) {
        NSLog(@"sort device or group failure: %@", error);
    }];
}
```

Swift:

```swift
func sortDeviceOrGroup(withOrderList orderList: [[AnyHashable : Any]]?) {
    home.sortDeviceOrGroup(withOrderList: orderList, success: {
        print("sort device or group success")
    }, failure: { error in
        if let error = error {
            print("sort device or group failure: \(error)")
        }
    })
}
```



### 单个家庭信息变化的回调

实现 `TuyaSmartHomeDelegate` 代理协议后，可以在单个家庭信息更变的回调中进行处理。

**示例代码**

Objc:

```objective-c
- (void)initHome {
    self.home = [TuyaSmartHome homeWithHomeId:homeId];
    self.home.delegate = self;
}

#pragma mark - TuyaSmartHomeDelegate

// 家庭的信息更新，例如name
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self reload];
}

// 我收到的共享设备列表变化
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
    [self reload];
}

// 家庭下新增房间代理回调
- (void)home:(TuyaSmartHome *)home didAddRoom:(TuyaSmartRoomModel *)room {
  	[self reload];
}

// 家庭下删除房间代理回调
- (void)home:(TuyaSmartHome *)home didRemoveRoom:(long long)roomId {
  	[self reload];
}

// 房间信息变更，例如name
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

// 房间与设备，群组的关系变化
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

// 添加设备
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self reload];
}

// 删除设备
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self reload];
}

// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self reload];
}

// 家庭下设备的 dps 变化代理回调
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self reload];
}

// 添加群组
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self reload];
}

// 删除群组
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reload];
}

// 群组信息更新，例如name
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reload];
}

// 家庭下群组 dps 变化代理回调
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps {
    [self reload];
}

// the delegate of warning information update
// 家庭下设备的告警信息变化的代理回调
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device warningInfoUpdate:(NSDictionary *)warningInfo {
	//...  
}

// the delegate of device firmware upgrade status update
// 家庭下设备升级状态的回调
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device upgradeStatus:(TuyaSmartDeviceUpgradeStatus)upgradeStatus {
  	//...
}
```

Swift:

```swift
var home: TuyaSmartHome?

extension ViewController: TuyaSmartHomeDelegate {
  
  func initHome() {
      home = TuyaSmartHome(homeId: homeId)
      home?.delegate = self
  }
  
  // 家庭的信息更新，例如name
  func homeDidUpdateInfo(_ home: TuyaSmartHome!) {
//        reload()
  }

  // 我收到的共享设备列表变化
  func homeDidUpdateSharedInfo(_ home: TuyaSmartHome!) {

  }

  // 家庭下新增房间代理回调
  func home(_ home: TuyaSmartHome!, didAddRoom room: TuyaSmartRoomModel!) {
      //...
  }

  // 家庭下删除房间代理回调
  func home(_ home: TuyaSmartHome!, didRemoveRoom roomId: int32!) {
      //...
  }

  // 房间信息变更，例如name
  func home(_ home: TuyaSmartHome!, roomInfoUpdate room: TuyaSmartRoomModel!) {
//        reload()/
  }

  // 房间与设备，群组的关系变化
  func home(_ home: TuyaSmartHome!, roomRelationUpdate room: TuyaSmartRoomModel!) {

  }

  // 添加设备
  func home(_ home: TuyaSmartHome!, didAddDeivice device: TuyaSmartDeviceModel!) {

  }

  // 删除设备
  func home(_ home: TuyaSmartHome!, didRemoveDeivice devId: String!) {

  }

  // 设备信息更新，例如name
  func home(_ home: TuyaSmartHome!, deviceInfoUpdate device: TuyaSmartDeviceModel!) {

  }

  // 家庭下设备的 dps 变化代理回调
  func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, dpsUpdate dps: [AnyHashable : Any]!) {
      //...
  }

  // 添加群组
  func home(_ home: TuyaSmartHome!, didAddGroup group: TuyaSmartGroupModel!) {

  }

  // 删除群组
  func home(_ home: TuyaSmartHome!, didRemoveGroup groupId: String!) {

  }

  // 群组信息更新，例如name
  func home(_ home: TuyaSmartHome!, groupInfoUpdate group: TuyaSmartGroupModel!) {

  }

  // 家庭下群组的 dps 变化代理回调
  func home(_ home: TuyaSmartHome!, group: TuyaSmartGroupModel!, dpsUpdate dps: [AnyHashable : Any]!) {
			//...
  }
  
  // 家庭下设备的告警信息变化的代理回调
  func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, warningInfoUpdate warningInfo: [AnyHashable : Any]!) {
    	//...
  }
  
  // 家庭下设备升级状态的回调
  func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, upgradeStatus status TuyaSmartDeviceUpgradeStatus) {
    	//....
  }
  
}
```



### 房间信息管理

单个房间信息管理相关的所有功能对应 `TuyaSmartRoom` 类，需要使用正确的 roomId 进行初始化。错误的 roomId 可能会导致初始化失败，返回 `nil`。

| 类名(协议名)  |           说明           |
| :-----------: | :----------------------: |
| TuyaSmartRoom | 房间信息及房间内设备管理 |

#### 更新房间名称

**接口说明**

```objective-c
- (void)updateRoomName:(NSString *)roomName success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明     |
| -------- | -------- |
| roomName | 房间名称 |
| success  | 成功回调 |
| failure  | 失败回调 |

Objc:

```objective-c
- (void)updateRoomName {
    [self.room updateRoomName:@"new_room_name" success:^{
        NSLog(@"update room name success");
    } failure:^(NSError *error) {
        NSLog(@"update room name failure: %@", error);
    }];
}
```

Swift:

```swift
func updateRoomName() {
    room?.updateName("new_room_name", success: {
        print("update room name success")
    }, failure: { (error) in
        if let e = error {
            print("update room name failure: \(e)")
        }
    })
}
```



#### 添加设备到房间

**接口说明**

```objective-c
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明     |
| -------- | -------- |
| deviceId | 设备 Id  |
| success  | 成功回调 |
| failure  | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)addDevice {
    [self.room addDeviceWithDeviceId:@"devId" success:^{
        NSLog(@"add device to room success");
    } failure:^(NSError *error) {
        NSLog(@"add device to room failure: %@", error);
    }];
}
```

Swift:

```swift
func addDevice() {
    room?.addDevice(withDeviceId: "your_devId", success: {
        print("add device to room success")
    }, failure: { (error) in
        if let e = error {
            print("add device to room failure: \(e)")
        }
    })
}
```



#### 从房间中移除设备

**接口说明**

```objective-c
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明     |
| -------- | -------- |
| deviceId | 设备 Id  |
| success  | 成功回调 |
| failure  | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)removeDevice {
    [self.room removeDeviceWithDeviceId:@"devId" success:^{
        NSLog(@"remove device from room success");
    } failure:^(NSError *error) {
        NSLog(@"remove device from room failure: %@", error);
    }];
}
```

Swift:

```swift
func removeDevice() {
    room?.removeDevice(withDeviceId: "your_devId", success: {
        print("remove device from room success")
    }, failure: { (error) in
        if let e = error {
            print("remove device from room failure: \(e)")
        }
    })
}
```



#### 添加群组到房间

**接口说明**

```objective-c
- (void)addGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| groupId | 群组 Id  |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)addGroup {
    [self.room addGroupWithGroupId:@"groupId" success:^{
        NSLog(@"add group to room success");
    } failure:^(NSError *error) {
        NSLog(@"add group to room failure: %@", error);
    }];
}
```

Swift:

```swift
func addGroup() {
    room?.addGroup(withGroupId: "your_groupId", success: {
        print("add group to room success")
    }, failure: { (error) in
        if let e = error {
            print("add group to room failure: \(e)")
        }
    })
}
```



#### 从房间中移除群组

**接口说明**

```objective-c
- (void)removeGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| groupId | 群组 Id  |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

Objc:

```objective-c
- (void)removeGroup {
    [self.room removeGroupWithGroupId:@"groupId" success:^{
        NSLog(@"remove group from room success");
    } failure:^(NSError *error) {
        NSLog(@"remove group from room failure: %@", error);
    }];
}
```

Swift:

```swift
func removeGroup() {
    room?.removeGroup(withDeviceId: "your_devId", success: {
        print("remove device from room success")
    }, failure: { (error) in
        if let e = error {
            print("remove device from room failure: \(e)")
        }
    })
}
```



#### 批量修改房间与群组、设备的关系

**接口说明**

```objective-c
- (void)saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数            | 说明                   |
| --------------- | ---------------------- |
| deviceGroupList | 设备 Id 或群组 Id 列表 |
| success         | 成功回调               |
| failure         | 失败回调               |

**示例代码**

Objc:

```objective-c
- (void)saveBatchRoomRelation {
    [self.room saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList success:^{
        NSLog(@"save batch room relation success");
    } failure:^(NSError *error) {
        NSLog(@"save batch room relation failure: %@", error);
    }];
}
```

Swift:

```swift
func saveBatchRoomRelation() {
    room?.saveBatchRoomRelation(withDeviceGroupList: [String]!, success: {
        print("save batch room relation success")
    }, failure: { (error) in
        if let e = error {
            print("save batch room relation failure: \(e)")
        }
    })
}
```

### 家庭天气

####  获取家庭天气简要参数

**接口说明**

该请求返回家庭所在城市的简要天气参数，如城市名称、当天的天气状况(晴、多云、雨等)、天气图片信息。

```objective-c
- (void)getHomeWeatherSketchWithSuccess:(void(^)(TuyaSmartWeatherSketchModel *))success
                                failure:(TYFailureError)failure;
```

**参数说明**


| 参数            | 说明                   |
| ---------------| ----------------------|
| success         | 成功回调               |
| failure         | 失败回调               |


**示例代码**

Objc:

```objective-c
- (void)getHomeWeatherSketch {
    [self.home getHomeWeatherSketchWithSuccess:^(TuyaSmartWeatherSketchModel *weatherSketchModel) {
        NSLog(@"success get weather summary model: %@",weatherSketchModel);
    } failure:^(NSError *error) {
        NSLog(@"failure with error: %@", error);
    }];
}
```
Swift:

```swift
func getHomeWeatherSketch() {
    home.getWeatherSketch(success: { (weatherSketchModel) in
        print("success get weather summary model: \(weatherSketchModel)");
    }) { (e) in
        print("failure with error: \(e)")
    };
}
```


####   获取家庭天气详细参数

**接口说明**

获取家庭天气详细参数,如温度、湿度、紫外线指数、空气质量等。

optionModel 可以为nil。若为nil，返回的参数会上一次请求成功的参数设置，若只改变一种单位设置进行请求，另外两种也依然会保留上一次请求成功的参数设置。
由于天气服务在不同地区的使用的服务不同，不同地区返回的参数有可能不同。
特别的，如果当前家庭账号位置在中国，那么不会返回风速和气压信息。

```
- (void)getHomeWeatherDetailWithOption:(TuyaSmartWeatherOptionModel *)optionModel
                               success:(void(^)(NSArray<TuyaSmartWeatherModel *> *))success
                               failure:(TYFailureError)failure;
```

**参数说明**

| 参数            | 说明                   |
| --------------- | ---------------------- |
| optionModel         | 天气详情参数单位配置              |
| success         | 成功回调               |
| failure         | 失败回调               |

**示例代码**

Objc:

```objective-c
- (void)getHomeWeatherDetail {
    [self.home getHomeWeatherDetailWithOption:optionModel 
                                      success:^(NSArray<TuyaSmartWeatherModel *> *weatherModels) {
          NSLog(@"success get weather model: %@",weatherModels);
                                    } failure:^(NSError *error) {
          NSLog(@"failure with error: %@", error);
    }];
}
```

Swift:

```swift
func getHomeWeatherDetail() {
    let optionModel = TuyaSmartWeatherOptionModel()
    // do some optionModel config
    home.getWeatherDetail(withOption: optionModel, success: { (weatherSketchModel) in
        print("success get weather summary model: \(weatherSketchModel)");
    }) { (error) in
        print("failure with error: \(error)")
    }
}
```
