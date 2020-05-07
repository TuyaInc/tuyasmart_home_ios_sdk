## Home Relationship Management

After login, user shall use the `TuyaSmartHomeManager` to obtain information of home list and initiate one home `TuyaSmartHome` and attain details of a home and manage and control devices in the home.

| Class Name(Protocol Name)       | Description                                                 |
| ------------------------------- | ----------------------------------------------------------- |
| TuyaSmartHomeManager(Singleton) | Fetch home list, sort home, add home                        |
| TuyaSmartHomeManagerDelegate    | Home increase or decrease，MQTT connection success callback |



### Obtain the Home List

Fetch home list, return data is just simple information of home. If you want to get the details of a specific home, you need to go to `TuyaSmartHome` to initialize a home and call the interface getHomeDetailWithSuccess: failure:

**Declaration**

```objective-c
- (void)getHomeListWithSuccess:(void(^)(NSArray <TuyaSmartHomeModel *> *homes))success
                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| success    | Success callback |
| failure    | Failure callback |

**Example**

Objc:

```objective-c
- (void)getHomeList {

	[self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        // home list
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
        // home list
    }) { (error) in
        if let e = error {
            print("get home list failure: \(e)")
        }
    }
}
```



### Add Home

**Declaration**

```objective-c
- (void)addHomeWithName:(NSString *)homeName
                geoName:(NSString *)geoName
                  rooms:(NSArray <NSString *>*)rooms
               latitude:(double)latitude
              longitude:(double)longitude
                success:(TYSuccessLongLong)success
                failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| homeName   | Home name        |
| geoName    | Address name     |
| rooms      | Room name list   |
| latitude   | Latitude         |
| longitude  | Longitude        |
| success    | Success callback |
| failure    | Failure callback |

**Example**

Objc:

```objective-c
- (void)addHome {

    [self.homeManager addHomeWithName:@"you_home_name"
                          geoName:@"city_name"
                            rooms:@[@"room_name"]
                         latitude:lat
                        longitude:lon
                          success:^(double homeId) {

        NSLog(@"add home success");
    } failure:^(NSError *error) {
        NSLog(@"add home failure: %@", error);
    }];
}
```

Swift:

```swift
 func addHome() {
    homeManager.addHome(withName: "you_home_name", geoName: "city_name", rooms: ["room_name"], latitude: lat, longitude: lon, success: { (homeId) in
        print("add home success")
    }) { (error) in
        if let e = error {
            print("add home failure: \(e)")
        }
    }
}
```



### Callback of Information in the Home List

After the `TuyaSmartHomeManagerDelegate` delegate protocol is realized, user can proceed operations in the home list change.



#### Callback of Add a Home

**Declaration**

```objective-c
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home;
```

**Parameters**

| Parameters | Description           |
| ---------- | --------------------- |
| manager    | Home manager instance |
| home       | Home model            |



#### Callback of Remove a Home 

**Declaration**

```objective-c
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId;
```

**Parameters**

| Parameters | Description           |
| ---------- | --------------------- |
| manager    | Home manager instance |
| homeId     | Removed home Id       |



#### Callback of MQTT Service Connection Success

**Declaration**

```objective-c
- (void)serviceConnectedSuccess;
```

**Example**

Objc:

```objective-c
#pragma mark - TuyaSmartHomeManagerDelegate


// Add a home
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {

}

// Delete a home
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {

}

// The MQTT connection succeeds.
- (void)serviceConnectedSuccess {
    // Update the current home UI
}
```

Swift:

```swift
extension ViewController: TuyaSmartHomeManagerDelegate {
    
    // Add a home
    func homeManager(_ manager: TuyaSmartHomeManager!, didAddHome home: TuyaSmartHomeModel!) {
        
    }
    
    // Delete a home
    func homeManager(_ manager: TuyaSmartHomeManager!, didRemoveHome homeId: Int64) {
        
    }
    
    // The MQTT connection succeeds.
    func serviceConnectedSuccess() {
        // Update the current home UI
    }
    
}
```



## Home Information Management

Main function: it is used to obtain, change and dismiss a home. Obtain, add and delete member of a home. Add, dismiss and remove room.
The home ID needs to be used to initiate all `TuyaSmartHome` classes related to all functions for home information management. Wrong home ID may cause initiation failure, and the nil will be returned.

After initializing the home object, you need to get the details interface of the home (getHomeDetailWithSuccess: failure :).  the properties homeModel, roomList, deviceList, groupList in the home instance object have data.

| Class Name(protocol Name) | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| TuyaSmartHome             | Get and modify home information, manage rooms and home members |
| TuyaSmartHomeDelegate     | Home information change callback                             |



### Obtain Detail Information of Home

**Declaration**

```objective-c
- (void)getHomeDetailWithSuccess:(void (^)(TuyaSmartHomeModel *homeModel))success
                         failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| success    | Success callback |
| failure    | Failure callback |

**Example**

Objc:

```objective-c
- (void)getHomeDetailInfo {
	self.home = [TuyaSmartHome homeWithHomeId:homeId];
	[self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        // homeModel home information
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



### Modify Home Information

**Declaration**

```objective-c
- (void)updateHomeInfoWithName:(NSString *)homeName
                       geoName:(NSString *)geoName
                      latitude:(double)latitude
                     longitude:(double)longitude
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| homeName   | Home name        |
| geoName    | Address name     |
| latitude   | Latitude         |
| longitude  | Longitude        |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



### Dismiss Home

**Declaration**

```objective-c
- (void)dismissHomeWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



### Add Room

**Declaration**

```objective-c
- (void)addHomeRoomWithName:(NSString *)name
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| name       | Room name        |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



### Remove Room

**Declaration**

```objective-c
- (void)removeHomeRoomWithRoomId:(long long)roomId
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| roomId     | Room Id          |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



### Sort Rooms

**Declaration**

```objective-c
- (void)sortRoomList:(NSArray <TuyaSmartRoomModel *> *)roomList
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| roomList   | Room model list  |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



### Member Management

All functions related to home member management correspond to`TuyaSmartHome` and `TuyaSmartHomeMember` classes, member role type is `TYHomeRoleType`

| Class Name(Protocol Name) | Description            |
| ------------------------- | ---------------------- |
| TuyaSmartHomeMember       | Home member management |



#### Add Home Member

> ```
> The owner (TYHomeRoleType_Owner) can add the administrator and the following roles, and the administrator (TYHomeRoleType_Admin) can add only the ordinary members and the following roles
> ```

**Declaration**

The autoAccept in `TuyaSmartHomeAddMemberRequestModel` is used to control whether the invitee's consent is required. If it is set to NO, the invitee needs to call ` TuyaSmartHome `-joinFamilyWithAccept: success: failure: to accept before joining.

```objective-c
- (void)addHomeMemberWithAddMemeberRequestModel:(TuyaSmartHomeAddMemberRequestModel *)requestModel success:(TYSuccessDict)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters   | Description              |
| ------------ | ------------------------ |
| requestModel | Add member request model |
| success      | Success callback         |
| failure      | Failure callback         |

**TuyaSmartHomeAddMemberRequestModel**

| Parameters  | Type           | Description                                                  |
| ----------- | -------------- | ------------------------------------------------------------ |
| name        | NSString       | Invitee's nickname                                           |
| account     | NSString       | Invitee‘s account                                            |
| countryCode | NSString       | Invitee‘s account country code                               |
| role        | TYHomeRoleType | Home member role                                             |
| headPic     | UIImage        | Invitee‘s avatar, Use the invitee's profile picture when nil |
| autoAccept  | BOOL           | Does the invitee need to agree to accept the invitation      |

**Example**

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



#### Delete Home Member

> ```
> The owner (TYHomeRoleType_Owner) can add the administrator and the following roles, and the administrator (TYHomeRoleType_Admin) can add only the ordinary members and the following roles
> ```

**Declaration**

If members input their own memberId, home administrator, ordinary members, and custom roles, this interface is called to leave the family. At this time, the home is not disbanded, and the device will not be reset. The owner is the disbanded home, and the home All devices will be reset, with the same effect as the dismiss family above.

```objective-c
- (void)removeHomeMemberWithMemberId:(long long)memberId
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description       |
| ---------- | ----------------- |
| memberId   | Home member Id    |
| success    | Success  callback |
| failure    | Failure callback  |

**Example**

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



#### Get a List of Home Members

**Declaration**

```objective-c
- (void)getHomeMemberListWithSuccess:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



#### Update the Home Member's Information

> ```
> The owner (TYHomeRoleType_Owner) can add the administrator and the following roles, and the administrator (TYHomeRoleType_Admin) can add only the ordinary members and the following roles
> ```

**Declaration**

```objective-c
- (void)updateHomeMemberInfoWithMemberRequestModel:(TuyaSmartHomeMemberRequestModel *)memberRequestModel success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters         | Description                     |
| ------------------ | ------------------------------- |
| memberRequestModel | TuyaSmartHomeMemberRequestModel |
| success            | Success  callback               |
| failure            | Failure callback                |

**Example**

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



####  Accept or Reject Home Invitations

**Declaration**

Whether the member accepts the home‘s invitation corresponds to the dealStatus in TuyaSmartHomeModel, The invited state will correspond to TYHomeStatusPending、TYHomeStatusAccept、TYHomeStatusReject.

```objective-c
- (void)joinFamilyWithAccept:(BOOL)accept
                     success:(TYSuccessBOOL)success
                     failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description       |
| ---------- | ----------------- |
| accept     | Whether to accept |
| success    | Success callback  |
| failure    | Failure callback  |

**Example**

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



###Sort Devices and Groups 

**Declaration**

```objective-c
- (void)sortDeviceOrGroupWithOrderList:(NSArray<NSDictionary *> *)orderList
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description                               |
| ---------- | ----------------------------------------- |
| orderList  | Sort list of devices (or groups)          |
| success    | Success callback                          |
| failure    | Failure callback                          |

**Example**

Objc:

```objective-c
// orderList: [@{@"bizId": @"XXX", @"bizType": @"XXX"},@{@"bizId": @"XXX",@"bizType": @"XXX"}] bizId is devId or groupId, device's bizType = @"6" group's bizType = @"5"
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



### Callback of Information Change of Home

After the `TuyaSmartHomeDelegate` delegate protocol is realized, user can proceed operations in the home information change.

**Example**

Objc:

```objective-c
- (void)initHome {
    self.home = [TuyaSmartHome homeWithHomeId:homeId];
    self.home.delegate = self;
}

#pragma mark - TuyaSmartHomeDelegate

//Update information of home, such as name.
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self reload];
}

// Received change of shared device list.
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
    [self reload];
}

// the delegate when a new room is added.
- (void)home:(TuyaSmartHome *)home didAddRoom:(TuyaSmartRoomModel *)room {
  	[self reload];
}

// the delegate when an existing room is removed.
- (void)home:(TuyaSmartHome *)home didRemoveRoom:(long long)roomId {
  	[self reload];
}

// room information change, such as name.
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

// The change of relation between  room and devices and group.
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

//Add device
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self reload];
}

//Remove Device
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self reload];
}

//Update information of device, such as name.
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self reload];
}

// the delegate of device dps update.
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self reload];
}

// Add group.
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self reload];
}

// Remove group.
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reload];
}

//Update information of group, such as name.
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reload];
}

// the delegate of group dps update.
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps {
    [self reload];
}

// the delegate of warning information update
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device warningInfoUpdate:(NSDictionary *)warningInfo {
	//...  
}

// the delegate of device firmware upgrade status update
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
    
    // Update information of home, such as name.
    func homeDidUpdateInfo(_ home: TuyaSmartHome!) {
//        reload()
    }

    // Received change of shared device list.
    func homeDidUpdateSharedInfo(_ home: TuyaSmartHome!) {
        
    }
    
    // the delegate when a new room is added.
    func home(_ home: TuyaSmartHome!, didAddRoom room: TuyaSmartRoomModel!) {
          //...
    }

    // the delegate when an existing room is removed.
    func home(_ home: TuyaSmartHome!, didRemoveRoom roomId: int32!) {
       //...
    }

    // room information change, such as name.
    func home(_ home: TuyaSmartHome!, roomInfoUpdate room: TuyaSmartRoomModel!) {
//        reload()/
    }
    
    // The change of relation between  room and devices and group.
    func home(_ home: TuyaSmartHome!, roomRelationUpdate room: TuyaSmartRoomModel!) {
        
    }
    
    // Add device
    func home(_ home: TuyaSmartHome!, didAddDeivice device: TuyaSmartDeviceModel!) {
        
    }
    
    // Remove Device
    func home(_ home: TuyaSmartHome!, didRemoveDeivice devId: String!) {
        
    }
    
    // Update information of device, such as name.
    func home(_ home: TuyaSmartHome!, deviceInfoUpdate device: TuyaSmartDeviceModel!) {
        
    }
    
    // the delegate of device dps update.
    func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, dpsUpdate dps: [AnyHashable : Any]!) {
         //...
    }

    // Add group.
    func home(_ home: TuyaSmartHome!, didAddGroup group: TuyaSmartGroupModel!) {
        
    }
    
    // Remove group.
    func home(_ home: TuyaSmartHome!, didRemoveGroup groupId: String!) {
        
    }
    
    // Update information of group, such as name.
    func home(_ home: TuyaSmartHome!, groupInfoUpdate group: TuyaSmartGroupModel!) {
        
    }

    // he delegate of group dps update.
    func home(_ home: TuyaSmartHome!, group: TuyaSmartGroupModel!, dpsUpdate dps: [AnyHashable : Any]!) {
        
    }

      // the delegate of warning information update
    func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, warningInfoUpdate warningInfo: [AnyHashable : Any]!) {
    	//...
    }
  
    //  the delegate of device firmware upgrade status update
    func home(_ home: TuyaSmartHome!, device: TuyaSmartDeviceModel!, upgradeStatus status TuyaSmartDeviceUpgradeStatus) {
    	//....
    }
    
}
```



### Room Information Management

The roomId needs to be used to initiate all `TuyaSmartRoom` classes related to all functions for room information management. Wrong roomId may cause initiation failure, and the `nil` will be returned.

| Class Name(Protocol Name) | Description                                                 |
| ------------------------- | ----------------------------------------------------------- |
| TuyaSmartRoom             | Room information and device or group management in the room |



#### Update Room Name

**Declaration**

```objective-c
- (void)updateRoomName:(NSString *)roomName success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| roomName   | Room name        |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



#### Add Device to a Room

**Declaration**

```objective-c
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description       |
| ---------- | ----------------- |
| deviceId   | Device Id         |
| success    | Success call back |
| failure    | Failure callback  |

**Example**

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



#### Remove Device from a Room

**Declaration**

```objective-c
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| deviceId   | Device Id        |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



#### Add Group in a Room

**Declaration**

```objective-c
- (void)addGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| groupId    | Group Id         |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



#### Remove Group in a Room

**Declaration**

```objective-c
- (void)removeGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| groupId    | Group Id         |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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



#### Change Relation Between Room and Groups and Devices in Batches

**Declaration**

```objective-c
- (void)saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;
```

**Parameters**

| Parameters      | Description                         |
| --------------- | ----------------------------------- |
| deviceGroupList | The list of device Id (or group Id) |
| success         | Success callback                    |
| failure         | Failure callback                    |

**Example**

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

### Home Weather

#### Get Home's Weather Simple Summary Parameters.

Sush as city name, state of weather(clear, cloudy, rainy, and so on),weather icon.

**Declaration**

```
- (void)getHomeWeatherSketchWithSuccess:(void(^)(TuyaSmartWeatherSketchModel *))success
                                                             failure:(TYFailureError)failure;
```


**Parameters**

| Parameters      | Description                         |
| --------------- | ----------------------------------- |
| success         | Success callback                    |
| failure         | Failure callback                    |


Parameter `TuyaSmartWeatherSketchModel` description：

| Parameters            | Description                   |
| ---------------| ----------------------|
| condition         | weather description               |
| iconUrl         | weather icon, highlight              |
| inIconUrl         | weather icon               |
| city         | city               |
| temp         | temperature               |

**Example**

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

#### Get Home's Weather Summary Parameters with More Detail.

Such as tempature, humidity, ultraviolet index, air quality.


**Declaration**

```
- (void)getHomeWeatherDetailWithOption:(TuyaSmartWeatherOptionModel *)optionModel
                               success:(void(^)(NSArray<TuyaSmartWeatherModel *> *))success
                               failure:(TYFailureError)failure;

```


| Parameters      | Description                         |
| --------------- | ----------------------------------- |
| optionModel         | Weather details unit configuration                   |
| success         | Success callback                    |
| failure         | Failure callback                    |



Before request, param `TuyaSmartWeatherOptionModel`  need config.

| Parameters            | Description                   |
| --------------- | ---------------------- |
| pressureUnit         | pressure unit             |
| windspeedUnit         | windspeed unit               |
| temperatureUnit         | temperature unit               |
| limit         | return weather description count,if limit = 0,return all weather description               |

return parameter `TuyaSmartWeatherModel`:

| Parameters            | Description                   |
| --------------- | ---------------------- |
| icon         | weahter icon             |
| name         | weahter name               |
| unit         | weahter parameter unit               |
| value         | weahter parameter value               |


**Example**

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



