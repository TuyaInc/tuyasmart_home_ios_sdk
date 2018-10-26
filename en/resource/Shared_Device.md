### Share devices (sharing based on device dimensions)

All functions related to the device sharing are realized by using the `TuyaSmartHomeDeviceShare` Class.

#### Add sharing


```objc

- (void)addMemberShare {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
    
    [self.deviceShare addShareWithHomeId:homeId countryCode:@"your_country_code" userAccount:@"user_account" devIds:(NSArray<NSString *> *) success:^(TuyaSmartShareMemberModel *model) {
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
    
```

#### Add sharing (add device for sharing)

```objc

- (void)addMemberShare {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
    
    [self.deviceShare addShareWithMemberId:memberId devIds:(NSArray<NSString *> *) success:^{
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
    
```


#### Obtain share member list

Obtain all active sharer user lists

```objc

- (void)getShareMemberList {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare getShareMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartShareMemberModel *> *list) {
        
        NSLog(@"getShareMemberList success");
    
    } failure:^(NSError *error) {
        
        NSLog(@"getShareMemberList failure: %@", error);

    }];
    
}
    
```

Obtain the list of all users that have received the shared devices.

```objc

- (void)getReceiveMemberList {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare getReceiveMemberListWithSuccess:^(NSArray<TuyaSmartShareMemberModel *> *list) {
        
        NSLog(@"getReceiveMemberList success");
    
    } failure:^(NSError *error) {
        
        NSLog(@"getReceiveMemberList failure: %@", error);

    }];
    
}
```

#### Obtain the shared data

Obtain the shared data of each active sharer

```objc

- (void)getShareMemberDetail {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare getShareMemberDetailWithMemberId:memberId success:^(TuyaSmartShareMemberDetailModel *model) {
    
        NSLog(@"getShareMemberDetail success");
        
    } failure:^(NSError *error) {

        NSLog(@"getShareMemberDetail failure: %@", error);

    }];
    
}
```


Obtain the shared data received by a device

```objc

- (void)getReceiveMemberDetail {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare getReceiveMemberDetailWithMemberId:memberId success:^(TuyaSmartReceiveMemberDetailModel *model) {
    
        NSLog(@"getReceiveMemberDetail success");
        
    } failure:^(NSError *error) {

        NSLog(@"getReceiveMemberDetail failure: %@", error);

    }];
    
}
```

#### Remove memeber

Delete active sharer

```objc

- (void)removeShareMember {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare removeShareMemberWithMemberId:memberId success:^{
        
        NSLog(@"removeShareMember success");

    } failure:^(NSError *error) {
    
        NSLog(@"removeShareMember failure: %@", error);

    }];
    
}
     
```


Remove member that receives the sharing

```objc

- (void)removeReceiveMember {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare removeReceiveShareMemberWithMemberId:memberId success:^{
        
        NSLog(@"removeReceiveMember success");

    } failure:^(NSError *error) {
    
        NSLog(@"removeReceiveMember failure: %@", error);

    }];
    
} 
```

#### Modify nickname

Modify nickname of active sharer

```objc

- (void)updateShareMemberName {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare renameShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
        NSLog(@"updateShareMemberName success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"updateShareMemberName failure: %@", error);

    }];
     
```

Modify nickname of the member that receives the sharing

```objc

- (void)updateReceiveMemberName {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare renameReceiveShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
        NSLog(@"updateReceiveMemberName success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"updateReceiveMemberName failure: %@", error);

    }];
     
}
```

#### Share device

Add device to be shared

```objc

- (void)addDeviceShare {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare addDeviceShareWithHomeId:homeId countryCode:@"country_code" userAccount:@"user_account" devId:@"dev_id" success:^(TuyaSmartShareMemberModel *model) {
        
        NSLog(@"addDeviceShare success");
                
    } failure:^(NSError *error) {
        
        NSLog(@"addDeviceShare failure: %@", error);
        
    }];
    
}
     
```


Remove device sharing

```objc

- (void)removeDeviceShare {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare removeDeviceShareWithMemberId:memberId devId:@"dev_id" success:^{
        
        NSLog(@"removeDeviceShare success");
                
    } failure:^(NSError *error) {
        
        NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
     
 }
```


Remove the received device for sharing

```objc

- (void)removeDeviceShare {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare removeReceiveDeviceShareWithDevId:@"dev_id" success:^{
        
        NSLog(@"removeDeviceShare success");
                
    } failure:^(NSError *error) {
        
        NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
    
}
     
```


#### Obtain device-sharing member list

```objc

- (void)getDeviceShareMemberList {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
    [self.deviceShare getDeviceShareMemberListWithDevId:@"dev_id" success:^(NSArray<TuyaSmartShareMemberModel *> *list) {
        
        NSLog(@"getDeviceShareMemberList success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"getDeviceShareMemberList failure: %@", error);
    
    }];
    
}
         
```

#### Obtain device sharing information

```objc

- (void)getShareInfo {
     //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
        
     [self.deviceShare getShareInfoWithDevId:@"dev_id" success:^(TuyaSmartReceivedShareUserModel *model) {
             
        NSLog(@"get shareInfo success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"get shareInfo failure: %@", error);
    
    }];
     
}
         
```