## Home management

After login, user shall use the `TuyaSmartHomeManager to obtain` information of home list and initiate one home `TuyaSmartHome` and attain details of a home and manage and control devices in the home.

### Callback of information in the home list

After the `TuyaSmartHomeManagerDelegate` delegate protocol is realized, user can proceed operations in the home list change.

Objc:

```objc
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


### Obtain the home list.

Objc:

```objc
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

### Add home

Objc:

```objc
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


## Home information management

Main function: it is used to obtain, change and dismiss a home. Obtain, add and delete member of a home. Add, dismiss and remove room.
The home ID needs to be used to initiate all TuyaSmartHome classes related to all functions for home information management. Wrong home ID may cause initiation failure, and the nil will be returned.

### Callback of information change of home

After the `TuyaSmartHomeDelegate` delegate protocol is realized, user can proceed operations in the home information change.

Objc:
```objc
- (void)initHome {
    self.home = [TuyaSmartHome homeWithHomeId:homeId];
    self.home.delegate = self;
}

#pragma mark - TuyaSmartHomeDelegate

//Update information of home, such as name.
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self reload];
}

// The change of relation between home and room.
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home {
    [self reload];
}

// Received change of shared device list.
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
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

//Update dp data of device.
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
    // The change of relation between home and room.
    func homeDidUpdateRoomInfo(_ home: TuyaSmartHome!) {
//        reload()
    }
    
    // Received change of shared device list.
    func homeDidUpdateSharedInfo(_ home: TuyaSmartHome!) {
        
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
    
    // Update dp data of device.
    func home(_ home: TuyaSmartHome!, group: TuyaSmartGroupModel!, dpsUpdate dps: [AnyHashable : Any]!) {
        
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
    
}
```

### Obtain information of home.

Objc:

```objc
- (void)getHomeDetailInfo {

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

### Update home information

Objc:

```objc
- (void)updateHomeInfo {
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

### Dismiss home

Objc:

```objc
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

### Add room

Objc:

```objc
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

### Remove room

Objc:

```objc
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

### Sort room

Objc:

```objc
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
### Home member management

All functions related to home member management correspond to`TuyaSmartHome` and `TuyaSmartHomeMember`classes

#### Add Home Member

Objc:

```objc
- (void)addShare {
  //	_home = [TuyaSmartHome homeWithHomeId:homeId];
    [_home addHomeMemberWithName:@"name" headPic:image countryCode:@"your_country_code" userAccount:@"account" isAdmin:YES success:^(NSDictionary *dict) {
        NSLog(@"addNewMember success");
    } failure:^(NSError *error) {
        NSLog(@"addNewMember failure: %@", error);
    }];
}
```

Swift:

```swift
func addShare() {
    home?.addHomeMember(withName:@"name", headPic:image, countryCode: "your_country_code", account: "account", isAdmin: true, success: {
        print("addNewMember success")
    }, failure: { (error) in
        if let e = error {
            print("addNewMember failure: \(e)")
        }
    })
}
```



#### Get a list of Home members

Objc:

```objc
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



#### Modify the home member's comment name and whether it's an administrator

Objc:

```objc
- (void)modifyMemberName:(TuyaSmartHomeMemberModel *)memberModel name:(NSString *)name {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember updateHomeMemberNameWithMemberId:memberModel.memberId name:name isAdmin:YES success:^{
        NSLog(@"modifyMemberName success");
    } failure:^(NSError *error) {
        NSLog(@"modifyMemberName failure: %@", error);
    }];
}
```

Swift:

```swift
func modifyMember(_ memberModel: TuyaSmartHomeMemberModel, name: String) {
    homeMember?.updateHomeMemberName(withMemberId: memberModel.memberId, name: name, isAdmin: true, success: {
        print("modifyMemberName success")
    }, failure: { (error) in
        if let e = error {
            print("modifyMemberName failure: \(e)")
        }
    })
}
```



#### Delete home members

Objc: 

```objc
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



####  Accept or reject home invitations

Objc:

```objc
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



## Room information management

The roomId needs to be used to initiate all `TuyaSmartRoom` classes related to all functions for room information management. Wrong roomId may cause initiation failure, and the `nil` will be returned.

### Update room name

Objc:

```objc
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

### Add device to a room

Objc:

```objc
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

### Remove device from a room

Objc:

```objc
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

### Add group in a room

Objc:

```objc
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

### Remove group in a room

Objc:

```objc
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

### Change relation between room and group and devices in batches.

Objc:

```objc
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

