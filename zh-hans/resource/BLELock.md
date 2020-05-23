# 蓝牙门锁功能说明

## 专有名词解释

|                       | 介绍                                                         |
| --------------------- | ------------------------------------------------------------ |
| 劫持                  | 门锁劫持是指将录入特定的密码（指纹、密码等），设置为劫持密码，当受到劫持使用该密码进行开锁时，被迫开门，门锁将防劫持特殊开门报警信息发送至家人手机或物业管理系统。 |
| 门锁成员              | 门锁成员分为家庭成员与非家庭成员。<br />家庭成员即为涂鸦全屋智能的家庭成员概念，门锁内可将对应的门锁密码编号与该账号关联起来；<br />非家庭成员即为门锁内的成员，跟随设备关联，可以创建并分配，门锁内可将对应的门锁密码编号与该成员关联起来。 |
| lockUserId  和 userId | lockUserId 是创建门锁成员时，云端为设备分配的固件成员 id，代表着固件内记录的用户 id 号<br />userId 是创建门锁成员时，云端分配的数据库记录 id，代表着用户的唯一 id |

### 使用说明

| 类名                             | 说明                                                   |      |
| -------------------------------- | ------------------------------------------------------ | ---- |
| `TuyaSmartBLELockDevice`         | 蓝牙门锁设备操作类，继承自 `TuyaSmartDevice`           |      |
| `TuyaSmartBLELockDeviceDelegate` | 蓝牙门锁设备协议代理，拓展自 `TuyaSmartDeviceDelegate` |      |



### 设备连接状态

蓝牙门锁需要 App 开启蓝牙后，部分功能才能正常使用。**SDK 在正常情况下会自动连接**，通常使用以下方法进行设备连接状态判断

```objective-c
/// 如果没有连接成功或使用过程中断开，可以调用此方法进行连接
- (void)autoConnect;

/// 设备和手机是否已建立蓝牙连接，如果为 NO，可以调用 autoConnect 进行连接
- (BOOL)isBLEConnected;
```

### 动态密码

#### 获取动态密码

**接口说明**

```objective-c
- (void)getLockDynamicPasswordWithSuccess:(nullable TYSuccessString)success
                                  failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                       |
| ------- | ------------------------------------------ |
| success | 接口成功回调，返回结果为对应获取的动态密码 |
| failure | 接口失败回调                               |

**示例代码**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
    [lock getLockDynamicPasswordWithSuccess:^(NSString *result) {
        NSLog(@"动态密码获取结果 %@", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")
    lockDevice?.getLockDynamicPassword(success: { (pwd) in
        print("动态密码获取结果 \(pwd)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```



### 蓝牙解锁 & 落锁

#### 蓝牙解锁

```sequence
Title: 蓝牙解锁开门流程

participant 用户
participant app
participant 门锁

note over app: 蓝牙开启，连接上门锁
用户->app: 点击开锁
app->门锁: 发送蓝牙开锁指令
note over 门锁: 收到蓝牙开锁指令，开锁
门锁-->app: 返回开锁结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)unlockWithStatus:(BOOL)status
                 success:(nullable TYSuccessHandler)success
                 failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明         |
| ------- | ------------ |
| status  | 开锁还是关锁 |
| success | 接口成功回调 |
| failure | 接口失败回调 |

**示例代码**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
		BOOL status = YES;
    [lock unlockWithStatus:status success:^{
      	NSLog(@"开锁成功");
    } failure:^(NSError *error) {
        NSLog(@"开锁失败，error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")		
		self.lock?.unlock(withStatus: status, success: {
        print("开锁成功")
    }, failure: { (error) in
        if let e = error {
        		print("开锁失败，error: \(e)")
        }    
    })
```

#### 蓝牙落锁

```sequence
Title: 蓝牙落锁流程

participant 用户
participant app
participant 门锁

note over app: 蓝牙开启，连接上门锁
用户->app: 点击落锁
app->门锁: 发送蓝牙落锁指令
note over 门锁: 收到蓝牙落锁指令，开锁
门锁-->app: 返回落锁结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)manualLockWithStatus:(BOOL)status
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明         |
| ------- | ------------ |
| status  | 开锁还是关锁 |
| success | 接口成功回调 |
| failure | 接口失败回调 |

**示例代码**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
		BOOL status = YES;
    [lock manualLockWithStatus:status success:^{
      	NSLog(@"落锁成功");
    } failure:^(NSError *error) {
        NSLog(@"落锁失败，error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")		
		self.lock?.manualLock(withStatus: status, success: {
        print("落锁成功")
    }, failure: { (error) in
        if let e = error {
        		print("落锁失败，error: \(e)")
        }    
    })
```

### 门锁记录

#### 获取门锁告警记录

**接口说明**

```objective-c
- (void)getAlarmRecordListWithOffset:(int)offset
                               limit:(int)limit
                             success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *records))success
                             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                     |
| ------- | ------------------------ |
| offset  | 页数                     |
| limit   | 条数                     |
| success | 成功回调，结果为记录列表 |
| failure | 失败回调                 |

**`TuyaSmartLockRecordModel` 数据模型**

| 字段     | 类型                    | 描述                           |
| -------- | ----------------------- | ------------------------------ |
| userId   | NSString                | 成员 id                        |
| userName | NSString                | 用户昵称                       |
| time     | NSTimeInterval          | 发生时间， 13 位时间戳         |
| devId    | NSString                | 设备 id                        |
| dpData   | NSDictionary            | dp 数据                        |
| tags     | NSInteger               | 标位，0表示其他，1表示劫持报警 |
| dpsArray | NSArray<NSDictionary *> | dps 数据组                     |

**示例代码**

Objc:

```objective-c
    [self.lock getAlarmRecordListWithOffset:0 limit:50 success:^(NSArray<TuyaSmartLockRecordModel *> * _Nonnull records) {
        NSLog(@"告警记录: %@", records);
    } failure:^(NSError *error) {
        NSLog(@"获取告警记录失败，error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getAlarmRecordList(withOffset: 0, limit: 50, success: { (records) in
        print("告警记录 \(records)")
    }, failure: { (error) in
        if let e = error {
            print("获取告警记录失败, error: \(e)")
        }
    })
```

#### 获取开门记录

**接口说明**

```objective-c
- (void)getUnlockRecordListWithOffset:(int)offset
                                limit:(int)limit
                              success:(nullable void(^)(NSArray<TuyaSmartBLELockRecordModel *> *records))success
                              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                     |
| ------- | ------------------------ |
| offset  | 页数                     |
| limit   | 条数                     |
| success | 成功回调，结果为记录列表 |
| failure | 失败回调                 |

**示例代码**

Objc:

```objective-c
    [self.lock getUnlockRecordListWithOffset:0 limit:50 success:^(NSArray<TuyaSmartLockRecordModel *> * _Nonnull records) {
        NSLog(@"开门记录: %@", records);
    } failure:^(NSError *error) {
        NSLog(@"获取开门记录失败，error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getUnlockRecordList(withOffset: 0, limit: 50, success: { (records) in
        print("开门记录 \(records)")
    }, failure: { (error) in
        if let e = error {
            print("获取开门记录失败, error: \(e)")
        }
    })
```



### 门锁成员

#### 创建门锁成员

SDK 支持往门锁里添加成员，后续可以单独为该成员进行解锁方式绑定

```sequence
Title: 创建门锁成员流程

participant app
participant 云端

note over app: 用户填写成员信息
app->云端: 调用接口，创建用户
云端-->app: 生成门锁用户 id、硬件成员id，返回创建结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)addMemberWithUserName:(NSString *)userName
                  allowUnlock:(BOOL)allowUnlock
                     timeType:(TYMemberTimeType)timeType
                effectiveDate:(NSDate *)effectiveDate
                  invalidDate:(NSDate *)invalidDate
                      success:(nullable TYSuccessBOOL)success
                      failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| userName      | 成员名称                                                     |
| allowUnlock   | 是否允许使用蓝牙解锁                                         |
| timeType      | 时效性，`TYMemberTimeTypePermanent` 永久,  `TYMemberTimeTypePhase` 分时间段 |
| effectiveDate | 生效时间                                                     |
| invalidDate   | 失效时间                                                     |
| success       | 成功回调                                                     |
| failure       | 失败回调                                                     |

**示例代码**

Objc:

```objective-c
    [self.lock addMemberWithUserName:#<成员名称># allowUnlock:YES timeType:TYMemberTimeTypePhase effectiveDate:[NSDate date] invalidDate:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 8] success:^(BOOL result) {
        NSLog(@"创建门锁成员成功");
    } failure:^(NSError *error) {
        NSLog(@"创建门锁成员失败，error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.addMember(withUserName: "name", allowUnlock: true, timeType: .phase, effectiveDate: Date(), invalidDate: Date().addingTimeInterval(60 * 60 * 8), success: { (result) in
        print("创建门锁成员成功")
    }, failure: { (error) in
        if let e = error {
            print("创建门锁成员失败, error: \(e)")
        }     
    })
```

#### 更新门锁成员信息

SDK 提供了修改门锁成员的功能，修改门锁成员会和硬件进行交互，需要设备保持蓝牙连接

```sequence
Title: 更新门锁成员流程

participant 云端
participant app
participant 门锁

note over app: 用户填写新的成员信息
app->门锁: 建立蓝牙连接
app->门锁: 发送更新用户信息指令
门锁-->app: 回复更新结果
app->云端: 调用接口，更新用户
云端-->app: 返回更新结果
note over app: 处理、显示结果
```





**接口说明**

```objective-c
- (void)updateMemberWithUserName:(NSString *)userName
                        memberId:(NSString *)memberId
                     allowUnlock:(BOOL)allowUnlock
                        timeType:(TYMemberTimeType)timeType
                   effectiveDate:(NSDate *)effectiveDate
                     invalidDate:(NSDate *)invalidDate
                         success:(nullable TYSuccessBOOL)success
                         failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| userName      | 成员名称                                                     |
| memberId      | 成员 id                                                      |
| allowUnlock   | 是否允许使用蓝牙解锁                                         |
| timeType      | 时效性，`TYMemberTimeTypePermanent` 永久,  `TYMemberTimeTypePhase` 分时间段 |
| effectiveDate | 生效时间                                                     |
| invalidDate   | 失效时间                                                     |
| success       | 成功回调                                                     |
| failure       | 失败回调                                                     |

**示例代码**

Objc:

```objective-c
    [self.lock updateMemberWithUserName:@"new name" memberId:@"0000008byw" allowUnlock:YES timeType:TYMemberTimeTypePermanent effectiveDate:[NSDate date] invalidDate:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 8] success:^(BOOL result) {
        NSLog(@"更新门锁成员成功");
    } failure:^(NSError *error) {
        NSLog(@"创建门锁成员失败，error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.updateMember(withUserName: "new name", memberId: "0000008byw", allowUnlock: true, timeType: .phase, effectiveDate: Date(), invalidDate: Date().addingTimeInterval(60 * 60 * 8), success: { (result) in
            print("更新门锁成员信息成功")
        }, failure: { (error) in
        		if let e = error {
            		print("更新门锁成员信息失败, error: \(e)")
        		} 
        })
```



#### 获取门锁成员列表

**接口说明**

```objective-c
- (void)getMemberListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockMemberModel *> *members))success
                         failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明               |
| ------- | ------------------ |
| success | 成功回调，成员列表 |
| failure | 失败回调           |

**`TuyaSmartBLELockMemberModel` 数据模型**

| 字段             | 类型       | 描述                                              |
| ---------------- | ---------- | ------------------------------------------------- |
| userId           | NSString   | 成员编号， id                                     |
| userContact      | NSString   | 联系方式                                          |
| avatarUrl        | NSString   | 头像地址                                          |
| nickName         | NSString   | 成员名称                                          |
| userTimeSet      | NSString   | 成员时效性数据                                    |
| phase            | NSUInteger | 冻结情况，0: 冻结， 1: 解冻                       |
| status           | NSUInteger | 用户状态                                          |
| lockUserId       | **int**    | 门锁上的用户 id                                   |
| userType         | NSUInteger | 用户类型 10:管理员 20:普通成员 30: 没有名称的成员 |
| supportOpenType  | NSArray    | 支持的开锁方式                                    |
| shareUser        | NSString   | 分享的用户账号                                    |
| productAttribute | NSUInteger | 设备产品属性                                      |

**示例代码**

Objc:

```objective-c
    [self.lock getMemberListWithSuccess:^(NSArray<TuyaSmartBLELockMemberModel *> * _Nonnull list) {
        NSLog(@"成员列表 %@", list);
    } failure:^(NSError *error) {
				NSLog(@"获取成员列表失败，error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getMemberList(success: { (list) in
        print("成员列表 \(list)")
    }, failure: { (error) in
        if let e = error {
            print("获取成员列表失败, error: \(e)")
        }
    })
```



#### 删除门锁成员

SDK 提供了删除门锁成员的功能，**删除门锁成员会和硬件进行交互，会删除该用户下所有的开锁方式、密码等，操作需要设备保持蓝牙连接**

```sequence
Title: 删除门锁成员流程

participant 云端
participant app
participant 门锁

note over app: 用户确认删除成员
app->门锁: 建立蓝牙连接
app->门锁: 发送删除用户信息指令
门锁-->app: 回复删除结果
app->云端: 调用接口，删除用户
云端-->app: 返回删除结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)removeMemberWithMemberId:(NSString *)memberId
                         success:(nullable TYSuccessBOOL)success
                         failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明          |
| -------- | ------------- |
| memberId | 成员编号， id |
| success  | 成功回调      |
| failure  | 失败回调      |

**示例代码**

Objc:

```objective-c
    [self.lock removeMemberWithMemberId:@"000000747d" success:^(BOOL result) {
        NSLog(@"删除门锁成员成功");
    } failure:^(NSError *error) {
        NSLog(@"删除门锁成员失败, error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeMember(withMemberId: "", success: { (result) in
    		print("删除门锁成员成功")
    }, failure: { (error) in
        if let e = error {
            print("删除门锁成员失败, error: \(e)")
        }     
    })
```

### 普通密码解锁

#### 添加普通密码

SDK 提供了添加普通密码的功能，**密码的时效性跟随成员的时效性，添加时需要设备保持蓝牙连接**

```sequence
Title: 添加密码解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认密码信息
app->门锁: 建立蓝牙连接
app->门锁: 发送添加密码指令，发送密码信息
门锁-->app: 回复添加结果
app->云端: 调用接口，设置防劫持
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)addPasswordForMemberWithMemberId:(NSString *)memberId
                                password:(NSString *)password
                              unlockName:(NSString *)unlockName
                           needHijacking:(BOOL)needHijacking
                                 success:(nullable TYSuccessString)success
                                 failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                 |
| ------------- | -------------------- |
| memberId      | 成员编号，id         |
| password      | 密码，纯数字         |
| unlockName    | 密码名称             |
| needHijacking | 是否需要设置为防劫持 |
| success       | 成功回调             |
| failure       | 失败回调             |

**示例代码**

Objc:

```objective-c
    [self.lock addPasswordForMemberWithMemberId:@"00000074zg" password:@"774642" unlockName:@"密码774642" needHijacking:YES success:^(NSString *result) {
         NSLog(@"创建密码成功");
    } failure:^(NSError *error) {
         NSLog(@"创建密码失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.addPasswordForMember(withMemberId: "00000074zg", password: "774642", unlockName: "密码774642", needHijacking: true, success: { (result) in
        print("创建密码成功")
    }, failure: { (error) in
        if let e = error {
            print("创建密码失败, error: \(e)")
        }             
    })
```

#### 获取普通密码列表

**接口说明**

```objective-c
- (void)getPasswordListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                           failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                   |
| ------- | ---------------------- |
| success | 成功回调，普通密码列表 |
| failure | 失败回调               |

**`TuyaSmartBLELockOpmodeModel` 数据模型**

| 字段            | 类型       | 描述                                                     |
| --------------- | ---------- | -------------------------------------------------------- |
| opmode          | NSString   | 开锁方式                                                 |
| sourceAttribute | NSUInteger | 开锁方式来源，1: app 2: 门锁离线录入 3: 门锁超管理员录入 |
| unlockName      | NSString   | 开锁方式名称                                             |
| userName        | NSString   | 开锁用户名称                                             |
| lockUserId      | long long  | 硬件内门锁成员 id                                        |
| userId          | NSString   | 成员编号，id                                             |
| opmodeValue     | NSString   | 开锁方式值，一般记录为门锁编号                           |
| opmodeId        | NSString   | 开锁方式 dp id                                           |
| unlockAttr      | NSUInteger | 解锁方式属性，1 代表劫持                                 |

**示例代码**

Objc:

```objective-c
    [self.lock getPasswordListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"获取密码列表 %@", models);
    } failure:^(NSError *error) {
        NSLog(@"获取密码列表失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.getPasswordList(success: { (models) in
    		print("获取密码列表 \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("获取密码列表失败, error: \(e)")
        }               
    })
```



#### 删除普通密码

SDK 提供了删除普通密码的功能，**删除时需要设备保持蓝牙连接**

```sequence
Title: 删除密码解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认删除密码
app->门锁: 建立蓝牙连接
app->门锁: 发送删除密码指令
门锁-->app: 回复删除结果
app->云端: 调用接口，删除云端记录
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)removePasswordForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                       success:(TYSuccessHandler)success
                                       failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                    |
| ----------- | --------------------------------------- |
| opmodeModel | 开锁方式 model 信息，来源自开锁方式列表 |

**示例代码**

Objc:

```objective-c
    [self.lock removePasswordForMemberWithOpmodeModel:model success:^{
        NSLog(@"删除开锁方式成功");
    } failure:^(NSError *error) {
        NSLog(@"删除开锁方式失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.removePasswordForMember(with: model, success: {
        print("删除开锁方式成功")
    }, failure: { (error) in
        if let e = error {
            print("删除开锁方式失败, error: \(e)")
        }                
    })
```



### 指纹解锁

#### 添加指纹密码

SDK 提供了添加指纹密码的功能，添加指纹密码需要与设备频繁的交互，**添加时需要设备保持蓝牙连接**

```sequence
Title: 添加指纹密码解锁方式流程


participant 用户
participant 门锁
participant app
participant 云端

用户->app: 发起添加指纹请求
app->门锁: 建立蓝牙连接
app->门锁: 发送开锁添加密码指令
门锁-->app: 回复开锁录入指纹请求，需录入次数信息等等
note over app: 展示录入数据信息

用户->门锁: a录入指纹
门锁-->app: a返回录入结果，剩余录入信息
note over app: a展示录入数据信息

用户->门锁: b持续录入指纹
门锁-->app: b返回录入结果，剩余录入信息
note over app: b展示录入数据信息

用户->门锁: ...持续录入指纹

用户->门锁: 录入指纹
门锁-->app: 录入完成，返回最终录入结果
note over app: 展示录入数据结果信息
note over app: 汇总数据信息，合并接口参数数据
app->云端: 调用接口，设置防劫持
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)addFingerPrintForMemberWithMemberId:(NSString *)memberId
                                 unlockName:(NSString *)unlockName
                              needHijacking:(BOOL)needHijacking
                                    success:(TYSuccessString)success
                                    failure:(TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                 |
| ------------- | -------------------- |
| memberId      | 成员编号，id         |
| unlockName    | 密码名称             |
| needHijacking | 是否需要设置为防劫持 |
| success       | 成功回调             |
| failure       | 失败回调             |

**示例代码**

Objc:

```objective-c
		// 设置代理，以接受和展示过程数据
		self.lock.delegate = self;
		[self.lock addFingerPrintForMemberWithMemberId:@"00000074zg" unlockName:@"添加的指纹" needHijacking:YES success:^(NSString *result) {
        NSLog(@"添加指纹成功");
    } failure:^(NSError *error) {
        NSLog(@"添加指纹失败，error: %@", error);
    }];

// TuyaSmartBLELockDeviceDelegate
		- (void)device:(TuyaSmartBLELockDevice *)device didReceiveAddOpMessage:(TuyaSmartBLELockOpMessageModel *)opMessage {
    		NSLog(@"收到新增开锁方式回调消息");
		}
```

Swift:

```swift
    self.lock?.delegate = self
		self.lock?.addFingerPrintForMember(withMemberId: "", unlockName: "", needHijacking: true, success: { (result) in
				print("添加指纹成功")      
    }, failure: { (error) in
        if let e = error {
            print("添加指纹失败, error: \(e)")
        }             
    })

// TuyaSmartBLELockDeviceDelegate
		extension ViewController :TuyaSmartBLELockDeviceDelegate {
    
    		func device(_ device: TuyaSmartBLELockDevice, didReceiveAddOpMessage opMessage: TuyaSmartBLELockOpMessageModel) {
        		print("收到新增开锁方式回调消息")
    		}
		}
```



#### 获取指纹列表

**接口说明**

```objective-c
- (void)getFingerPrintListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明               |
| ------- | ------------------ |
| success | 成功回调，指纹列表 |
| failure | 失败回调           |

**示例代码**

Objc:

```objective-c
    [self.lock getFingerPrintListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"获取指纹列表 %@", models);
    } failure:^(NSError *error) {
        NSLog(@"获取指纹列表失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.getFingerPrintList(success: { (models) in
    		print("获取指纹列表 \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("获取指纹列表失败, error: \(e)")
        }               
    })
```



#### 删除指纹密码

SDK 提供了删除指纹的功能，**删除时需要设备保持蓝牙连接**

```sequence
Title: 删除指纹解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认删除指纹
app->门锁: 建立蓝牙连接
app->门锁: 发送删除密码指令
门锁-->app: 回复删除结果
app->云端: 调用接口，删除云端记录
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)removeFingerPrintForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                       	  success:(TYSuccessHandler)success
                                          failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                    |
| ----------- | --------------------------------------- |
| opmodeModel | 开锁方式 model 信息，来源自开锁方式列表 |

**示例代码**

Objc:

```objective-c
    [self.lock removeFingerPrintForMemberWithOpmodeModel:model success:^{
        NSLog(@"删除开锁方式成功");
    } failure:^(NSError *error) {
        NSLog(@"删除开锁方式失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeFingerPrintForMember(with: model, success: {
        print("删除开锁方式成功")
    }, failure: { (error) in
        if let e = error {
            print("删除开锁方式失败, error: \(e)")
        }                
    })
```

### 卡片解锁

#### 添加卡片解锁

SDK 提供了添加卡片解锁的功能，**添加时需要设备保持蓝牙连接**

```sequence
Title: 添加卡片解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认卡片信息
app->门锁: 建立蓝牙连接
app->门锁: 发送添加卡片密码指令，发送密码信息
门锁-->app: 回复添加结果
app->云端: 调用接口，设置防劫持
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)addCardForMemberWithMemberId:(NSString *)memberId
                          unlockName:(NSString *)unlockName
                       needHijacking:(BOOL)needHijacking
                             success:(TYSuccessString)success
                             failure:(TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                 |
| ------------- | -------------------- |
| memberId      | 成员编号，id         |
| unlockName    | 密码名称             |
| needHijacking | 是否需要设置为防劫持 |
| success       | 成功回调             |
| failure       | 失败回调             |

**示例代码**

Objc:

```objective-c
    [self.lock addCardForMemberWithMemberId:@"00000074zg" unlockName:@"卡片密码1" needHijacking:YES success:^(NSString *result) {
         NSLog(@"创建卡片密码成功");
    } failure:^(NSError *error) {
         NSLog(@"创建密码失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.addCardForMember(withMemberId: "00000074zg", unlockName: "卡片密码1", needHijacking: true, success: { (result) in
        print("创建卡片密码成功")
    }, failure: { (error) in
        if let e = error {
            print("创建密码失败, error: \(e)")
        }             
    })
```

#### 获取卡片列表

**接口说明**

```objective-c
- (void)getCardListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                       failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                   |
| ------- | ---------------------- |
| success | 成功回调，卡片密码列表 |
| failure | 失败回调               |

**示例代码**

Objc:

```objective-c
    [self.lock getCardListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"获取卡片密码列表 %@", models);
    } failure:^(NSError *error) {
        NSLog(@"获取卡片密码列表失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.getCardList(success: { (models) in
    		print("获取卡片密码列表 \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("获取卡片密码列表失败, error: \(e)")
        }               
    })
```



#### 删除卡片解锁

SDK 提供了删除卡片的功能，**删除时需要设备保持蓝牙连接**

```sequence
Title: 删除卡片解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认删除卡片
app->门锁: 建立蓝牙连接
app->门锁: 发送删除卡片密码指令
门锁-->app: 回复删除结果
app->云端: 调用接口，删除云端记录
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)removeCardForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                   success:(TYSuccessHandler)success
                                   failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                    |
| ----------- | --------------------------------------- |
| opmodeModel | 开锁方式 model 信息，来源自开锁方式列表 |

**示例代码**

Objc:

```objective-c
    [self.lock removeCardForMemberWithOpmodeModel:model success:^{
        NSLog(@"删除开锁方式成功");
    } failure:^(NSError *error) {
        NSLog(@"删除开锁方式失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeCardForMember(with: model, success: {
        print("删除开锁方式成功")
    }, failure: { (error) in
        if let e = error {
            print("删除开锁方式失败, error: \(e)")
        }                
    })
```

### 通用拓展解锁操作

#### 添加解锁方式

SDK 提供了添加通用解锁方式的功能，**添加时需要设备保持蓝牙连接**

```sequence
Title: 添加通用解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认解锁方式信息
app->门锁: 建立蓝牙连接
app->门锁: 发送添加解锁方式信息
门锁-->app: 回复添加结果
app->云端: 调用接口，设置防劫持
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)addUnlockOpmodeForMemberWithMemberId:(NSString *)memberId
                                     isAdmin:(BOOL)isAdmin
                                unlockDpCode:(NSString *)unlockDpCode
                                unlockOpType:(TYUnlockOpType)unlockOpType
                                  unlockName:(NSString *)unlockName
                               effectiveDate:(nullable NSDate *)effectiveDate
                                 invalidDate:(nullable NSDate *)invalidDate
                                       times:(int)times
                                  dataLength:(int)dataLength
                                 dataContent:(NSString *)dataContent
                                     timeout:(NSTimeInterval)timeout
                               needHijacking:(BOOL)needHijacking
                                     success:(nullable TYSuccessString)success
                                     failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| memberId      | 成员编号，id                                                 |
| isAdmin       | 是否是管理员                                                 |
| unlockDpCode  | 解锁方式对应的 dp code，详细可查看产品定义，例如卡片解锁，code  = unlock_card |
| unlockOpType  | 解锁方式，可查看  TYUnlockOpType 枚举                        |
| unlockName    | 解锁方式名称                                                 |
| effectiveDate | 生效时间                                                     |
| invalidDate   | 失效时间                                                     |
| times         | 解锁方式可用次数                                             |
| dataLength    | 数据长度，需要和数据内容长度保持一致                         |
| dataContent   | 数据内容                                                     |
| timeout       | 命令响应超时时间，如果是需要用户交互的，例如指纹，不用设置超时。 |
| needHijacking | 是否需要设置防劫持                                           |
| success       | 成功回调                                                     |
| failure       | 失败回调                                                     |

**示例代码**

Objc:

```objective-c
    [self.lock addUnlockOpmodeForMemberWithMemberId:@"00000074zg"
                                            isAdmin:NO
                                       unlockDpCode:@"unlock_password"
                                       unlockOpType:TYUnlockOpTypePassword
                                         unlockName:@"密码774641"
                                      effectiveDate:nil
                                        invalidDate:nil
                                              times:10
                                         dataLength:6
                                        dataContent:@"774641"
                                            timeout:6
                                      needHijacking:YES
                                            success:^(NSString *result) {
        NSLog(@"添加成功");
    } failure:^(NSError *error) {
        NSLog(@"添加失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.addUnlockOpmodeForMember(withMemberId: "00000074zg", isAdmin: false, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, unlockName: "密码774641", effectiveDate: nil, invalidDate: nil, times: 10, dataLength: 6, dataContent: "774641", timeout: 5, needHijacking: true, success: { (result) in
         print("添加成功")
    }, failure: { (error) in
        if let e = error {
            print("添加失败, error: \(e)")
        }            
    })
```



#### 更新解锁方式

SDK 提供了通用修改、更新解锁方式的功能，**添加时需要设备保持蓝牙连接**

```sequence
Title: 通用修改解锁方式流程

participant 云端
participant app
participant 门锁

note over app: 用户确认新解锁方式信息
app->门锁: 建立蓝牙连接
app->门锁: 发送更新解锁方式信息
门锁-->app: 回复更新结果
app->云端: 调用接口，设置防劫持
云端-->app: 返回结果
note over app: 处理、显示结果
```

**接口说明**

```objective-c
- (void)modifyUnlockOpmodeForMemberWithMemberId:(NSString *)memberId
                                       opmodeId:(NSString *)opmodeId
                                        isAdmin:(BOOL)isAdmin
                                     firmwareId:(int)firmwareId
                                   unlockDpCode:(NSString *)unlockDpCode
                                   unlockOpType:(TYUnlockOpType)unlockOpType
                                     unlockName:(NSString *)unlockName
                                  effectiveDate:(nullable NSDate *)effectiveDate
                                    invalidDate:(nullable NSDate *)invalidDate
                                          times:(int)times
                                     dataLength:(int)dataLength
                                    dataContent:(NSString *)dataContent
                                        timeout:(NSTimeInterval)timeout
                                  needHijacking:(BOOL)needHijacking
                                        success:(nullable TYSuccessBOOL)success
                                        failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| memberId      | 成员编号 id                                                  |
| opmodeId      | 开锁方式 id，来源获取的开锁方式列表                          |
| isAdmin       | 是否是管理员                                                 |
| firmwareId    | 硬件 id                                                      |
| unlockDpCode  | 解锁方式对应的 dp code，详细可查看产品定义，例如卡片解锁，code  = unlock_card |
| unlockOpType  | 解锁方式，可查看  TYUnlockOpType 枚举                        |
| unlockName    | 解锁方式名称                                                 |
| effectiveDate | 生效时间                                                     |
| invalidDate   | 失效时间                                                     |
| times         | 解锁方式可用次数                                             |
| dataLength    | 数据长度，需要和数据内容长度保持一致                         |
| dataContent   | 数据内容                                                     |
| timeout       | 命令响应超时时间，如果是需要用户交互的，例如指纹，不用设置超时。 |
| needHijacking | 是否需要设置防劫持                                           |
| success       | 成功回调                                                     |
| failure       | 失败回调                                                     |

**示例代码**

Objc:

```objective-c
    [self.lock modifyUnlockOpmodeForMemberWithMemberId:@"00000074zg"
                                              opmodeId:@"232323"
                                               isAdmin:NO
                                            firmwareId:15 //来源自开锁方式数据中的 opmodevalue
                                          unlockDpCode:@"unlock_password"
                                          unlockOpType:TYUnlockOpTypePassword
                                            unlockName:@"密码774641"
                                         effectiveDate:nil
                                           invalidDate:nil
                                                 times:10
                                            dataLength:6
                                           dataContent:@"774641"
                                               timeout:6
                                         needHijacking:YES
                                               success:^(NSString *result) {
        NSLog(@"更新成功");
    } failure:^(NSError *error) {
        NSLog(@"更新失败 %@", error);
    }];
```

Swift:

```swift
    self.lock?.modifyUnlockOpmodeForMember(withMemberId: "00000074zg", opmodeId: "232323", isAdmin: false, firmwareId: 15, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, unlockName: "密码774641", effectiveDate: nil, invalidDate: nil, times: 10, dataLength: 6, dataContent: "774641", timeout: 5, needHijacking: true, success: { (result) in
        print("更新成功")
    }, failure: { (error) in
        if let e = error {
            print("更新失败, error: \(e)")
        }
    })
```



#### 删除解锁方式

**接口说明**

```objective-c
- (void)removeUnlockOpmodeForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                           isAdmin:(BOOL)isAdmin
                                      unlockDpCode:(NSString *)unlockDpCode
                                      unlockOpType:(TYUnlockOpType)unlockOpType
                                           timeout:(NSTimeInterval)timeout
                                           success:(TYSuccessHandler)success
                                           failure:(TYFailureError)failure;
```

**参数说明**

| 参数         | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| opmodeModel  | 开锁方式模型                                                 |
| isAdmin      | 是否是管理员                                                 |
| unlockDpCode | 解锁方式对应的 dp code，详细可查看产品定义，例如卡片解锁，code  = unlock_card |
| unlockOpType | 解锁方式，可查看  TYUnlockOpType 枚举                        |
| timeout      | 命令响应超时时间，如果是需要用户交互的，例如指纹，不用设置超时。 |
| success      | 成功回调                                                     |
| failure      | 失败回调                                                     |

**示例代码**

Objc:

```objective-c
    [self.lock removeUnlockOpmodeForMemberWithOpmodeModel:model
                                                  isAdmin:NO
                                             unlockDpCode:@"unlock_password"
                                             unlockOpType:TYUnlockOpTypePassword
                                                  timeout:10
                                                  success:^{
        NSLog(@"删除成功");
    } failure:^(NSError *error) {
        NSLog(@"删除失败 %@", error);
    }]
```

Swift:

```swift
    self.lock?.removeUnlockOpmodeForMember(with: model, isAdmin: false, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, timeout: 10, success: {
        print("删除成功")    
    }, failure: { (error) in
        if let e = error {
            print("删除失败, error: \(e)")
        }            
    })
```



## 蓝牙门锁 Dp Code 表

| dp name                  | dp code                     |
| ------------------------ | --------------------------- |
| 添加开门方式             | unlock_method_create        |
| 删除开门方式             | unlock_method_delete        |
| 修改开门方式             | unlock_method_modify        |
| 冻结开门方式             | unlock_method_freeze        |
| 解冻开门方式             | unlock_method_enable        |
| 蓝牙解锁                 | bluetooth_unlock            |
| 蓝牙解锁反馈             | bluetooth_unlock_fb         |
| 剩余电量                 | residual_electricity        |
| 电量状态                 | battery_state               |
| 童锁状态                 | child_lock                  |
| 上提反锁                 | anti_lock_outside           |
| 指纹解锁                 | unlock_fingerprint          |
| 普通密码解锁             | unlock_password             |
| 动态密码解锁             | unlock_dynamic              |
| 卡片解锁                 | unlock_card                 |
| 钥匙解锁                 | unlock_key                  |
| 开关门事件               | open_close                  |
| 从门内侧打开门锁         | open_inside                 |
| 蓝牙解锁记录             | unlock_ble                  |
| 门被打开                 | door_opened                 |
| 告警                     | alarm_lock                  |
| 劫持报警                 | hijack                      |
| 门铃呼叫                 | doorbell                    |
| 短信通知                 | message                     |
| 门铃选择                 | doorbell_song               |
| 门铃音量                 | doorbell_volume             |
| 门锁语言切换             | language                    |
| 显示屏欢迎词管理         | welcome_words               |
| 按键音量                 | key_tone                    |
| 门锁本地导航音量         | beep_volume                 |
| 反锁状态                 | reverse_lock                |
| 自动落锁开关             | automatic_lock              |
| 单一解锁与组合解锁切换   | unlock_switch               |
| 同步成员开门方式         | synch_member                |
| 自动落锁延时设置         | auto_lock_time              |
| 定时自动落锁             | auto_lock_timer             |
| 指纹录入次数             | finger_input_times          |
| 人脸识别解锁             | unlock_face                 |
| 开合状态                 | closed_opened               |
| 虹膜解锁                 | unlock_eye                  |
| 掌纹解锁                 | unlock_hand                 |
| 指静脉解锁               | unlock_finger_vein          |
| 硬件时钟RTC              | rtc_lock                    |
| 自动落锁倒计时上报       | auto_lock_countdown         |
| 手动落锁                 | manual_lock                 |
| 落锁状态                 | lock_motor_state            |
| **锁帖电机转动方向**     | lock_motor_direction        |
| 冻结用户                 | unlock_user_freeze          |
| 解冻用户                 | unlock_user_enable          |
| 蓝牙锁临时密码添加       | temporary password_creat    |
| 蓝牙锁临时密码删除       | temporary password_delete   |
| 蓝牙锁临时密码修改       | temporary password_modify   |
| 同步开门方式（数据量大） | synch_method                |
| 临时密码解锁             | unlock_temporary            |
| 电机扭力                 | motor_torque                |
| 组合开锁记录             | unlock_double               |
| 离家布防开关             | arming_mode                 |
| 配置新免密远程解锁       | remote_no_pd_setkey         |
| 新免密远程开门-带密钥    | remote_no_dp_key            |
| 远程手机解锁上报         | unlock_phone_remote         |
| 远程语音解锁上报         | unlock_voice_remote         |
| 离线密码T0时间下发       | password_offline_time       |
| 单条离线密码清空上报     | unlock_offline_clear_single |
| 离线密码清空上报         | unlock_offline_clear        |
| 离线密码解锁上报         | unlock_offline_pd           |