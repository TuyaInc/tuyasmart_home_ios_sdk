# 群组管理

`TuyaSmartGroup` 类需要使用群组 id 进行初始化。错误的群组 id 可能会导致初始化失败，此时的实例返回 `nil`


| 类名                 | 说明               |
| -------------------- | ------------------ |
| TuyaGroupDevice      | 涂鸦群组类         |
| TuyaSmartGroupModel | 涂鸦群组数据模型类 |

**`TuyaSmartGroupModel` 数据模型**

| 字段             | 类型                      | 描述                                                         |
| ---------------- | ------------------------- | ------------------------------------------------------------ |
| groupId            | NSString                  | 群组唯一 id                                                  |
|productId             | NSString                  | 群组对应的产品 id                                                     |
| time          | long long                  | 群组的创建时间                                          |
| name         | NSString                      | 群组名称 |
| iconUrl    | NSString                      | 群组展示图标的 url                                         |
| type    | TuyaSmartGroupType                      | 群组类型                                           |
| isShare          | BOOL                      | 是否为分享群组                                           |
| dps              | NSDictionary              | 群组功能点数据                                               |
| dpCodes          | NSDictionary              | 群组功能点数据，code-value 形式                              |
| localKey      | NSString                   |  群组通信使用的 key                                          |
| deviceNum        | NSInteger                  | 群组下的设备数量                                        |
| productInfo       | NSDictionary                | 群组对应的产品相关信息                                               |
| pv   | NSString | 群组协议版本，Wi-Fi 协议版本 |
| homeId           | long long                 | 群组所在家庭 id                                          |
| roomId           | long long                 | 群组所在房间 id                                            |
| displayOrder       | NSInteger                  |  群组在房间维度的排序字段                                                     |
| homeDisplayOrder           | NSInteger                  | 群组在家庭维度的排序字段 |
| deviceList         | NSArray                  | 群组对应的设备列表 |
| localId  | NSString                      |  群组在局域网通讯中的 id                                  |
| meshId         | NSString                      | 群组的 meshId |
| schemaArray | NSArray | 群组 dp 点规则信息                                       |
| standard       | BOOL            | 是否是标准群组                                                |


## Wi-Fi 群组

### 创建群组

**接口说明**

将一系列设备创建成为一个群组。

```objective-c
+ (void)createGroupWithName:(NSString *)name
                  productId:(NSString *)productId
                     homeId:(long long)homeId
                  devIdList:(NSArray<NSString *> *)devIdList
                    success:(nullable void (^)(TuyaSmartGroup *group))success
                    failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| name | 名字 |
|  productId  | 创建群组入口设备的产品 id |
| homeId | 群组所在的家庭 id|
| devIdList | 创建为群组的所有设备 id|
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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



### 获取可创建成为群组的设备列表

**接口说明**

根据入口设备的产品 id 查询家庭下有哪些设备可以与这个设备创建成群组。

```objective-c
+ (void)getDevList:(NSString *)productId
            homeId:(long long)homeId
           success:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
|  productId  | 创建群组入口设备的产品 id |
| homeId | 群组所在的家庭 id|
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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

### 获取可加入当前群组的设备列表


**接口说明**

根据群组的产品 id 查询家庭下可加入和已加入该群组的设备列表。

```objective-c
- (void)getDevList:(NSString *)productId
            homeId:(long long)homeId
           success:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
|  productId  | 群组的产品 id |
| homeId | 群组所在的家庭 id|
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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

### 修改群组设备列表

**接口说明**

修改当前群组下面的设备列表。

```objective-c
- (void)updateGroupRelations:(NSArray <NSString *>*)devList
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
|  devList  | 设备列表的 id 数组 |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**Objc:

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


#### 回调接口

群组DP下发之后的数据回调更新

Objc:

```objc

#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps {
	//可以在这里刷新群组操作面板的UI
}

```

Swift:

```swift
// MARK: TuyaSmartGroupDelegate
func group(_ group: TuyaSmartGroup!, dpsUpdate dps: [AnyHashable : Any]!) {
    //可以在这里刷新群组操作面板的UI
}
```



## Zigbee 群组

#### 创建 Zigbee 群组

**接口说明**

将一系列 zigbee 设备创建成为群组

```objective-c
+ (void)createGroupWithName:(NSString *)name
                     homeId:(long long)homeId
                       gwId:(NSString *)gwId
                  productId:(NSString *)productId
                    success:(nullable void (^)(TuyaSmartGroup *))success
                    failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
|  name  | 群组名称 |
| homeId | 要创建群组的家庭 id |
| gwId | 要创建群组的网关 id |
| productId | 创建群组入口设备的产品 id |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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



### 获取 Zigbee 群组的设备列表

**接口说明**

将一系列 zigbee 设备创建成为群组

```objective-c
+ (void)getDevListWithProductId:(NSString *)productId
                           gwId:(NSString *)gwId
                         homeId:(long long)homeId
                        success:(nullable void (^)(NSArray<TuyaSmartGroupDevListModel *> *))success
                        failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| productId |群组的产品 id |
| gwId | 群组的网关 id |
| homeId | 群组所在的家庭 id |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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


### 添加设备到 Zigbee 群组

**接口说明**

```objective-c
- (void)addZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                            success:(nullable TYSuccessHandler)success
                            failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| nodeList | 需要添加的设备的 nodeId |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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




### 从 Zigbee 群组中移除设备

**接口说明**

```objective-c
- (void)removeZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                               success:(nullable TYSuccessHandler)success
                               failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| nodeList | 需要移除设备的 nodeId |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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

### 回调接口

zigbee 设备加入或者移除网关群组的响应

errorCode ：

- 1:超过群组数量上限 
- 2:子设备超时 
- 3:设置值超出范围 
- 4:写文件错误 
- 5:其他错误

Objc:

```objc

#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group addResponseCode:(NSArray <NSNumber *>*)responseCode {
	// zigbee 设备加入到网关的群组响应
}

- (void)group:(TuyaSmartGroup *)group removeResponseCode:(NSArray <NSNumber *>*)responseCode {
	// zigbee 设备从网关群组移除响应
}

```

Swift:

```swift
// MARK: TuyaSmartGroupDelegate
func group(_ group: TuyaSmartGroup?, addResponseCode responseCode: [NSNumber]?) {
    // zigbee 设备加入到网关的群组响应
}

func group(_ group: TuyaSmartGroup?, removeResponseCode responseCode: [NSNumber]?) {
    // zigbee 设备从网关群组移除响应
}
```


## 群组控制

**接口说明**

通过下发 dp 点来控制群组的行为。

```objective-c
- (void)publishDps:(NSDictionary *)dps 
           success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| dps |  要下发的数据点 |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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



## 修改群组名称

**接口说明**

```objective-c
- (void)updateGroupName:(NSString *)name 
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| name |  群组名称 |
| success  | 成功回调   |
| failure  | 失败回调   |

**示例代码**

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

## 解散群组

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




