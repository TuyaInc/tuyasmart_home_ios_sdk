# Shared devices

When a device  needs to be provided  for other users to operate, the device can be shared with other users, and the user who receives the shared device can simply operate the device.

|        Class Name        |                    Description                    |
| :----------------------: | :-----------------------------------------------: |
| TuyaSmartHomeDeviceShare | Share device, get share info, manage share device |



## Add Device Share

### Add  Multiple Device Sharing (coverage)
Sharing multiple devices to users will override all previous user sharing

**Declaration**


```objc
-(void)addShareWithHomeId:homeId 
              countryCode:countryCode
              userAccount:userAccount 
                   devIds:(NSArray<NSString *> *) success
                  failure:(nullable TYFailureError)failure;
```


**Parameters**


| Parameter | Description                           |
| :-------- | :------------------------------------ |
| homeId      | device home id |
| countryCode | share member country code |
| userAccount | share member user account |
| devIds      | share device id list |
| success     | success callback |
| failure     | failure callback |

**Example**

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



### Add Shares (new, not overwriting old Shares)
Sharing multiple devices to users will add the devices to all user shareing

**Declaration**

```objc
- (void)addShareWithMemberId:(NSInteger)memberId
                      devIds:(NSArray <NSString *> *)devIds
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description          |
| :-------- | :------------------- |
| memberId  | share user member id |
| success   | success callback     |
| failure   | failure callback    |

**Example**

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



### Single Device Add Sharing

**Declaration**


```objc
- (void)addDeviceShareWithHomeId:(long long)homeId
                     countryCode:(NSString *)countryCode
                     userAccount:(NSString *)userAccount
                           devId:(NSString *)devId
                         success:(void(^)(TuyaSmartShareMemberModel *model))success
                         failure:(TYFailureError)failure;
```


**Parameters**


| Parameter   | Description               |
| :---------- | :------------------------ |
| homeId      | device home id            |
| countryCode | share member country code |
| userAccount | share member account      |
| devId       | share device id           |
| success     | success callback          |
| failure     | failure callback         |

**Example**

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



## Getting Shared Relationships

### Get List of All Active Shared Users in the Home

**Declaration**


```objc
- (void)getShareMemberListWithHomeId:(long long)homeId
                             success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                             failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| homeId    | home id           |
| success   | success callback  |
| failure   | failure callback |



**Example**

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



### Get List of All Shared Uers Received

**Declaration**


```objc
- (void)getReceiveMemberListWithSuccess:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Obtaining User-shared Data that is Actively Shared by a Single User

**Declaration**


```objc
- (void)getShareMemberDetailWithMemberId:(NSInteger)memberId
                                 success:(void(^)(TuyaSmartShareMemberDetailModel *model))success
                                 failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| memberId  | share member id   |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Getting Shared Data from a Single Recipient

**Declaration**


```objc
- (void)getReceiveMemberDetailWithMemberId:(NSInteger)memberId
                                   success:(void(^)(TuyaSmartReceiveMemberDetailModel *model))success
                                   failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description         |
| :-------- | :------------------ |
| memberId  | recipient member id |
| success   | success callback    |
| failure   | failure callback   |

**Example**

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



### Get a Single Device Shared User List

**Declaration**


```objc
- (void)getDeviceShareMemberListWithDevId:(NSString *)devId
                                  success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                  failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| devId     | device id         |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Who Shares Access Devices

**Declaration**


```objc
- (void)getShareInfoWithDevId:(NSString *)devId
                      success:(void(^)(TuyaSmartReceivedShareUserModel *model))success
                      failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description             |
| :-------- | :---------------------- |
| devId     | receive share device id |
| success   | success callback        |
| failure   | failure callback       |

**Example**

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



## Remove Sharing

### Delete Active Sharers

The sharer deletes all shared relationships with this user through memberId (user dimension delete)

**Declaration**


```objc
- (void)removeShareMemberWithMemberId:(NSInteger)memberId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| memberId  | share memer id    |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Delete Receiving Sharer

The shared party obtains the information of all shared devices of this user through memberId

**Declaration**


```objc
- (void)removeReceiveShareMemberWithMemberId:(NSInteger)memberId
                                     success:(TYSuccessHandler)success
                                     failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description            |
| :-------- | :--------------------- |
| memberId  | revice share member id |
| success   | success callback       |
| failure   | failure callback      |

**Example**

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



### Single Device Remove Sharing

**Declaration**


```objc
- (void)removeDeviceShareWithMemberId:(NSInteger)memberId
                                devId:(NSString *)devId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| memberId  | share member id   |
| devId     | share device id   |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Remove Shared Devices Received

**Declaration**


```objc
- (void)removeReceiveDeviceShareWithDevId:(NSString *)devId
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| devId     | reviced device id |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



## Modify Note Name

### Modify the nickname of the active sharer

**Declaration**


```objc
- (void)renameShareMemberNameWithMemberId:(NSInteger)memberId
                                     name:(NSString *)name
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description       |
| :-------- | :---------------- |
| memberId  | share member id   |
| name      | new name          |
| success   | success callback  |
| failure   | failure callback |

**Example**

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



### Modify the Nickname of the Recipient Sharer

**Declaration**


```objc
- (void)renameReceiveShareMemberNameWithMemberId:(NSInteger)memberId
                                            name:(NSString *)name
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;
```


**Parameters**


| Parameter | Description            |
| :-------- | :--------------------- |
| memberId  | revice share member id |
| name      | new name               |
| success   | success callback       |
| failure   | failure callback      |

**Example**

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