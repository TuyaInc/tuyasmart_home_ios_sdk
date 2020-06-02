# Wi-Fi Smart Lock Instructions
## Term Explanation

| Term             | Explanation                                                  |
| ---------------- | ------------------------------------------------------------ |
| hijack           | Door lock hijacking refers to setting a specific password (fingerprint, password, etc.) as the hijacking password. <br/> When the user enters this password to open the door, the door lock considers the user to open the door involuntarily, and sends the alarm information to the family's mobile phone or property management system. |
| door lock member | Door lock members are divided into family members and non-family members. <br/> Family members are members who are added to the user's family. The door lock can be used to manage family members and set the unlock mode. <br/> Non-family members are members created in door locks and can be managed through door lock related interfaces. |

### Description

| Class Name                    | **Description**                                              |
| ----------------------------- | ------------------------------------------------------------ |
| `TuyaSmartLockDevice`         | Wi-Fi Lock Device, extend `TuyaSmartDevice`                  |
| `TuyaSmartLockDeviceDelegate` | Wi-Fi Lock Device Delegate, extend `TuyaSmartDeviceDelegate` |



## Feature Description

### Lock Member Management

The door lock can be divided into family members and non-family members. Family members are Tuya home family members. For details, please refer to [Family Management](https://tuyainc.github.io/tuyasmart_home_android_sdk_doc/en/resource/HomeManager.html).

The following describes non-family member management operations in door locks

#### Get Lock Members

**Declaration**

```objective-c
- (void)getLockMemberListWithSuccess:(nullable void(^)(NSArray<TuyaSmartLockMemberModel *> *lockMemberModels))success
                             failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description** |
| ------------- | --------------- |
| success       | Success block   |
| failure       | Failure block   |

**`TuyaSmartLockMemberModel` **

| Field           | Type                                  | **Declaration**                                         |
| --------------- | ------------------------------------- | ------------------------------------------------------- |
| userId          | NSString                              | User id                                                 |
| userName        | NSString                              | User name                                               |
| avatarUrl       | NSString                              | Avatar url                                              |
| contact         | NSString                              | Contact information                                     |
| unlockRelations | NSArray<TuyaSmartLockRelationModel *> | Unlock corresponding number relationship                |
| devId           | NSString                              | Device id                                               |
| ownerId         | NSString                              | Home id                                                 |
| userType        | NS_ENUM                               | Lock member type, 1: family member 2: non-family member |

**Example**

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
        print("result \(members)")
    }, failure: { (error) in
        if let e = error {
           print("error \(e)")
        }
    })
```



#### Create Lock Member

Create non-family members. 

**Declaration**

```objective-c
- (void)addLockNormalUserWithUserName:(NSString *)userName
                          avatarImage:(nullable UIImage *)avatarImage
                      unlockRelations:(nullable NSArray<TuyaSmartLockRelationModel *> *)unlockRelations
                              success:(nullable TYSuccessString)success
                              failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter**       | **Description**                                                   |
| --------------- | ------------------------------------------------------ |
| userName        | User name                                    |
| avatarImage     | User avatar image           |
| unlockRelations | Association between member unlocking method and password sn |
| success         | Success block |
| failure         | Failure block                             |

**`TuyaSmartLockRelationModel `**

| Field      | Type             | **Declaration**                         |
| ---------- | ---------------- | --------------------------------------- |
| unlockType | TYLockUnlockType | Unlock method                           |
| sn         | NSInteger        | Associated password number, range 0-999 |

```objective-c
typedef NS_ENUM(NSUInteger, TYLockUnlockType) {
    TYLockUnlockTypeFingerprint,
    TYLockUnlockTypePassword, 
    TYLockUnlockTypeTemporary,
    TYLockUnlockTypeDynamic,
    TYLockUnlockTypeCard,  
    TYLockUnlockTypeFace,  
    TYLockUnlockTypeKey, 
};
```

**Example**

Objc:

```objective-c
    TuyaSmartLockRelationModel *fingerModel = [[TuyaSmartLockRelationModel alloc] init];
    fingerModel.unlockType = TYLockUnlockTypeFingerprint;
    fingerModel.sn = 123;
    
    TuyaSmartLockRelationModel *faceModel = [[TuyaSmartLockRelationModel alloc] init];
    faceModel.unlockType = TYLockUnlockTypeFace;
    faceModel.sn = 23;

    // TuyaSmartLockDevice *lock
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
    finger.unlockType = .fingerprint
    finger.sn = 123 
        
    let face = TuyaSmartLockRelationModel()
    face.unlockType = .face
    face.sn = 23
    self.lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")    
    self.lockDevice?.addLockNormalUser(withUserName: "user name", avatarImage: UIImage(named: "xxx.png"), unlockIds: [finger, face], success: { (userId) in
        print("add user success \(userId)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

#### Update Lock Member Information

Use SDK to update lock member information, including username, avatar, unlock password correspondence, etc.

**Declaration**

```objective-c
- (void)updateLockNormalUserWithUserId:(NSString *)userId
                              userName:(nullable NSString *)userName
                           avatarImage:(nullable UIImage *)avatarImage
                       unlockRelations:(nullable NSArray<TuyaSmartLockRelationModel *> *)unlockRelations
                               success:(nullable TYSuccessBOOL)success
                               failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter**       | **Description**                                                   |
| --------------- | ------------------------------------------------------ |
| userId          | User id                            |
| userName        | User name, if nil, will not be modified |
| avatarImage     | User avatar image, optional, if nil, will not be modified |
| unlockRelations | Association between member unlocking method and password sn, optional, if nil, will not be modified |
| success         | Success block |
| failure         | Failure block                              |

**Example**

Objc:

```objective-c
    TuyaSmartLockRelationModel *fingerModel = [[TuyaSmartLockRelationModel alloc] init];
    fingerModel.unlockType = TYLockUnlockTypeFingerprint;
    fingerModel.sn = 123;
    
    TuyaSmartLockRelationModel *faceModel = [[TuyaSmartLockRelationModel alloc] init];
    faceModel.unlockType = TYLockUnlockTypeFace;
    faceModel.sn = 23;

    // TuyaSmartLockDevice *lock
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
    finger.unlockType = .fingerprint
    finger.sn = 123 
        
    let face = TuyaSmartLockRelationModel()
    face.unlockType = .face 
    face.sn = 23
    self.lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")  
    self.lockDevice?.updateLockNormalUser(withUserId: "user id", userName: "new user name", avatarImage: nil, unlockRelations: [finger, face], success: { (result) in
        print("result \(result)")
     }, failure: { (error) in
        if let e = error {
          print("error \(e)")
        }
     })
```

#### Delete Lock Member

Use the SDK to delete door lock member information. Deleting members does not delete existing passwords

**Declaration**

```objective-c
- (void)deleteLockUserWithUserId:(NSString *)userId
                         success:(nullable TYSuccessBOOL)success
                         failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description** |
| ------------- | --------------- |
| userId        | User id         |
| success       | Success block   |
| failure       | Failure block   |

**Example**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"]; 
    [lock deleteLockUserWithUserId:@"0000004zl1" success:^(BOOL result) {
         NSLog(@"delete result %d", result);
    } failure:^(NSError *error) {
         NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")  
    lockDevice?.deleteLockUser(withUserId: "0000004zl1", success: { (result) in
        print("delete result \(result)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

### Temporary Password

Use the SDK to create a temporary password and enter it on the door lock to unlock it.

```sequence
title: Unlock with temporary password

participant lock
participant user
participant app
participant server

note over user: enter a 7-digit,\n numeric-only temporary password
app->server: create temporary password
server-->app: return result
user->lock: enter the password on the door lock, \nand the device trigger \nthe update of the password list
note over lock: update of the password list
user->lock: enter password 
note over lock: execute
```

#### Create Temporary Password

The temporary password can customize the validity period of the password. When the password is created, it needs to be synchronized on the door lock device.

**Declaration**

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

**Parameters**

| **Parameter**     | **Description**                                               |
| ------------- | -------------------------------------------------- |
| password      | Temporary password, pure number, 7 digits |
| name          | The password is marked with a name. You can no longer know the password after creation. Please remember it |
| effectiveDate | Password effective date          |
| invalidDate   | Password invalid date                |
| countryCode   | Country code，example 86               |
| phone         | Mobile phone number, when the creation is successful, the mobile phone user will be notified |
| success       | Success block |
| failure       | Failure block                          |

**Example**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    // 20 minute
    NSDate *invalidDate = [NSDate dateWithTimeInterval:60 * 20 sinceDate:[NSDate date]];
    [lock createLockTempPwd:@"1472589"
                       name:@"1472589hkk"
              effectiveDate:[NSDate date]
                invalidDate:invalidDate
                countryCode:@"86"
                      phone:@"13912345678"
                    success:^(BOOL result) {
        NSLog(@"result %d", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")    
    lockDevice?.createLockTempPwd("1472589", name: "1472589hkk", effectiveDate: Date(), invalidDate: Date(timeIntervalSince1970: 60 * 20), countryCode: "86", phone: "13912345678", success: { (result) in
        print("result \(result)")
    }, failure: { (error) in
        if let e = error {
           print("error \(e)")
        }
    })
```

#### Get Temporary Password List

Use the SDK to get a list of temporary passwords, you can view the status of the use of temporary passwords

**Declaration**

```objective-c
- (void)getLockTempPwdListWithSuccess:(nullable void (^)( NSArray<TuyaSmartLockTempPwdModel *> *lockTempPwdModels))success
                              failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                               |
| --------- | -------------------------------------------------- |
| success   | Success block |
| failure   | Failure block                        |

**`TuyaSmartLockTempPwdModel` **

| Field         | Type                       | **Declaration**              |
| ------------- | -------------------------- | ---------------------------- |
| phone         | NSString                   | Phone number                 |
| name          | NSString                   | Password name                |
| invalidTime   | NSTimeInterval             | Invalid timestamp, 10 length |
| effectiveTime | NSTimeInterval             | Effective timestamp          |
| createTime    | NSTimeInterval             | Created timestamp            |
| code          | NSInteger                  | Id                           |
| sn            | NSInteger                  | Password sn                  |
| phase         | TYLockTempPwdStatusType    | Password phase               |
| effective     | TYLockTempPwdEffectiveType | Password effective           |

```objective-c
// password status
typedef NS_ENUM(NSUInteger, TYLockTempPwdStatusType) {
    TYLockTempPwdStatusTypeRemoved     = 0,
    TYLockTempPwdStatusTypeToBeDeleted = 3,
    
    TYLockTempPwdStatusTypeToBePubilsh = 1,
    TYLockTempPwdStatusTypePublished   = 2,
};

// password effective status
typedef NS_ENUM(NSUInteger, TYLockTempPwdEffectiveType) {
    TYLockMemberStatusTypeInvalid     = 1,
    TYLockMemberStatusTypeToBePubilsh = 2,
    TYLockMemberStatusTypeWorking     = 3,
    TYLockMemberStatusTypeToBeDeleted = 4,
    TYLockTempPwdEffectiveTypeExpired = 5,
};
```

**Example**

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
        print("result \(lockTempPwdModels)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

#### Delete Temporary Password

Use the SDK to delete the temporary password. After the deletion, the door lock device needs to be updated.

**Declaration**

```objective-c
- (void)deleteLockTempPwdWithPwdId:(NSInteger)tempPwdId
                             force:(BOOL)force
                           success:(nullable TYSuccessBOOL)success
                           failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                                         |
| --------- | ------------------------------------------------------------ |
| tempPwdId | Id                                       |
| force     | Whether to forcibly delete <br /> yes: No need to wait for door lock synchronization, the password list will not be returned; <br /> no: After the door lock is confirmed, it is really deleted, and the list will be returned |
| success   | Success block |
| failure   | Failure block                                  |

**Example**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];    
    [lock deleteLockTempPwdWithPwdId:1274067 force:YES success:^(BOOL result) {
        NSLog(@"delete result %d", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")           
    lockDevice?.deleteLockTempPwd(withPwdId: 1274067, force: true, success: { (result) in
        print("delete result \(result)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```

### Dynamic Password

Use the SDK to get a dynamic password and enter it on the door lock to unlock. The dynamic password is valid for 5 minutes.

```sequence
title: Unlock with dynamic password

participant lock
participant user
participant app
participant server

app->server: Request for dynamic password
server-->app: Returns dynamic password results
app-->user: Send password
note over user: Get dynamic password
user->lock: Input dynamic password
note over lock: Execute

```

#### Get Dynamic Password

**Declaration**

```objective-c
- (void)getLockDynamicPasswordWithSuccess:(nullable TYSuccessString)success
                                  failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                       |
| --------- | ------------------------------------------ |
| success   | Success block |
| failure   | Failure block                |

**Example**

Objc:

```objective-c
    TuyaSmartLockDevice *lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    [lock getLockDynamicPasswordWithSuccess:^(NSString *result) {
        NSLog(@"Dynamic password acquisition results %@", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartLockDevice(deviceId: "your_lock_device_id")
    lockDevice?.getLockDynamicPassword(success: { (pwd) in
        print("Dynamic password acquisition results \(pwd)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```




### Open the Lock Remotely

After triggering a remote door open request on the door lock, you can use the SDK to remotely open the door

```sequence
Title: Remote Open

participant User
participant Lock
participant app

User->Lock: operate lock (4+#)
Lock->app: send open request
note over app: receive open request
app-->Lock: send open result
note over Lock: handle result

```

**Declaration**

```objective-c
- (void)replyRemoteUnlock:(BOOL)open
                  success:(nullable TYSuccessHandler)success
                  failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                        |
| --------- | ------------------------------------------- |
| open      | Whether door opening is allowed<br />yes: door opening is allowed, <br />no: door opening is not allowed |
| success   | Success block                    |
| failure   | Failure block                 |

**`TuyaSmartLockDeviceDelegate` **

After set `TuyaSmartLockDevice`  `delegate` ，When the user operates the door lock for remote unlocking, the SDK will trigger the following callback method

```objc
- (void)device:(TuyaSmartLockDevice *)device didReceiveRemoteUnlockRequest:(NSInteger)seconds;
```

**Example**

Objc:

```objective-c
    // 4+#
    // TuyaSmartLockDevice *lock;
    self.lock = [TuyaSmartLockDevice deviceWithDeviceId:@"your_lock_device_id"];
    self.lock.delegate = self;
    
    - (void)device:(TuyaSmartLockDevice *)device didReceiveRemoteUnlockRequest:(NSInteger)seconds {
        NSLog(@"receive unlock request, last second %d", seconds);
        
        // second = 0，did reply
        if (seconds > 0) {
            BOOL open = YES;
            // execute reply remote
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
    // 4+#
    // var lock: TuyaSmartLockDevice
    self.lock = TuyaSmartLockDevice(deviceId: "your_lock_device_id")
    self.lock.delegate = self;

    func device(_ device: TuyaSmartLockDevice, didReceiveRemoteUnlockRequest seconds: Int) {
        print("receive unlock request, last second \(seconds) ";
        if seconds > 0 {
            let open = true; 
            // execute reply remote
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


### Lock Record

Use SDK to obtain door lock records, including unlock records, doorbell records, alarm records, etc.

#### Get Lock Records

**Declaration**

```objective-c
- (void)getLockRecordListWithDpCodes:(NSArray<NSString *> *)dpCodes
                              offset:(NSInteger)offset
                               limit:(NSInteger)limit
                             success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *lockRecordModels))success
                             failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                              |
| ------------- | ------------------------------------------------------------ |
| dpCodes       | Need to query the unlocking method of hijacked records dp codes. for details, please refer to the function definition of the lock of the corresponding device. |
| offset        | Data page number                                             |
| limit         | Data number                                                  |
| success       | Success block                                                |
| failure       | Failure block                                                |

**`TuyaSmartLockRecordModel`** 

| Field    | Type                    | **Declaration**                             |
| -------- | ----------------------- | ------------------------------------------- |
| userId   | NSString                | User id                                     |
| userName | NSString                | User name                                   |
| time     | NSTimeInterval          | Timestamp, 13 digits                        |
| devId    | NSString                | Device id                                   |
| dpData   | NSDictionary            | Data point                                  |
| tags     | NSInteger               | Tags，0 means other, 1 means hijack warning |
| dpsArray | NSArray<NSDictionary *> | Data point list                             |

#### Get Door Lock Unlock Records

Use SDK to obtain door lock records, including unlock records, doorbell records, alarm records, etc.

**Declaration**

```objective-c
- (void)getUnlockRecordList:(NSInteger)offset
                      limit:(NSInteger)limit
                    success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *lockRecordModels))success
                    failure:(nullable TYFailureError)failure
```

**Parameters**

| Parameter | **Description**                                             |
| --------- | ----------------------------------------------------------- |
| offset    | Data page number                                            |
| limit     | Data number                                                 |
| success   | Success block, result is the corresponding record data list |
| failure   | Failure block                                               |

#### Get Lock Hijacking Record

Use the SDK to obtain the door lock hijacking record. You can query it based on the unlocking function definition point.

**Declaration**

```objective-c
- (void)getLockHijackRecordListWithDpCodes:(NSArray<NSString *> *)dpCodes
                                    offset:(NSInteger)offset
                                     limit:(NSInteger)limit
                                   success:(void(^)(NSArray<TuyaSmartLockRecordModel *> *))success
                                   failure:(nullable TYFailureError)failure;
```

**Parameters**

| **Parameter** | **Description**                                              |
| ------------- | ------------------------------------------------------------ |
| dpCodes       | Need to query the unlocking method of hijacked records dp codes. for details, please refer to the function definition of the door lock of the corresponding device. |
| offset        | Data page number                                             |
| limit         | Data number                                                  |
| success       | Success block                                                |
| failure       | Failure block                                                |



## Wi-Fi Door Lock Function Points
| dp name                              | dp code                        |
| ------------------------------------ | ------------------------------ |
| unlock by fingerprint                | unlock\_fingerprint            |
| unlock by password                   | unlock\_password               |
| unlock by temporary password         | unlock\_temporary              |
| unlock by dynamic password           | unlock\_dynamic                |
| unlock by card                       | unlock\_card                   |
| unlock by face                       | unlock\_face                   |
| unlock by key                        | unlock\_key                    |
| alarm record                         | alarm\_lock                    |
| apply remote unlock                  | unlock\_request                |
| reply remote unlock                  | reply\_unlock\_request         |
| battery status                       | battery\_state                 |
| residual electricity                 | residual\_electricity          |
| lock from inside                     | reverse\_lock                  |
| child lock status                    | child\_lock                    |
| unlock by app                        | unlock\_app                    |
| hijack alarm record                  | hijack                         |
| open the door from inside            | open\_inside                   |
| door opening and closing status      | closed\_opened                 |
| doorbell alarm record                | doorbell                       |
| SMS notifacation                     | message                        |
| lock from outside                    | anti\_lock\_outside            |
| unlock by eye                        | unlock\_eye                    |
| unlock by hand                       | unlock\_hand                   |
| unlock by finger vein                | unlock\_finger\_vein           |
| update all finger record             | update\_all\_finger            |
| update all password record           | update\_all\_password          |
| update all card record               | update\_all\_card              |
| update all face record               | update\_all\_face              |
| update all eye record                | update\_all\_eye               |
| update all hand record               | update\_all\_hand              |
| update all finger vein record        | update\_all\_fin\_vein         |
| offline password unlock report       | unlock\_offline\_pd            |
| offline password clear report        | unlock\_offline\_clear         |
| single offline password clear report | unlock\_offline\_clear\_single |