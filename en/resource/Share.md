## Shared devices

Sometimes, you need to share some devices with your families, and they will solely have control permission to devices you have shared and cannot change names, remove devices, perform firmware upgrade and restore factory setting, etc. but send device control instructions and obtain status updating.

All functions related to device sharing correspond to the `TuyaSmart HomeDeviceShare'class

### Add device share

#### Add multiple device sharing (coverage)

Sharing multiple devices to users will override all previous user sharing

Objc:

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

Swift:

```swift
func addMemberShare() {
    deviceShare?.add(withHomeId: homeId, countryCode: "your_country_code", userAccount: "user_account", devIds: ["devIds"], success: { (memberModel) in
        print("addShare success")
    }, failure: { (error) in
        if let e = error {
            print("addShare failure: \(e)")
        }
    })
}
```



#### Add Shares (new, not overwriting old Shares)

Sharing multiple devices to users will add the devices to all user shareing

Objc:

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

Swift:

```swift
func addMemberShare() {
    deviceShare?.add(withMemberId: memberId, devIds: ["devIds"], success: {
        print("addShare success")
    }, failure: { (error) in
        if let e = error {
            print("addShare failure: \(e)")
        }
    })
}
```
#### Single Device Add Sharing

Objc:

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

Swift:

```swift
func addDeviceShare() {
    deviceShare?.add(withHomeId: homeId, countryCode: "country_code", userAccount: "user_account", devId: "dev_id", success: { (model) in
        print("addDeviceShare success")
    }, failure: { (error) in
        if let e = error {
            print("addDeviceShare failure: \(e)")
        }
    })
}
```



### Getting Shared Relationships

#### Get a list of all active shared users in the home

Objc:

```objc

- (void)getShareMemberList {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];

	[self.deviceShare getShareMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartShareMemberModel *> *list)

		NSLog(@"getShareMemberList success");

	} failure:^(NSError *error) {

		NSLog(@"getShareMemberList failure: %@", error);

	}];

}

```

Swift:

```swift
func getShareMemberList() {
    deviceShare?.getMemberList(withHomeId: homeId, success: { (list) in
        print("getShareMemberList success")
    }, failure: { (error) in
        if let e = error {
            print("getShareMemberList failure: \(e)")
        }
    })
}
```



#### Get a list of all shared users received

Objc:

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

Swift:

```swift
func getReceiveMemberList() {
    deviceShare?.getReceiveMemberList(success: { (list) in
        print("getReceiveMemberList success")
    }, failure: { (error) in
        if let e = error {
            print("getReceiveMemberList failure: \(e)")
        }
    })
}
```



#### Obtaining user-shared data that is actively shared by a single user

Objc:

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

Swift:

```swift
func getShareMemberDetail() {
    deviceShare?.getMemberDetail(withMemberId: memberId, success: { (model) in
        print("getShareMemberDetail success")
    }, failure: { (error) in
        if let e = error {
            print("getShareMemberDetail failure: \(e)")
        }
    })
}
```

#### Getting shared data from a single recipient

Objc:

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

Swift:

```swift
func getReceiveMemberDetail() {
    deviceShare?.getReceiveMemberDetail(withMemberId: memberId, success: { (model) in
        print("getReceiveMemberDetail success")
    }, failure: { (error) in
        if let e = error {
            print("getReceiveMemberDetail failure: \(e)")
        }
    })
}
```

#### Get a single device shared user list

Objc:

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

Swift:

```swift
func getDeviceShareMemberList() {
    deviceShare?.getMemberList(withDevId: "dev_id", success: { (model) in
        print("getDeviceShareMemberList success")
    }, failure: { (error) in
        if let e = error {
            print("getDeviceShareMemberList failure: \(e)")
        }
    })
}
```



#### Who Shares Access Devices

Objc:

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

Swift:

```swift
func getShareInfo() {
    deviceShare?.getInfoWithDevId("dev_id", success: { (model) in
        print("getShareInfo success")
    }, failure: { (error) in
        if let e = error {
            print("getShareInfo failure: \(e)")
        }
    })
}
```

### Remove Sharing

#### Delete active Sharers

Objc:

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

Swift:

```swift
func removeShareMember() {
    deviceShare?.removeMember(withMemberId: memberId, success: {
        print("removeShareMember success")
    }, failure: { (error) in
        if let e = error {
            print("removeShareMember failure: \(e)")
        }
    })
}
```



#### Delete Receiving Sharer

Objc:

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

Swift:

```swift
func removeReceiveMember() {
    deviceShare?.removeReceiveMember(withMemberId: memberId, success: {
        print("removeReceiveMember success")
    }, failure: { (error) in
        if let e = error {
            print("removeReceiveMember failure: \(e)")
        }
    })
}
```


#### Single Device Remove Sharing

Objc:

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

Swift:

```swift
func removeDeviceShare() {
    deviceShare?.remove(withMemberId: memberId, devId: "dev_id", success: {
        print("removeDeviceShare success")
    }, failure: { (error) in
        if let e = error {
            print("removeDeviceShare failure: \(e)")
        }
    })
}
```

#### Remove shared devices received

Objc:

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

Swift:

```swift
func removeDeviceShare() {
    deviceShare?.removeReceive(withDevId: "dev_id", success: {
        print("removeDeviceShare success")
    }, failure: { (error) in
        if let e = error {
            print("removeDeviceShare failure: \(e)")
        }
    })
}
```


### Modify Note Name

#### Modify the nickname of the active sharer

Objc:

```objc

- (void)updateShareMemberName {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];

    [self.deviceShare renameShareMemberNameWithMemberId:memberId name:@"new_name" success:^{

    	NSLog(@"updateShareMemberName success");

    } failure:^(NSError *error) {

    	NSLog(@"updateShareMemberName failure: %@", error);

    }];

```

Swift:

```swift
func updateShareMemberName() {
    deviceShare?.renameShareMemberName(withMemberId: "memberId", name: "new_name", success: {
        print("updateShareMemberName success")
    }, failure: { (error) in
        if let e = error {
            print("updateShareMemberName failure: \(e)")
        }
    })
}
```



#### Modify the nickname of the recipient sharer

Objc:

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

Swift:

```swift
func updateReceiveMemberName() {
    deviceShare?.renameReceiveMemberName(withMemberId: memberId, name: "new_name", success: {
        print("updateReceiveMemberName success")
    }, failure: { (error) in
        if let e = error {
            print("updateReceiveMemberName failure: \(e)")
        }
    })
}
```