# BLE Smart Lock Instructions

## Term Explanation

| Term                   | Explanation                                                  |
| ---------------------- | ------------------------------------------------------------ |
| hijack                 | Door lock hijacking refers to setting a specific password (fingerprint, password, etc.) as the hijacking password. <br/> When the user enters this password to open the door, the door lock considers the user to open the door involuntarily, and sends the alarm information to the family's mobile phone or property management system. |
| door lock member       | Door lock members are divided into family members and non-family members. <br/> Family members are members who are added to the user's family. The door lock can be used to manage family members and set the unlock mode. <br/> Non-family members are members created in door locks and can be managed through door lock related interfaces. |
| lockUserId and userId | `lockUserId` is the firmware member id assigned to the device by the cloud when creating the door lock member. <br />`userId` is the database record id assigned by the cloud when creating the door lock member, means the user's unique id |

### Description

| Class Name                       | **Description**                                            |      |
| -------------------------------- | ---------------------------------------------------------- | ---- |
| `TuyaSmartBLELockDevice`         | BLE Lock Device, extend `TuyaSmartDevice`                  |      |
| `TuyaSmartBLELockDeviceDelegate` | BLE Lock Device Delegate, extend `TuyaSmartDeviceDelegate` |      |

## Feature Description

### Connection status

The Bluetooth door lock requires the App to turn on Bluetooth before some features can be used normally. The SDK will automatically connect, usually use the following methods to determine the device connection status.

```objective-c
/// If not connect or disconnected during use, call this method to connect
- (void)autoConnect;

/// Whether the device and mobile phone have established a Bluetooth connection, if it is NO, call `autoConnect` to connect device
- (BOOL)isBLEConnected;
```

### Dynamic Password

#### Get Dynamic Password

**Declaration**

```objective-c
- (void)getLockDynamicPasswordWithSuccess:(nullable TYSuccessString)success
                                  failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description                          |
| --------- | ------------------------------------ |
| success   | Success block, dynamic password list |
| failure   | Failure block                        |

**Example**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
    [lock getLockDynamicPasswordWithSuccess:^(NSString *result) {
        NSLog(@"result %@", result);
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")
    lockDevice?.getLockDynamicPassword(success: { (pwd) in
        print("result \(pwd)")
    }, failure: { (error) in
        if let e = error {
            print("error \(e)")
        }
    })
```



### BLE Unlock

```sequence
Title: BLE Unlock

participant user
participant app
participant lock

note over app: bluetooth open, lock device connected
user->app: unlock
app->lock: use ble send unlock command data
note over lock: receive command, execute
lock-->app: send unlock result
note over app: show result
```

**Declaration**

```objective-c
- (void)unlockWithStatus:(BOOL)status
                 success:(nullable TYSuccessHandler)success
                 failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| status    | Unlock status |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
		BOOL status = YES;
    [lock unlockWithStatus:status success:^{
      	NSLog(@"unlock success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")		
		self.lock?.unlock(withStatus: status, success: {
        print("unlock success")
    }, failure: { (error) in
        if let e = error {
        		print("error: \(e)")
        }    
    })
```

**Declaration**

```objective-c
- (void)manualLockWithStatus:(BOOL)status
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description       |
| --------- | ----------------- |
| status    | Unlock status     |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objective-c
    TuyaSmartBLELockDevice *lock = [TuyaSmartBLELockDevice deviceWithDeviceId:@"your_lock_device_id"];
		BOOL status = YES;
    [lock manualLockWithStatus:status success:^{
      	NSLog(@"unlock success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    let lockDevice = TuyaSmartBLELockDevice(deviceId: "your_lock_device_id")		
		self.lock?.manualLock(withStatus: status, success: {
        print("unlock success")
    }, failure: { (error) in
        if let e = error {
        		print("error: \(e)")
        }    
    })
```

### Lock Record

#### Get Lock Records

**Declaration**

```objective-c
- (void)getAlarmRecordListWithOffset:(int)offset
                               limit:(int)limit
                             success:(nullable void(^)(NSArray<TuyaSmartLockRecordModel *> *records))success
                             failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description                     |
| --------- | ------------------------------- |
| offset    | Data page number                |
| limit     | Data number                     |
| success   | Success block, lock record list |
| failure   | Failure block                   |

**`TuyaSmartLockRecordModel`**

| Field    | Type                    | Declaration                                 |
| -------- | ----------------------- | ------------------------------------------- |
| userId   | NSString                | User id                                     |
| userName | NSString                | User name                                   |
| time     | NSTimeInterval          | Timestamp, 13 digits                        |
| devId    | NSString                | Device id                                   |
| dpData   | NSDictionary            | Dp point data                               |
| tags     | NSInteger               | Tags，0 means other, 1 means hijack warning |
| dpsArray | NSArray<NSDictionary *> | Data point list                             |

**Example**

Objc:

```objective-c
    [self.lock getAlarmRecordListWithOffset:0 limit:50 success:^(NSArray<TuyaSmartLockRecordModel *> * _Nonnull records) {
        NSLog(@"alarm records: %@", records);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getAlarmRecordList(withOffset: 0, limit: 50, success: { (records) in
        print("alarm records: \(records)")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }
    })
```

#### Get Door Lock Unlock Records

**Declaration**

```objective-c
- (void)getUnlockRecordListWithOffset:(int)offset
                                limit:(int)limit
                              success:(nullable void(^)(NSArray<TuyaSmartBLELockRecordModel *> *records))success
                              failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description                        |
| --------- | ---------------------------------- |
| offset    | Data page number                   |
| limit     | Data number                        |
| success   | Success block, unlock records list |
| failure   | Failure block                      |

**Example**

Objc:

```objective-c
    [self.lock getUnlockRecordListWithOffset:0 limit:50 success:^(NSArray<TuyaSmartLockRecordModel *> * _Nonnull records) {
        NSLog(@"unlock records: %@", records);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getUnlockRecordList(withOffset: 0, limit: 50, success: { (records) in
        print("unlock records \(records)")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }
    })
```



### Lock Member

#### Create Lock Member

SDK support add member for lock device

```sequence
Title: create lock member

participant app
participant server

note over app: write member info
app->server: send create member request
server-->app: response result
note over app: show result
```

**Declaration**

```objective-c
- (void)addMemberWithUserName:(NSString *)userName
                  allowUnlock:(BOOL)allowUnlock
                     timeType:(TYMemberTimeType)timeType
                effectiveDate:(NSDate *)effectiveDate
                  invalidDate:(NSDate *)invalidDate
                      success:(nullable TYSuccessBOOL)success
                      failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter     | Description                                            |
| ------------- | ------------------------------------------------------ |
| userName      | User name                                              |
| allowUnlock   | Allow unlock                                           |
| timeType      | `TYMemberTimeTypePermanent` ,  `TYMemberTimeTypePhase` |
| effectiveDate | Effective date                                         |
| invalidDate   | Invalid date                                           |
| success       | Success block                                          |
| failure       | Failure block                                          |

**Example**

Objc:

```objective-c
    [self.lock addMemberWithUserName:#<member name># allowUnlock:YES timeType:TYMemberTimeTypePhase effectiveDate:[NSDate date] invalidDate:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 8] success:^(BOOL result) {
        NSLog(@"create success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.addMember(withUserName: "name", allowUnlock: true, timeType: .phase, effectiveDate: Date(), invalidDate: Date().addingTimeInterval(60 * 60 * 8), success: { (result) in
        print("create success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }     
    })
```

#### Update Lock Member Information

SDK provides the function of modifying the members of the lock. The members of the lock will interact with the hardware and require the device to maintain a Bluetooth connection.

```sequence
Title: Update Lock Member

participant server
participant app
participant lock

note over app: write new user info
app->lock: create bluetooth connection
app->lock: send device update member command data
lock-->app: receive device update result
app->server: send request, update member
server-->app: return result
note over app: show result
```

**Declaration**

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

**Parameters**

| Parameter     | Description                                          |
| ------------- | ---------------------------------------------------- |
| userName      | User name                                            |
| memberId      | Member id                                            |
| allowUnlock   | Allow unlock                                         |
| timeType      | `TYMemberTimeTypePermanent`, `TYMemberTimeTypePhase` |
| effectiveDate | Effective date                                       |
| invalidDate   | Invalid date                                         |
| success       | Success block                                        |
| failure       | Failure block                                        |

**Example**

Objc:

```objective-c
    [self.lock updateMemberWithUserName:@"new name" memberId:@"0000008byw" allowUnlock:YES timeType:TYMemberTimeTypePermanent effectiveDate:[NSDate date] invalidDate:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 8] success:^(BOOL result) {
        NSLog(@"update success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.updateMember(withUserName: "new name", memberId: "0000008byw", allowUnlock: true, timeType: .phase, effectiveDate: Date(), invalidDate: Date().addingTimeInterval(60 * 60 * 8), success: { (result) in
            print("update success")
        }, failure: { (error) in
        		if let e = error {
            		print("error: \(e)")
        		} 
        })
```


#### Get Lock Members List

**Declaration**

```objective-c
- (void)getMemberListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockMemberModel *> *members))success
                         failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| success   | Success block |
| failure   | Failure block |

**`TuyaSmartBLELockMemberModel` **

| Field            | Type       | Declaration                                         |
| ---------------- | ---------- | --------------------------------------------------- |
| userId           | NSString   | user id                                             |
| userContact      | NSString   | Contact                                             |
| avatarUrl        | NSString   | Avatar url                                          |
| nickName         | NSString   | Name                                                |
| userTimeSet      | NSString   | member time data                                    |
| phase            | NSUInteger | Freeze condition, 0: freeze, 1: unfreeze            |
| status           | NSUInteger | user status                                         |
| lockUserId       | int        | user id of device                                   |
| userType         | NSUInteger | user type, 10:admin 20:normal user 30: no-name user |
| supportOpenType  | NSArray    | support unlock type                                 |
| shareUser        | NSString   | Share user id                                       |
| productAttribute | NSUInteger | Product info                                        |

**Example**

Objc:

```objective-c
    [self.lock getMemberListWithSuccess:^(NSArray<TuyaSmartBLELockMemberModel *> * _Nonnull list) {
        NSLog(@"member list %@", list);
    } failure:^(NSError *error) {
				NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getMemberList(success: { (list) in
        print("member list \(list)")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }
    })
```



#### Delete Lock Member

SDK provides the feature of deleting the member of the lock. The member of the lock will interact with the hardware and delete all unlocking methods and passwords of the user. The operation requires the device to maintain a bluetooth connection.

```sequence
Title: Delete Lock Member

participant server
participant app
participant lock

note over app: delete member
app->lock: create bluetooth connection
app->lock: send delete user command data
lock-->app: response command result
app->server: send delete user reques
server-->app: response result
note over app: show result
```

**Declaration**

```objective-c
- (void)removeMemberWithMemberId:(NSString *)memberId
                         success:(nullable TYSuccessBOOL)success
                         failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description   |
| --------- | ------------- |
| memberId  | Member id |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objective-c
    [self.lock removeMemberWithMemberId:@"000000747d" success:^(BOOL result) {
        NSLog(@"delete lock member success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeMember(withMemberId: "", success: { (result) in
    		print("delete lock member success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }     
    })
```

### Password Unlock

#### Add Password

SDK provides the feature of adding a password, ** The timeliness of the password follows the timeliness of the members, and the device needs to maintain a Bluetooth connection when adding**

```sequence
Title: Add Password

participant server
participant app
participant lock

note over app: input password info
app->lock: create bluetooth connection
app->lock: send add password command data
lock-->app: response command result
app->server: send add password request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)addPasswordForMemberWithMemberId:(NSString *)memberId
                                password:(NSString *)password
                              unlockName:(NSString *)unlockName
                           needHijacking:(BOOL)needHijacking
                                 success:(nullable TYSuccessString)success
                                 failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter    | Description          |
| ------------- | -------------------- |
| memberId      | Member id        |
| password      | Password, number       |
| unlockName    | Password name            |
| needHijacking | Need Hijacking |
| success       | Success block        |
| failure       | Failure block        |

**Example**

Objc:

```objective-c
    [self.lock addPasswordForMemberWithMemberId:@"00000074zg" password:@"774642" unlockName:@"password774642" needHijacking:YES success:^(NSString *result) {
         NSLog(@"create success");
    } failure:^(NSError *error) {
         NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    self.lock?.addPasswordForMember(withMemberId: "00000074zg", password: "774642", unlockName: "password774642", needHijacking: true, success: { (result) in
        print("create success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }             
    })
```

#### Get Password List

**Declaration**

```objective-c
- (void)getPasswordListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                           failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description                 |
| --------- | --------------------------- |
| success   | Success block, password list |
| failure   | Failure block               |

**`TuyaSmartBLELockOpmodeModel` **

| Field           | Type       | Declaration                                                  |
| --------------- | ---------- | ------------------------------------------------------------ |
| opmode          | NSString   | Unlock type                                                  |
| sourceAttribute | NSUInteger | Source of unlock type, 1: app 2: lock offline input 3: lock administrator entry |
| unlockName      | NSString   | Unlock name                                                  |
| userName        | NSString   | Unlock user name                                             |
| lockUserId      | long long  | Lock user id                                                 |
| userId          | NSString   | Member id                                                    |
| opmodeValue     | NSString   | Lock id                                                      |
| opmodeId        | NSString   | Dp id                                                        |
| unlockAttr      | NSUInteger | Unlock attribute                                             |

**Example**

Objc:

```objective-c
    [self.lock getPasswordListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"password list %@", models);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getPasswordList(success: { (models) in
    		print("password list \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }               
    })
```



#### Delete Password

SDK provides the feature of deleting ordinary passwords, ** requires the device to maintain bluetooth connection when deleting **

```sequence
Title: Delete Password

participant server
participant app
participant lock

note over app: delete password
app->lock: create bluetooth connection
app->lock: send delete command data
lock-->app: reponse delete result
app->server: send delete request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)removePasswordForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                       success:(TYSuccessHandler)success
                                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameter   | Description                    |
| ----------- | ------------------------------ |
| opmodeModel | Unlock model, from unlock list |

**Example**

Objc:

```objective-c
    [self.lock removePasswordForMemberWithOpmodeModel:model success:^{
        NSLog(@"delete success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    self.lock?.removePasswordForMember(with: model, success: {
        print("delete success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }                
    })
```



### Fingerprint Unlock

#### Add Fingerprint

SDK provide the feature of adding fingerprint unlock, adding fingerprint unlock requires frequent interaction with the device, ** the device needs to maintain bluetooth connection when adding **

```sequence
Title: Add Fingerprint


participant user
participant lock
participant app
participant server

user->app: start request add fingerprint
app->lock: create bluetooth connection
app->lock: send add fingerprint command data
lock-->app: reply to unlock fingerprint request.\n need to enter the number of times information, etc.
note over app: show information

user->lock: 1. input fingerprint
lock-->app: 1.return the input result, the remaining input information
note over app: 1. show input information

user->lock: 2. input fingerprint
lock-->app: 2. return the input result, the remaining input information
note over app: 2. show input information

user->lock: ...input fingerprint

user->lock: input fingerprint
lock-->app: input fingerprint finish, return result
note over app: show result
note over app: merge result data
app->server: send add unlock request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)addFingerPrintForMemberWithMemberId:(NSString *)memberId
                                 unlockName:(NSString *)unlockName
                              needHijacking:(BOOL)needHijacking
                                    success:(TYSuccessString)success
                                    failure:(TYFailureError)failure;
```

**Parameters**

| Parameter    | Description          |
| ------------- | -------------------- |
| memberId      | Member id        |
| unlockName    | Unlock name            |
| needHijacking | Need hijacking |
| success       | Success block       |
| failure       | Failure block        |

**Example**

Objc:

```objective-c
    // set delegate
    self.lock.delegate = self;
    [self.lock addFingerPrintForMemberWithMemberId:@"00000074zg" unlockName:@"add fingerprint" needHijacking:YES success:^(NSString *result) {
        NSLog(@"add success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];

// TuyaSmartBLELockDeviceDelegate
    - (void)device:(TuyaSmartBLELockDevice *)device didReceiveAddOpMessage:(TuyaSmartBLELockOpMessageModel *)opMessage {
        NSLog(@"Received new unlock method callback message");
    }
```

Swift:

```swift
    self.lock?.delegate = self
    self.lock?.addFingerPrintForMember(withMemberId: "", unlockName: "", needHijacking: true, success: { (result) in
        print("add success")      
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }             
    })

// TuyaSmartBLELockDeviceDelegate
    extension ViewController :TuyaSmartBLELockDeviceDelegate {
    
    func device(_ device: TuyaSmartBLELockDevice, didReceiveAddOpMessage opMessage: TuyaSmartBLELockOpMessageModel) {
        print("Received new unlock method callback message")
    }
}
```



#### Get Fingerprint List

**Declaration**

```objective-c
- (void)getFingerPrintListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                              failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description             |
| --------- | ----------------------- |
| success   | Success block, fingerprint list |
| failure   | Failure block           |

**Example**

Objc:

```objective-c
    [self.lock getFingerPrintListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"fingerprint list %@", models);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getFingerPrintList(success: { (models) in
    		print("fingerprint list \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }               
    })
```



#### Delete Fingerprint

SDK provides the feature of deleting fingerprints, ** requires the device to maintain bluetooth connection when deleting **

```sequence
Title: Delete Fingerprint

participant server
participant app
participant lock

note over app: delete fingerprint
app->lock: create bluetooth connection
app->lock: send delete fingerprint command data
lock-->app: response delete result
app->server: send delete request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)removeFingerPrintForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                       	  success:(TYSuccessHandler)success
                                          failure:(TYFailureError)failure;
```

**Parameters**

| Parameter   | Description                    |
| ----------- | ------------------------------ |
| opmodeModel | Unlock model, from unlock list |

**Example**

Objc:

```objective-c
    [self.lock removeFingerPrintForMemberWithOpmodeModel:model success:^{
        NSLog(@"delete success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeFingerPrintForMember(with: model, success: {
        print("delete success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }                
    })
```

### Card Unlock

#### Add Card

SDK provides the function of adding a card to unlock, ** Requires the device to maintain a bluetooth connection when adding **

```sequence
Title: Add Card

participant server
participant app
participant lock

note over app: add card info
app->lock: create bluetooth connection
app->lock: send add card command data
lock-->app: response add result
app->server: send add card request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)addCardForMemberWithMemberId:(NSString *)memberId
                          unlockName:(NSString *)unlockName
                       needHijacking:(BOOL)needHijacking
                             success:(TYSuccessString)success
                             failure:(TYFailureError)failure;
```

**Parameters**

| Parameter    | Description          |
| ------------- | -------------------- |
| memberId      |  Member id        |
| unlockName    | Unlock name            |
| needHijacking | Need hijacking |
| success       | Success block        |
| failure       | Failure block        |

**Example**

Objc:

```objective-c
    [self.lock addCardForMemberWithMemberId:@"00000074zg" unlockName:@"card 1" needHijacking:YES success:^(NSString *result) {
         NSLog(@"add card success");
    } failure:^(NSError *error) {
         NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.addCardForMember(withMemberId: "00000074zg", unlockName: "card 1", needHijacking: true, success: { (result) in
        print("add card success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }             
    })
```

#### Get Card list

**Declaration**

```objective-c
- (void)getCardListWithSuccess:(nullable void(^)(NSArray<TuyaSmartBLELockOpmodeModel *> *models))success
                       failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description                 |
| --------- | --------------------------- |
| success   | Success block, card list |
| failure   | Failure block               |

**Example**

Objc:

```objective-c
    [self.lock getCardListWithSuccess:^(NSArray<TuyaSmartBLELockOpmodeModel *> * _Nonnull models) {
				NSLog(@"card list %@", models);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.getCardList(success: { (models) in
    		print("card list \(models)")  
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }               
    })
```



#### Delete Card

SDK provides the function of deleting the card, ** Requires the device to maintain bluetooth connection when deleting **

```sequence
Title: Delete Card

participant server
participant app
participant lock

note over app: start delete card
app->lock: create bluetooth connection
app->lock: send delete card command data
lock-->app: response delete result
app->server: send delete request
server-->app: return result
note over app: show result
```

**Declaration**

```objective-c
- (void)removeCardForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                   success:(TYSuccessHandler)success
                                   failure:(TYFailureError)failure;
```

**Parameters**

| Parameter   | Description                    |
| ----------- | ------------------------------ |
| opmodeModel | Unlock model, from unlock list |

**Example**

Objc:

```objective-c
    [self.lock removeCardForMemberWithOpmodeModel:model success:^{
        NSLog(@"delete success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    self.lock?.removeCardForMember(with: model, success: {
        print("delete success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }                
    })
```

### Universal Unlock Operation

#### Add Universal Unlock

SDK provides the function of adding a universal unlocking method, ** Requires the device to maintain a bluetooth connection when adding **

```sequence
Title: Add Universal Unlock

participant server
participant app
participant lock

note over app: start add
app->lock: create bluetooth connection
app->lock: send add unlock command data 
lock-->app: response add result
app->server: send add unlock request
server-->app: return result
note over app: show result
```

**Declaration**

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

**Parameters**

| Parameter     | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| memberId      | Member id                                                    |
| isAdmin       | The member is admin                                          |
| unlockDpCode  | The dp code corresponding to the unlocking method, you can view the product definition in detail, such as card unlocking, code = unlock_card |
| unlockOpType  | TYUnlockOpType enum                                          |
| unlockName    | Unlock name                                                  |
| effectiveDate | Effective date                                               |
| invalidDate   | Invalid date                                                 |
| times         | Unlock times                                                 |
| dataLength    | Data length, equals data content length                      |
| dataContent   | Data content                                                 |
| timeout       | Command response timeout time, if user interaction is required, such as fingerprints, there is no need to set a timeout. |
| needHijacking | Need hijacking                                               |
| success       | Success block                                                |
| failure       | Failure block                                                |

**Example**

Objc:

```objective-c
    [self.lock addUnlockOpmodeForMemberWithMemberId:@"00000074zg"
                                            isAdmin:NO
                                       unlockDpCode:@"unlock_password"
                                       unlockOpType:TYUnlockOpTypePassword
                                         unlockName:@"password774641"
                                      effectiveDate:nil
                                        invalidDate:nil
                                              times:10
                                         dataLength:6
                                        dataContent:@"774641"
                                            timeout:6
                                      needHijacking:YES
                                            success:^(NSString *result) {
        NSLog(@"add success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
```

Swift:

```swift
    self.lock?.addUnlockOpmodeForMember(withMemberId: "00000074zg", isAdmin: false, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, unlockName: "password774641", effectiveDate: nil, invalidDate: nil, times: 10, dataLength: 6, dataContent: "774641", timeout: 5, needHijacking: true, success: { (result) in
         print("add success")
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }            
    })
```



#### Update Universal Unlock

SDK provides the function of general modification and update unlocking method, ** Requires the device to maintain bluetooth connection when adding **

```sequence
Title: Update Universal Unlock

participant server
participant app
participant lock

note over app: start update new unlock info
app->lock: create bluetooth connection
app->lock: send update unlock command data
lock-->app: response update result
app->server: send update unlock request
server-->app: return result
note over app: show result
```

**Declaration**

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

**Parameters**

| Parameter     | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| memberId      | Member id                                                    |
| opmodeId      | Unlock model id                                              |
| isAdmin       | Member is admin                                              |
| firmwareId    | Firmware id                                                  |
| unlockDpCode  | The dp code corresponding to the unlocking method, you can view the product definition in detail, such as card unlocking, code = unlock_card |
| unlockOpType  | TYUnlockOpType enum                                          |
| unlockName    | Unlock name                                                  |
| effectiveDate | Effective date                                               |
| invalidDate   | Invalid date                                                 |
| times         | Unlock times                                                 |
| dataLength    | Data length, equal data content length                       |
| dataContent   | Data content                                                 |
| timeout       | Command response timeout time, if user interaction is required, such as fingerprints, there is no need to set a timeout. |
| needHijacking | Need hijacking                                               |
| success       | Success block                                                |
| failure       | Failure block                                                |

**Example**

Objc:

```objective-c
    [self.lock modifyUnlockOpmodeForMemberWithMemberId:@"00000074zg"
                                              opmodeId:@"232323"
                                               isAdmin:NO
                                            firmwareId:15 // opmodevalue
                                          unlockDpCode:@"unlock_password"
                                          unlockOpType:TYUnlockOpTypePassword
                                            unlockName:@"password774641"
                                         effectiveDate:nil
                                           invalidDate:nil
                                                 times:10
                                            dataLength:6
                                           dataContent:@"774641"
                                               timeout:6
                                         needHijacking:YES
                                               success:^(NSString *result) {
        NSLog(@"update ");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
```

Swift:

```swift
    self.lock?.modifyUnlockOpmodeForMember(withMemberId: "00000074zg", opmodeId: "232323", isAdmin: false, firmwareId: 15, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, unlockName: "password774641", effectiveDate: nil, invalidDate: nil, times: 10, dataLength: 6, dataContent: "774641", timeout: 5, needHijacking: true, success: { (result) in
        print("update success")
    }, failure: { (error) in
        if let e = error {
            print("error:, error: \(e)")
        }
    })
```



#### Delete Universal Unlock

**Declaration**

```objective-c
- (void)removeUnlockOpmodeForMemberWithOpmodeModel:(TuyaSmartBLELockOpmodeModel *)opmodeModel
                                           isAdmin:(BOOL)isAdmin
                                      unlockDpCode:(NSString *)unlockDpCode
                                      unlockOpType:(TYUnlockOpType)unlockOpType
                                           timeout:(NSTimeInterval)timeout
                                           success:(TYSuccessHandler)success
                                           failure:(TYFailureError)failure;
```

**Parameters**

| Parameter    | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| opmodeModel  | Unlock model                                                 |
| isAdmin      | Member is admin                                              |
| unlockDpCode | The dp code corresponding to the unlocking method, you can view the product definition in detail, such as card unlocking, code = unlock_card |
| unlockOpType | `TYUnlockOpType` enum                                        |
| timeout      | Command response timeout time, if user interaction is required, such as fingerprint, do not set timeout |
| success      | Success block                                                |
| failure      | Failure block                                                |

**Example**

Objc:

```objective-c
    [self.lock removeUnlockOpmodeForMemberWithOpmodeModel:model
                                                  isAdmin:NO
                                             unlockDpCode:@"unlock_password"
                                             unlockOpType:TYUnlockOpTypePassword
                                                  timeout:10
                                                  success:^{
        NSLog(@"delete success");
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }]
```

Swift:

```swift
    self.lock?.removeUnlockOpmodeForMember(with: model, isAdmin: false, unlockDpCode: "unlock_password", unlockOpType: TYUnlockOpTypePassword, timeout: 10, success: {
        print("delete success")    
    }, failure: { (error) in
        if let e = error {
            print("error: \(e)")
        }            
    })
```


## BLE Lock Dp Code Table

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
| 锁帖电机转动方向     | lock_motor_direction        |
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