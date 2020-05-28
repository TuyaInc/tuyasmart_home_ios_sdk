# Wi-Fi 门锁功能说明

## 专有名词解释

|                       | 介绍                                                         |
| --------------------- | ------------------------------------------------------------ |
| 劫持                  | 门锁劫持是指将录入特定的密码（指纹、密码等），设置为劫持密码，当受到劫持使用该密码进行开锁时，被迫开门，门锁将防劫持特殊开门报警信息发送至家人手机或物业管理系统。 |
| 门锁成员              | 门锁成员分为家庭成员与非家庭成员。<br />家庭成员即为涂鸦全屋智能的家庭成员概念，门锁内可将对应的门锁密码编号与该账号关联起来；<br />非家庭成员即为门锁内的成员，跟随设备关联，可以创建并分配，门锁内可将对应的门锁密码编号与该成员关联起来。 |

### 使用说明

| 类名                          | 说明                                                     |
| ----------------------------- | -------------------------------------------------------- |
| `TuyaSmartLockDevice`         | Wi-Fi 门锁设备操作类，继承自 `TuyaSmartDevice`           |
| `TuyaSmartLockDeviceDelegate` | Wi-Fi 门锁设备协议代理，拓展自 `TuyaSmartDeviceDelegate` |

## Wi-Fi 门锁功能

### 门锁成员

门锁内可以分为家庭成员和非家庭成员，家庭成员为全屋智能中的概念，具体可以查阅[家庭成员管理](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#%E5%AE%B6%E5%BA%AD%E6%88%90%E5%91%98%E7%AE%A1%E7%90%86)

以下介绍在门锁中的非家庭成员管理操作

#### 获取门锁成员列表

**接口说明**

```objective-c
- (void)getLockMemberListWithSuccess:(nullable void(^)(NSArray<TuyaSmartLockMemberModel *> *lockMemberModels))success
                             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                       |
| ------- | ------------------------------------------ |
| success | 接口成功回调，返回结果为门锁内成员用户信息 |
| failure | 接口失败回调                               |

**`TuyaSmartLockMemberModel` 数据模型**

| 字段            | 类型                                  | 描述                                    |
| --------------- | ------------------------------------- | --------------------------------------- |
| userId          | NSString                              | 成员 id                                 |
| userName        | NSString                              | 用户昵称                                |
| avatarUrl       | NSString                              | 头像地址                                |
| contact         | NSString                              | 联系方式                                |
| unlockRelations | NSArray<TuyaSmartLockRelationModel *> | 开锁对应编号关系                        |
| devId           | NSString                              | 门锁设备 id                             |
| ownerId         | NSString                              | 所属家庭 id                             |
| userType        | NS_ENUM                               | 门锁成员类型，1: 家庭成员 2: 非家庭成员 |

**示例代码**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];        
    [lock getLockMemberListWithSuccess:^(id result) {
        NSLog(@"result %@", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")           
    lockDevice?.getLockMemberList(success: { (members) in
        print("门锁成员列表 \(members)")
    }, failure: { (error) in
        if let e = error {
           print("error \(e)")
        }
    })
```



#### 创建门锁成员

使用 SDK 创建非家庭成员。以供后续开锁记录关联操作

**接口说明**

```objective-c
- (void)addLockNormalUserWithUserName:(NSString *)userName
                          avatarImage:(nullable UIImage *)avatarImage
                      unlockRelations:(nullable NSArray<TuyaSmartLockRelationModel *> *)unlockRelations
                              success:(nullable TYSuccessString)success
                              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数            | 说明                                                   |
| --------------- | ------------------------------------------------------ |
| userName        | 成员名称                                               |
| avatarImage     | 成员头像，不传则为默认头像                             |
| unlockRelations | 成员解锁方式与密码 sn 的关联关系                       |
| success         | 接口成功回调，返回结果为创建的成员用户 id，string 类型 |
| failure         | 接口失败回调                                           |

**`TuyaSmartLockRelationModel ` 数据模型**

| 字段       | 类型             | 描述                         |
| ---------- | ---------------- | ---------------------------- |
| unlockType | TYLockUnlockType | 解锁方式                     |
| sn         | NSInteger        | 关联的密码编号, 范围 0 - 999 |

```objective-c
typedef NS_ENUM(NSUInteger, TYLockUnlockType) {
    TYLockUnlockTypeFingerprint, // 指纹解锁
    TYLockUnlockTypePassword,    // 普通密码解锁
    TYLockUnlockTypeTemporary,   // 临时密码解锁
    TYLockUnlockTypeDynamic,     // 动态密码解锁
    TYLockUnlockTypeCard,        // 卡片解锁
    TYLockUnlockTypeFace,        // 人脸识别解锁
    TYLockUnlockTypeKey,         // 钥匙解锁
};
```

**示例代码**

Objc:

```objective-c
    TuyaSmartLockRelationModel *fingerModel = [[TuyaSmartLockRelationModel alloc] init];
    fingerModel.unlockType = TYLockUnlockTypeFingerprint; // 指纹解锁
    fingerModel.sn = 123;
    
    TuyaSmartLockRelationModel *faceModel = [[TuyaSmartLockRelationModel alloc] init];
    faceModel.unlockType = TYLockUnlockTypeFace; // 人脸解锁
    faceModel.sn = 23;

    // TuyaSmartLockDevice *lock
    // 注意: 这里需要强引用持有
    self.lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"]; 
		[self.lock addLockNormalUserWithUserName:@"user name"
                                 avatarImage:[UIImage imageNamed:@"xxx.png"]
                                   unlockIds:@[fingerModel, faceModel]
                                     success:^(NSString *userId) {
        NSLog(@"result %@", userId);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let finger = TuyaSmartLockRelationModel()
    finger.unlockType = .fingerprint // 指纹解锁
    finger.sn = 123 
        
    let face = TuyaSmartLockRelationModel()
    face.unlockType = .face // 人脸解锁
    face.sn = 23
    // 注意: 这里需要强引用持有
    self.lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")    
    self.lockDevice?.addLockNormalUser(withUserName: "user name", avatarImage: UIImage(named: "xxx.png"), unlockIds: [finger, face], success: { (userId) in
        print("添加用户成功 \(userId)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

#### 更新门锁成员信息

使用 SDK 更新门锁成员信息，包括用户名、头像、解锁密码对应关系等

**接口说明**

```objective-c
- (void)updateLockNormalUserWithUserId:(NSString *)userId
                              userName:(nullable NSString *)userName
                           avatarImage:(nullable UIImage *)avatarImage
                       unlockRelations:(nullable NSArray<TuyaSmartLockRelationModel *> *)unlockRelations
                               success:(nullable TYSuccessBOOL)success
                               failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数            | 说明                                                   |
| --------------- | ------------------------------------------------------ |
| userId          | 成员用户 id，必填                                      |
| userName        | 成员用户名称，可选，不传则不修改                       |
| avatarImage     | 成员用户头像，可选，不传则不修改                       |
| unlockRelations | 成员解锁方式与密码 sn 的关联关系，可选，不传则不修改   |
| success         | 接口成功回调，返回结果为创建的成员用户 id，string 类型 |
| failure         | 接口失败回调                                           |

**示例代码**

Objc:

```objective-c
    TuyaSmartLockRelationModel *fingerModel = [[TuyaSmartLockRelationModel alloc] init];
    fingerModel.unlockType = TYLockUnlockTypeFingerprint; // 指纹解锁
    fingerModel.sn = 123;
    
    TuyaSmartLockRelationModel *faceModel = [[TuyaSmartLockRelationModel alloc] init];
    faceModel.unlockType = TYLockUnlockTypeFace; // 人脸解锁
    faceModel.sn = 23;

    // TuyaSmartLockDevice *lock
    // 注意: 这里需要强引用持有
    self.lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"]; 
    [self.lock updateLockNormalUserWithUserId:@"user id" userName:@"" avatarImage:nil unlockRelations:@[fingerModel,faceModel] success:^(BOOL result) {
        NSLog(@"result %d", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let finger = TuyaSmartLockRelationModel()
    finger.unlockType = .fingerprint // 指纹解锁
    finger.sn = 123 
        
    let face = TuyaSmartLockRelationModel()
    face.unlockType = .face // 人脸解锁
    face.sn = 23
    // 注意: 这里需要强引用持有
    self.lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")  
		self.lockDevice?.updateLockNormalUser(withUserId: "user id", userName: "new user name", avatarImage: nil, unlockRelations: [finger, face], success: { (result) in
		    print("更新结果 \(result)")
     }, failure: { (error) in
        if let e = error {
          print("error \(e)")
        }
     })
```




#### 删除门锁成员

使用 SDK 删除门锁成员信息，删除成员并不会删除已有的密码

**接口说明**

```objective-c
- (void)deleteLockUserWithUserId:(NSString *)userId
                         success:(nullable TYSuccessBOOL)success
                         failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                              |
| ------- | ------------------------------------------------- |
| userId  | 门锁成员用户 id                                   |
| success | 接口成功回调，返回结果为对应的删除结果，bool 类型 |
| failure | 接口失败回调                                      |

**示例代码**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"]; 
    [lock deleteLockUserWithUserId:@"0000004zl1" success:^(BOOL result) {
         NSLog(@"删除结果 %d", result);
    } failure:^(NSError *error) {
         NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")  
    lockDevice?.deleteLockUser(withUserId: "0000004zl1", success: { (result) in
        print("删除结果 \(result)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

### 临时密码

使用 SDK 创建临时密码并在门锁上进行输入后即可开锁

```sequence
title: 临时密码开门

participant 门锁
participant 用户
participant app
participant 云端

note over 用户: 输入 7 位纯数字临时密码
app->云端: 创建临时密码
云端-->app: 返回创建结果
用户->门锁: 在门锁上输入密码，让设备触发更新密码列表
note over 门锁: 更新密码列表
用户->门锁: 输入密码
note over 门锁: 执行
```

#### 获取临时密码列表

使用 SDK 获取临时密码列表，可以查看临时密码的使用状态情况

**接口说明**

```objective-c
- (void)getLockTempPwdListWithSuccess:(nullable void (^)( NSArray<TuyaSmartLockTempPwdModel *> *lockTempPwdModels))success
                              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                               |
| ------- | -------------------------------------------------- |
| success | 接口成功回调，返回结果为对应获取的临时密码数据列表 |
| failure | 接口失败回调                                       |

**`TuyaSmartLockTempPwdModel` 数据模型**

| 字段          | 类型                       | 描述                   |
| ------------- | -------------------------- | ---------------------- |
| phone         | NSString                   | 手机号                 |
| name          | NSString                   | 临时密码名称           |
| invalidTime   | NSTimeInterval             | 失效时间戳，10 位      |
| effectiveTime | NSTimeInterval             | 生效时间戳，10 位      |
| createTime    | NSTimeInterval             | 创建时间戳，13 位      |
| code          | NSInteger                  | 密码唯一 id            |
| sn            | NSInteger                  | 密码编号，关联账号使用 |
| phase         | TYLockTempPwdStatusType    | 密码状态               |
| effective     | TYLockTempPwdEffectiveType | 密码有效性状态         |

```objective-c
// 密码状态
typedef NS_ENUM(NSUInteger, TYLockTempPwdStatusType) {
    TYLockTempPwdStatusTypeRemoved     = 0, // 已删除
    TYLockTempPwdStatusTypeToBeDeleted = 3, // 待删除
    
    TYLockTempPwdStatusTypeToBePubilsh = 1, // 待下发
    TYLockTempPwdStatusTypePublished   = 2, // 已下发
};

// 密码有效性状态
typedef NS_ENUM(NSUInteger, TYLockTempPwdEffectiveType) {
    TYLockMemberStatusTypeInvalid     = 1, // 失效
    TYLockMemberStatusTypeToBePubilsh = 2, // 待下发
    TYLockMemberStatusTypeWorking     = 3, // 使用中
    TYLockMemberStatusTypeToBeDeleted = 4, // 待删除
    TYLockTempPwdEffectiveTypeExpired = 5, // 已过期
};
```

**示例代码**

Objc:

```objective-c
		TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
		[lock getLockTempPwdListWithSuccess:^(NSArray<TuyaSmartLockTempPwdModel *> * _Nullable lockTempPwdModels) {
         NSLog(@"result %@", lockTempPwdModels);
    } failure:^(NSError *error) {
         NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")        
		lockDevice?.getLockTempPwdList(success: { (lockTempPwdModels) in
        print("获取临时密码列表结果 \(lockTempPwdModels)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

#### 创建临时密码

临时密码可以自定义密码的有效期间，当创建完成后，需要在门锁设备上进行同步

**接口说明**

```objective-c
- (void)createLockTempPwd:(NSString *)password
                     name:(NSString *)name
            effectiveDate:(NSDate *)effectiveDate
              invalidDate:(NSDate *)invalidDate
              countryCode:(NSString *)countryCode
                    phone:(NSString *)phone
                  success:(nullable TYSuccessBOOL)success
                  failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数          | 说明                                               |
| ------------- | -------------------------------------------------- |
| password      | 临时密码，纯数字，7 位                             |
| name          | 密码标示名字，创建完成无法再知晓密码，请牢记该密码 |
| effectiveDate | 密码生效时间                                       |
| invalidDate   | 密码失效时间                                       |
| countryCode   | 国家码，例如 86                                    |
| phone         | 手机号码，当创建成功时，会通知给该手机用户         |
| success       | 接口成功回调，返回结果为对应的创建结果，bool 类型  |
| failure       | 接口失败回调                                       |

**示例代码**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    // 创建 20 分钟时效的密码
		NSDate *invalidDate = [NSDate dateWithTimeInterval:60 * 20 sinceDate:[NSDate date]];
    [lock createLockTempPwd:@"1472589"
                       name:@"1472589hkk"
              effectiveDate:[NSDate date]
                invalidDate:invalidDate
                countryCode:@"86"
                      phone:@"13912345678"
                    success:^(BOOL result) {
        NSLog(@"创建结果 %d", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")    
		lockDevice?.createLockTempPwd("1472589", name: "1472589hkk", effectiveDate: Date(), invalidDate: Date(timeIntervalSince1970: 60 * 20), countryCode: "86", phone: "13912345678", success: { (result) in
        print("创建结果 \(result)")
    }, failure: { (error) in
        if let e = error {
           print("error \(e)")
        }
    })
```



#### 删除临时密码

使用 SDK 删除临时密码，删除后需要门锁设备进行更新

**接口说明**

```objective-c
- (void)deleteLockTempPwdWithPwdId:(NSInteger)tempPwdId
                             force:(BOOL)force
                           success:(nullable TYSuccessBOOL)success
                           failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| tempPwdId | 门锁临时密码唯一 id                                          |
| force     | 是否强制删除<br />yes: 不需要等门锁同步，密码列表里面就不再返回；<br />no: 等门锁确认后，才是真的已删除，列表还会返回 |
| success   | 接口成功回调，返回结果为对应的删除结果，bool 类型            |
| failure   | 接口失败回调                                                 |

**示例代码**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];    
    [lock deleteLockTempPwdWithPwdId:1274067 force:YES success:^(BOOL result) {
        NSLog(@"删除结果 %d", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")           
    lockDevice?.deleteLockTempPwd(withPwdId: 1274067, force: true, success: { (result) in
        print("删除结果 \(result)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```




### 动态密码

使用 SDK 获取动态密码并在门锁上进行输入后即可开锁，动态密码有效时间为 5 分钟

```sequence
title: 动态密码开门

participant 门锁
participant 用户
participant app
participant 云端

app->云端: 请求获取动态密码
云端-->app: 返回动态密码结果
app-->用户: 传达密码
note over 用户: 得到动态密码
用户->门锁: 输入动态密码
note over 门锁: 执行

```

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
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    [lock getLockDynamicPasswordWithSuccess:^(NSString *result) {
        NSLog(@"动态密码获取结果 %@", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")
    lockDevice?.getLockDynamicPassword(success: { (pwd) in
        print("动态密码获取结果 \(pwd)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

### 远程开门

在门锁上触发远程开门请求后，使用 SDK 可以进行远程开门

```sequence
Title: 门锁远程开门流程

participant 用户
participant 门锁
participant app

用户->门锁: 操作门锁(4+#)
门锁->app: 发起远程开门请求
note over app: 收到门锁请求，通知门锁拥有者决定确认是否开门
app-->门锁: 发送开门结果
note over 门锁: 处理结果

```

**接口说明**

```objective-c
- (void)replyRemoteUnlock:(BOOL)open
                  success:(nullable TYSuccessHandler)success
                  failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                        |
| ------- | ------------------------------------------- |
| open    | 是否允许开门，yes: 允许开门，no: 不允许开门 |
| success | 接口成功回调                                |
| failure | 接口失败回调                                |

**`TuyaSmartLockDeviceDelegate` 回调说明**

设置 `TuyaSmartLockDevice`  的 `delegate` 之后，当用户操作门锁进行远程开锁时，SDK 会触发以下回调方法

```objc
/// 设备收到远程开锁请求，需要在一定时间内处理该请求
///
/// @param device 门锁设备
/// @param seconds 剩余处理时间
- (void)device:(TuyaSmartLockDevice *)device didReceiveRemoteUnlockRequest:(NSInteger)seconds;
```

**示例代码**

Objc:

```objective-c
    // 用户操作门锁 4+#
	  // TuyaSmartLockDevice *lock;
    self.lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    self.lock.delegate = self;
    
    // 实现代理方法
    - (void)device:(TuyaSmartLockDevice *)device didReceiveRemoteUnlockRequest:(NSInteger)seconds {
        NSLog(@"收到远程开门指令, 需在 %d 秒内处理", seconds);
      	
        // second = 0，说明已经处理过
        // 所以这里要区分情况
        if (seconds > 0) {
            BOOL open = YES; // 是否允许开门
            // 执行远程开门结果
            [device replyRemoteUnlock:open success:^{
                NSLog(@"success");
            } failure:^(NSError *error) {
                NSLog(@"error %@", error);
            }];
        }
    }
```

Swift:

```swift
    // 用户操作门锁 4+#
	  // var lock: TuyaSmartLockDevice
    self.lock = TuyaSmartLockDevice(deviceId: "your_lock_device_id")
    self.lock.delegate = self;
    
    // 实现代理方法
    func device(_ device: TuyaSmartLockDevice, didReceiveRemoteUnlockRequest seconds: Int) {
        print("收到远程开门指令, 需在 \(seconds) 秒内处理";
        if seconds > 0 {
            let open = true; // 是否允许开门
            // 执行远程开门结果
            device.replyRemoteUnlock(open, success: {
                print("success")
            }) { (error) in
                if let e = error {
                    print("error: \(e)")
                }
            }
        }      
    } 
```


### 门锁记录

使用 SDK 获取门锁记录，包括开锁记录、门铃记录、报警记录等

#### 获取门锁记录

**接口说明**

```objective-c
- (void)getLockRecordListWithDpCodes:(NSArray<NSString *> *)dpCodes
                              offset:(NSInteger)offset
                               limit:(NSInteger)limit
                             success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *lockRecordModels))success
                             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                         |
| ------- | ------------------------------------------------------------ |
| dpCodes | 需要查询的记录的 dp code，具体可以参考对应设备的门锁产品功能定义 |
| offset  | 页数                                                         |
| limit   | 条数                                                         |
| success | 接口成功回调，返回结果为对应的记录数据列表                   |
| failure | 接口失败回调                                                 |

**`TuyaSmartLockRecordModel`** 数据模型

| 字段     | 类型                    | 描述                           |
| -------- | ----------------------- | ------------------------------ |
| userId   | NSString                | 成员 id                        |
| userName | NSString                | 用户昵称                       |
| time     | NSTimeInterval          | 发生时间， 13 位时间戳         |
| devId    | NSString                | 设备 id                        |
| dpData   | NSDictionary            | dp 数据                        |
| tags     | NSInteger               | 标位，0表示其他，1表示劫持报警 |
| dpsArray | NSArray<NSDictionary *> | dps 数据组                     |

#### 获取门锁开锁记录

使用 SDK 获取门锁的开门记录，包括指纹解锁、普通密码解锁、临时密码解锁、动态密码解锁、卡片解锁、人脸识别解锁、钥匙解锁记录

**接口说明**

```objective-c
- (void)getUnlockRecordList:(NSInteger)offset
                      limit:(NSInteger)limit
                    success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *lockRecordModels))success
                    failure:(nullable TYFailureError)failure
```

**参数说明**

| 参数    | 说明                                       |
| ------- | ------------------------------------------ |
| offset  | 页数                                       |
| limit   | 条数                                       |
| success | 接口成功回调，返回结果为对应的记录数据列表 |
| failure | 接口失败回调                               |

#### 获取门锁劫持记录

使用 SDK 获取门锁劫持开门记录，可根据传入的解锁功能定义点进行查询

**接口说明**

```objective-c
- (void)getLockHijackRecordListWithDpCodes:(NSArray<NSString *> *)dpCodes
                                    offset:(NSInteger)offset
                                     limit:(NSInteger)limit
                                   success:(void(^)(NSArray<TuyaSmartLockRecordModel *> *))success
                                   failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                         |
| ------- | ------------------------------------------------------------ |
| dpCodes | 需要查询劫持的记录的解锁方式 dp codes，具体可以参考对应设备的门锁产品功能定义 |
| offset  | 页数                                                         |
| limit   | 条数                                                         |
| success | 接口成功回调，返回结果为对应的记录数据列表                   |
| failure | 接口失败回调                                                 |


## Wi-Fi 门锁 Dp Code 表

| dp name              | dp code                        |
| -------------------- | ------------------------------ |
| 指纹解锁             | unlock\_fingerprint            |
| 普通密码解锁         | unlock\_password               |
| 临时密码解锁         | unlock\_temporary              |
| 动态密码解锁         | unlock\_dynamic                |
| 卡片解锁             | unlock\_card                   |
| 人脸识别解锁         | unlock\_face                   |
| 钥匙解锁             | unlock\_key                    |
| 告警                 | alarm\_lock                    |
| 远程开门请求倒计时   | unlock\_request                |
| 远程开门请求回复     | reply\_unlock\_request         |
| 电池电量状态         | battery\_state                 |
| 剩余电量             | residual\_electricity          |
| 反锁状态             | reverse\_lock                  |
| 童锁状态             | child\_lock                    |
| App远程解锁wifi门锁  | unlock\_app                    |
| 劫持告警             | hijack                         |
| 从门内侧打开门锁     | open\_inside                   |
| 开合状态             | closed\_opened                 |
| 门铃呼叫             | doorbell                       |
| 短信通知             | message                        |
| 上提反锁             | anti\_lock\_outside            |
| 虹膜解锁             | unlock\_eye                    |
| 掌纹解锁             | unlock\_hand                   |
| 指静脉解锁           | unlock\_finger\_vein           |
| 同步所有指纹编号     | update\_all\_finger            |
| 同步所有密码编号     | update\_all\_password          |
| 同步所有卡编号       | update\_all\_card              |
| 同步所有人脸编号     | update\_all\_face              |
| 同步所有虹膜编号     | update\_all\_eye               |
| 同步所有掌纹编号     | update\_all\_hand              |
| 同步所有指静脉编号   | update\_all\_fin\_vein         |
| 离线密码解锁上报     | unlock\_offline\_pd            |
| 离线密码清空上报     | unlock\_offline\_clear         |
| 单条离线密码清空上报 | unlock\_offline\_clear\_single |