## Group management

The Tuya Cloud supports the group management system. User can create group, change group name, manage devices of group, manage multiple devices via the group and dismiss group.

All functions of group are realized by using the `TuyaSmartGroup` class, and all functions need to be initiated by using the group Id. Wrong group Id may cause initiation failure, and the `nil` will be returned.


### Create a group

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

### Obtain device list of group

Obtain the device list of product when the group is not created.

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

Obtain the device list of a group when the group is created.

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

### Send dp command of a group

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

### Modify the group name

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

### Modify group device list

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
### Dismiss group

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


### Callback interface

Callback and data updating after the group sends DP.

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