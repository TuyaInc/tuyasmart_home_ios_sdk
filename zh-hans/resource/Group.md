涂鸦云支持群组管理体系：可以创建群组，修改群组名称，管理群组设备，通过群组管理多个设备，解散群组。

群组相关的所有功能对应`TuyaSmartGroup`类，需要使用群组Id进行初始化。错误的群组Id可能会导致初始化失败，返回`nil`。

### wifi 设备群组

#### 创建群组

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



#### 获取群组的设备列表

群组没有创建，获取产品的设备列表

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



群组已经创建，获取群组的设备列表

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



#### 群组dp命令下发

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



#### 修改群组名称

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



#### 修改群组设备列表

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



#### 解散群组

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

### zigbee 设备群组

zigbee 设备群组需要所有的设备都属于同一个网关，不能跨网关

#### 创建zigbee 群组

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



#### 获取群组的设备列表

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


#### 添加设备到zigbee群组

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




#### 从zigbee 群组中移除设备

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

#### 回调接口

zigbee 设备加入或者移除网关群组的响应

errorCode ：

- 1:超过场景数上限 
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