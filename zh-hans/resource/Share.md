# 共享设备

当需要将家庭下某一个设备单独提供给其他用户操作时，可将设备共享给其他用户，收到共享设备的用户可在自身账号下对设备进行简单操作。

|           类名           |          说明          |
| :----------------------: | :--------------------: |
| TuyaSmartHomeDeviceShare | 提供设备分享相关的功能 |



## 添加共享

### 添加多个设备共享（覆盖）
分享多个设备给指定用户，会将指定用户的以前所有分享覆盖掉

**接口说明**


```objective-c
-(void)addShareWithHomeId:homeId 
              countryCode:countryCode
              userAccount:userAccount 
                   devIds:(NSArray<NSString *> *) success
                  failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明               |
| ----------- | ------------------ |
| homeId      | 设备所属的家庭 id  |
| countryCode | 分享对象的国家码   |
| userAccount | 分享对象的账号     |
| devIds      | 分享的设备 id 列表 |
| success     | 成功回调           |
| failure     | 失败回调           |

**示例代码**

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



### 添加共享 （新增，不覆盖旧的分享）
分享多个设备给指定用户，会将要分享的设备追加到指定用户的所有分享中

**接口说明**


```objective-c
- (void)addShareWithMemberId:(NSInteger)memberId
                      devIds:(NSArray <NSString *> *)devIds
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明          |
| -------- | ------------- |
| memberId | 分享对象的 id |
| success  | 成功回调      |
| failure  | 失败回调      |

**示例代码**

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



### 设备添加共享

分享单个设备给指定用户，会将要分享的设备追加到指定用户的所有分享中

**接口说明**

```objective-c
- (void)addDeviceShareWithHomeId:(long long)homeId
                     countryCode:(NSString *)countryCode
                     userAccount:(NSString *)userAccount
                           devId:(NSString *)devId
                         success:(void(^)(TuyaSmartShareMemberModel *model))success
                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明             |
| ----------- | ---------------- |
| homeId      | 设备的家庭 id    |
| countryCode | 分享对象的国家码 |
| userAccount | 分享对象的账号   |
| devId       | 分享设备的 id    |
| success     | 成功回调         |
| failure     | 失败回调         |

**示例代码**

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



## 分享关系获取

### 获取家庭下所有主动共享的用户列表

**接口说明**

```objective-c
- (void)getShareMemberListWithHomeId:(long long)homeId
                             success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                             failure:(TYFailureError)failure;

```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| homeId  |          |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

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



### 获取所有收到共享的用户列表

**接口说明**

```objective-c
- (void)getReceiveMemberListWithSuccess:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| success | 成功回调 |
| failure | 失败回调 |

**示例代码**

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



### 获取单个主动共享的用户共享数据

**接口说明**

```objective-c
- (void)getShareMemberDetailWithMemberId:(NSInteger)memberId
                                 success:(void(^)(TuyaSmartShareMemberDetailModel *model))success
                                 failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明          |
| -------- | ------------- |
| memberId | 分享用户的 id |
| success  | 成功回调      |
| failure  | 失败回调      |

**示例代码**

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



### 获取单个收到共享的用户共享数据

**接口说明**

```objective-c
- (void)getReceiveMemberDetailWithMemberId:(NSInteger)memberId
                                   success:(void(^)(TuyaSmartReceiveMemberDetailModel *model))success
                                   failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明                    |
| -------- | ----------------------- |
| memberId | 收到设备分享者的用户 id |
| success  | 成功回调                |
| failure  | 失败回调                |

**示例代码**

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



### 获取单设备共享用户列表

**接口说明**

```objective-c
- (void)getDeviceShareMemberListWithDevId:(NSString *)devId
                                  success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                  failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明          |
| ------- | ------------- |
| devId   | 分享的设备 id |
| success | 成功回调      |
| failure | 失败回调      |

**示例代码**

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



### 获取设备分享来自哪里

**接口说明**

```objective-c
- (void)getShareInfoWithDevId:(NSString *)devId
                      success:(void(^)(TuyaSmartReceivedShareUserModel *model))success
                      failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明          |
| ------- | ------------- |
| devId   | 分享的设备 id |
| success | 成功回调      |
| failure | 失败回调      |

**示例代码**

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



## 移除共享

### 删除主动共享者

共享者通过memberId 删除与这个关系用户的所有共享关系（用户维度删除）

**接口说明**

```objective-c
- (void)removeShareMemberWithMemberId:(NSInteger)memberId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明        |
| -------- | ----------- |
| memberId | 分享用户 id |
| success  | 成功回调    |
| failure  | 失败回调    |

**示例代码**

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



### 删除收到共享者

被共享者通过 memberId 获取收到这个关系用户的所有共享设备信息

**接口说明**

```objective-c
- (void)removeReceiveShareMemberWithMemberId:(NSInteger)memberId
                                     success:(TYSuccessHandler)success
                                     failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明              |
| -------- | ----------------- |
| memberId | 收到分享的用户 id |
| success  | 成功回调          |
| failure  | 失败回调          |

**示例代码**

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



### 单设备删除共享

**接口说明**

```objective-c
- (void)removeDeviceShareWithMemberId:(NSInteger)memberId
                                devId:(NSString *)devId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明          |
| -------- | ------------- |
| memberId | 分享用户的 id |
| devId    | 分享设备的 id |
| success  | 成功回调      |
| failure  | 失败回调      |

**示例代码**

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



### 删除收到的共享设备

**接口说明**

```objective-c
- (void)removeReceiveDeviceShareWithDevId:(NSString *)devId
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明          |
| ------- | ------------- |
| devId   | 分享的设备 id |
| success | 成功回调      |
| failure | 失败回调      |

**示例代码**

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



## 修改备注名

### 修改主动共享者的昵称

**接口说明**

```objective-c
- (void)renameShareMemberNameWithMemberId:(NSInteger)memberId
                                     name:(NSString *)name
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明             |
| -------- | ---------------- |
| memberId | 分享用户的 id    |
| name     | 分享用户的新昵称 |
| success  | 成功回调         |
| failure  | 失败回调         |

**示例代码**

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



### 修改收到共享者的昵称

**接口说明**

```objective-c
- (void)renameReceiveShareMemberNameWithMemberId:(NSInteger)memberId
                                            name:(NSString *)name
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明                    |
| -------- | ----------------------- |
| memberId | 将设备分享给你的用户 id |
| name     | 新的昵称                |
| success  | 成功回调                |
| failure  | 失败回调                |

**示例代码**

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
