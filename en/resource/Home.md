## Home information management


Main function: it is used to obtain, change and dismiss a home. Obtain, add and delete member of a home. Add, dismiss and remove room.
The home ID needs to be used to initiate all TuyaSmartHome classes related to all functions for home information management. Wrong home ID may cause initiation failure, and the nil will be returned. 


### Callback of information change of home

After the `TuyaSmartHomeDelegate` delegate protocol is realized, user can proceed operations in the home information change. 

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

// Momove group.
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reload];
}

//Update information of group, such as name.
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reload];
}
```

### Obtain information of home. 

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

### Update home information

```objc
- (void)updateHomeInfo {
    [self.home updateHomeInfoWithName:@"new_home_name" geoName:@"city_name" latitude:lat longitude:lon success:^{
        NSLog(@"update home info success");
    } failure:^(NSError *error) {
        NSLog(@"update home info failure: %@", error);
    }];
}

```

### Dismiss home

```objc
- (void)dismissHome {
    
    [self.home dismissHomeWithSuccess:^() {
        NSLog(@"dismiss home success");
    } failure:^(NSError *error) {
        NSLog(@"dismiss home failure: %@", error);
    }];
}
```


### Add room

```objc
- (void)addHomeRoom {
    [self.home addHomeRoomWithName:@"room_name" success:^{
        NSLog(@"add room success");
    } failure:^(NSError *error) {
        NSLog(@"add room failure: %@", error);
    }];
}
```

### Remove room

```objc
- (void)removeHomeRoom {
    [self.home removeHomeRoomWithRoomId:roomId success:^{
        NSLog(@"remove room success");
    } failure:^(NSError *error) {
        NSLog(@"remove room failure: %@", error);
    }];
}
```

### Sort room

```objc
- (void)sortHomeRoom {
    [self.home sortRoomList:(NSArray<TuyaSmartRoomModel *> *) success:^{
        NSLog(@"sort room success");
    } failure:^(NSError *error) {
        NSLog(@"sort room failure: %@", error);
    }];   
}
```

