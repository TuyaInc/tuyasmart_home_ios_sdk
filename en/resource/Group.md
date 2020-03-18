## Group management

The Tuya Cloud supports the group management system. User can create group, change group name, manage devices of group, manage multiple devices via the group and dismiss group.

All functions of group are realized by using the `TuyaSmartGroup` class, and all functions need to be initiated by using the group Id. Wrong group Id may cause initiation failure, and the `nil` will be returned.



| Class               | Description            |
| ------------------- | ---------------------- |
| TuyaGroupDevice     | Tuya Group Class       |
| TuyaSmartGroupModel | Tuya Group Model Class |

**`TuyaSmartGroupModel`Data Model**

| Field            | Type               | Description                         |
| ---------------- | ------------------ | ----------------------------------- |
| groupId          | NSString           | group id                            |
| productId        | NSString           | group product id                    |
| time             | long long          | group create time                   |
| name             | NSString           | group name                          |
| iconUrl          | NSString           | group icon url                      |
| type             | TuyaSmartGroupType | group type                          |
| isShare          | BOOL               | is share group                      |
| dps              | NSDictionary       | group data point                    |
| dpCodes          | NSDictionary       | group dp code                       |
| localKey         | NSString           | A Key Used For Device Communication |
| deviceNum        | NSInteger          | group device number                 |
| productInfo      | NSDictionary       | group product info                  |
| pv               | NSString           | protocol version                    |
| homeId           | long long          | group home id                       |
| roomId           | long long          | group room id                       |
| displayOrder     | NSInteger          | group room display order            |
| homeDisplayOrder | NSInteger          | group home display order            |
| deviceList       | NSArray            | group device list                   |
| localId          | NSString           | group local id                      |
| meshId           | NSString           | group mesh id                       |
| schemaArray      | NSArray            | data point detail                   |
| standard         | BOOL               | is a standardized device            |

## wifi group

### Create group

**Declaration**

Create group with some device.

```objective-c
+ (void)createGroupWithName:(NSString *)name
                  productId:(NSString *)productId
                     homeId:(long long)homeId
                  devIdList:(NSArray<NSString *> *)devIdList
                    success:(nullable void (^)(TuyaSmartGroup *group))success
                    failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| name      | name             |
| productId | product id       |
| homeId    | group's home id  |
| devIdList | device list      |
| success   | success callback |
| failure   | failure callback |

****

Objc:

```objc
- (void)createNewGroup {
    
    [TuyaSmartGroup createGroupWithName:@"your_group_name" productId:@"your_group_product_id" homeId:homeId devIdList:(NSArray<NSString *> *)selectedDevIdList success:^(TuyaSmartGroup *group) {
        NSLog(@"create new group success %@:", group); 
    } failure:^(NSError *error) {
        NSLog(@"create new group failure");
    }];
}
```

Swift:

```swift
func createNewGroup() {
    TuyaSmartGroup.createGroup(withName: "your_group_name", productId: "your_group_product_id", homeId: homeId, devIdList: ["selectedDevIdList"], success: { (group) in
        print("create new group success: \(group)")
    }) { (error) in
        print("create new group failure")
    }
}
```



### Obtain device list of product id

**Declaration**

Obtain the device list of product when the group is not created.

```objective-c
+ (void)getDevList:(NSString *)productId
            homeId:(long long)homeId
           success:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description               |
| --------- | ------------------------- |
| productId | 创建群组入口设备的产品 id |
| homeId    | home id                   |
| success   | success call back         |
| failure   | failure call back         |

**Example**

Objc:

```objc
- (void)getGroupDevList {
    
    [TuyaSmartGroup getDevList:@"your_group_product_id" homeId:homeId success:^(NSArray<TuyaSmartGroupDevListModel *> *list) {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Swift:

```swift
func getGroupDevList() {
    TuyaSmartGroup.getDevList("your_group_product_id", homeId: 1, success: { (list) in
        print("get group dev list success \(list)")
    }) { (error) in
        print("get group dev list failure")
    }
}
```

### Obtain the device list of a group

**Declaration**

Obtain the device list of a group when the group is created.

```objective-c
- (void)getDevList:(NSString *)productId
            homeId:(long long)homeId
           success:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| productId | product id       |
| homeId    | home id          |
| success   | success callback |
| failure   | 失败回调         |

**Example**

Objc:

```objc
- (void)getGroupDevList {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];
    [self.smartGroup getDevList:@"your_group_product_id" success:^(NSArray<TuyaSmartGroupDevListModel *> *list) {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Swift:

```swift
func getGroupDevList() {
    smartGroup?.getDevList("your_group_product_id", success: { (list) in
        print("get group dev list success \(list)")
    }, failure: { (error) in
        print("get group dev list failure")
    })
}
```

### Modify group device list

**Declaration**

```objective-c
- (void)updateGroupRelations:(NSArray <NSString *>*)devList
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description        |
| --------- | ------------------ |
| devList   | 设备列表的 id 数组 |
| success   | success callback   |
| failure   | failure callback   |

**Example**

Objc:

```objc
- (void)updateGroupRelations {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];

    [self.smartGroup updateGroupRelations:(NSArray<NSString *> *)selectedDevIdList success:^ {
        NSLog(@"update group relations success");
    } failure:^(NSError *error) {
        NSLog(@"update group relations failure: %@", error);
    }];
}
```

Swift:

```swift
func updateGroupRelations() {
    smartGroup?.updateRelations(["selectedDevIdList"], success: {
        print("update group relations success")
    }, failure: { (error) in
        if let e = error {
            print("update group relations failure: \(e)")
        }
    })
}
```


#### Callback interface

Callback and data updating after the group sends DP.

Objc:

```objc
#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps {
  // TODO: update group panel UI here
}

```

Swift:

```swift
// MARK: TuyaSmartGroupDelegate
func group(_ group: TuyaSmartGroup!, dpsUpdate dps: [AnyHashable : Any]!) {
  // TODO: update group panel UI here
}
```



## Zigbee Group

#### Create Zigbee group

**Declaration**

create group with some zigbee devices

```objective-c
+ (void)createGroupWithName:(NSString *)name
                     homeId:(long long)homeId
                       gwId:(NSString *)gwId
                  productId:(NSString *)productId
                    success:(nullable void (^)(TuyaSmartGroup *))success
                    failure:(nullable TYFailureError)failure;
```

**Parameters**

****

| Parameter | Description      |
| --------- | ---------------- |
| name      | group name       |
| homeId    | group home id    |
| gwId      | group gateway id |
| productId | group product id |
| success   | success callback |
| failure   | failure callback |

**Example**

Objc:

```objc
- (void)createNewGroup {
    
    [TuyaSmartGroup createGroupWithName:@"your_group_name" homeId:homeID gwId:@"gwId" productId:@"your_group_product_id" success:^(TuyaSmartGroup *group) {
        NSLog(@"create new group success %@:", group); 
    } failure:^(NSError *error) {
        NSLog(@"create new group failure");
    }];
}
```

Swift:

```swift
func createNewGroup() {
    TuyaSmartGroup.createGroup(withName: "your_group_name", homeId: homeId, gwId: "gwId" productId: "your_group_product_id", success: { (group) in
        print("create new group success: \(group)")
    }) { (error) in
        print("create new group failure")
    }
}
```



#### Get a list of devices supported by the ZigBee group

**Declaration**

```objective-c
+ (void)getDevListWithProductId:(NSString *)productId
                           gwId:(NSString *)gwId
                         homeId:(long long)homeId
                        success:(nullable void (^)(NSArray<TuyaSmartGroupDevListModel *> *))success
                        failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description       |
| --------- | ----------------- |
| productId | group product id  |
| gwId      | 群组的网关 id     |
| homeId    | 群组所在的家庭 id |
| success   | success callback  |
| failure   | failure callback  |

**Example**

Objc:

```objc
- (void)getGroupDevList {
    
    [TuyaSmartGroup getDevListWithProductId:@"your_group_product_id" gwId:@"gwId" homeId:homeId success:^(NSArray<TuyaSmartGroupDevListModel *> *list) {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Swift:

```swift
func getGroupDevList() {
    TuyaSmartGroup.getDevList(withProductId: "your_group_product_id", gwId: "gwId", homeId: hoemId, success: { (list) in
        print("get group dev list success \(list)")
    }) { (error) in
        print("get group dev list failure")
    }
}
```

#### Add devices to the ZigBee group

**Declaration**

```objective-c
- (void)addZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                            success:(nullable TYSuccessHandler)success
                            failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description             |
| --------- | ----------------------- |
| nodeList  | 需要添加的设备的 nodeId |
| success   | success callback        |
| failure   | failure callback        |

**Example**

Objc:

```objc
- (void)addDevice {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];
    [self.smartGroup addZigbeeDeviceWithNodeList:@[@"nodeId1", @"nodeId2"]  success:^() {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Swift:

```swift
func addDevice() {
    martGroup.addZigbeeDevice(withNodeList: ["nodeId1", "nodeId2"], success: {
        print("add device success")
    }) { (error) in
        print("add device failure")
    }
}
```



#### Remove devices from ZigBee groups

**Declaration**

```objective-c
- (void)removeZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                               success:(nullable TYSuccessHandler)success
                               failure:(nullable TYFailureError)failure;
```

**Parameter**

| Parameter | Description           |
| --------- | --------------------- |
| nodeList  | 需要移除设备的 nodeId |
| success   | success call back     |
| failure   | failure call back     |

**Example**

Objc:

```objc
- (void)removeDevice {
    
    [self.smartGroup removeZigbeeDeviceWithNodeList:@[@"nodeId1", @"nodeId2"]  success:^() {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Swift:

```swift
func removeDevice() {
    martGroup.addZigbeeDevice(withNodeList: ["nodeId1", "nodeId2"], success: {
        print("remove device success")
    }) { (error) in
        print("remove device failure")
    }
}
```

#### Callback interface

Response of ZigBee devices to join or remove gateway groups

**errorCode** ：

- 1:Over the Scene Number Upper Limit
- 2: Subdevice timeout
- 3: Setting values beyond range
- 4: Writing errors
- 5: Other mistakes

Objc:

```objc
#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group addResponseCode:(NSArray <NSNumber *>*)responseCode {
	// Responses of ZigBee devices joining groups
}

- (void)group:(TuyaSmartGroup *)group removeResponseCode:(NSArray <NSNumber *>*)responseCode {
	// sub devices joined the gateway group successfully
}

```

Swift:

```swift
// MARK: TuyaSmartGroupDelegate
func group(_ group: TuyaSmartGroup?, addResponseCode responseCode: [NSNumber]?) {
	// Responses of ZigBee devices joining groups
}

func group(_ group: TuyaSmartGroup?, removeResponseCode responseCode: [NSNumber]?) {
	// sub devices joined the gateway group successfully
}

```


## Send dp command of a group

**Declaration**

```objective-c
- (void)publishDps:(NSDictionary *)dps 
           success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| dps       | dp command       |
| success   | success callbck  |
| failure   | failure callback |

**Example**

Objc:

```objc
- (void)publishDps {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];
	
	NSDictionary *dps = @{@"1": @(YES)};
	[self.smartGroup publishDps:dps success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
}
```

Swift:

```swift
func publishDps() {
    let dps = ["1" : true]
    smartGroup?.publishDps(dps, success: {
        print("publishDps success")
    }, failure: { (error) in
        print("publishDps failure")
    })
}
```



## Modify the group name

**Declaration**

```objective-c
- (void)updateGroupName:(NSString *)name 
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**Parameters**

| Parameter | Description      |
| --------- | ---------------- |
| name      | group name       |
| success   | success callback |
| failure   | failure callback |

**Example**

Objc:

```objc
- (void)updateGroupName {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];

    [self.smartGroup updateGroupName:@"your_group_name" success:^{
        NSLog(@"update group name success");
    } failure:^(NSError *error) {
        NSLog(@"update group name failure: %@", error);
    }];
}
```

Swift:

```swift
func updateGroupName() {
    smartGroup?.updateName("your_group_name", success: {
        print("updateGroupName success")
    }, failure: { (error) in
        if let e = error {
            print("updateGroupName failure: \(e)")
        }
    })
}
```

## Dismiss grouP

**Example**

Objc:

```objc
- (void)dismissGroup {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];

    [self.smartGroup dismissGroup:^{
      NSLog(@"dismiss group success");
    } failure:^(NSError *error) {
      NSLog(@"dismiss group failure: %@", error);
    }];
}
```

Swift:

```swift
func dismissGroup() {
    smartGroup?.dismiss({
        print("dismiss group success")
    }, failure: { (error) in
        if let e = error {
            print("dismiss group failure: \(e)")
        }
    })
}
```

