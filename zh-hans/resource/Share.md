## 共享设备

我们提供了两种共享方式：

- 基于**家庭成员的共享**，如果要把一个家庭的所有设备共享给家人，可以将其设置为家庭`TuyaSmartHome`的成员`TuyaSmartHomeMember`，共享家中所有的设备`TuyaSmartDevice`，家人就拥有了该家庭中所有设备的控制权限。如果将家人设置成管理员，就拥有了这个家庭设备的所以权限，如果设置家人为非管理员，就只拥有这个家庭设备的控制权限。

- 基于**设备的共享**，有时候需要把家庭中的某些设备共享给家人，这时可以只把相应的设备共享给朋友，家人不会拥有其它设备的控制权限，并且被共享的设备不能进行改名、移除设备、固件升级、恢复出厂设置等操作（只能发送设备控制指令、获取状态更新）。

### 家庭成员共享

家庭成员共享相关的所有功能对应`TuyaSmartHomeMember`类

#### 添加家庭成员

Objc:

```objc
- (void)addShare {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember addHomeMemberWithHomeId:homeId countryCode:@"your_country_code" account:@"account" name:@"name" isAdmin:YES success:^{
        NSLog(@"addNewMember success");
    } failure:^(NSError *error) {
        NSLog(@"addNewMember failure: %@", error);
    }];
}
```

Swift:

```swift
func addShare() {
    homeMember?.add(withHomeId: homeId, countryCode: "your_country_code", account: "account", name: "name", isAdmin: true, success: {
        print("addNewMember success")
    }, failure: { (error) in
        if let e = error {
            print("addNewMember failure: \(e)")
        }
    })
}
```



####  获取家庭成员列表

Objc:


```objc
- (void)initMemberList {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember getHomeMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartHomeMemberModel *> *memberList) {
        NSLog(@"getMemberList success: %@", memberList);
    } failure:^(NSError *error) {
        NSLog(@"getMemberList failure");
    }];
}
```

Swift:

```swift
func initMemberList() {
    homeMember?.getListWithHomeId(homeId, success: { (memberList) in
        print("getMemberList success: \(memberList)")
    }, failure: { (error) in
        if let e = error {
            print("getMemberList failure: \(e)")
        }
    })
}
```



#### 修改家庭成员的备注名称和是否是管理员

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



#### 删除家庭成员

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



### 设备共享（基于设备维度的共享）

设备共享相关的所有功能对应`TuyaSmartHomeDeviceShare`类

#### 添加共享

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



#### 添加共享 （新增，不覆盖旧的分享）

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



#### 获取共享的用户列表

获取所有主动共享的用户列表

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



获取所有收到共享的用户列表

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



#### 获取用户共享数据

获取单个主动共享的用户共享数据

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

获取单个收到共享的用户共享数据

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



#### 删除共享

删除主动共享者

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



删除收到共享者

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



#### 修改昵称

修改主动共享者的昵称

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



修改收到共享者的昵称

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



#### 单设备共享操作

单设备添加共享

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



单设备删除共享

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

删除收到的共享设备

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



#### 获取设备共享用户列表

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



#### 获取设备分享来自哪里

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

