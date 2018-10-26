## 家庭管理

用户登录成功后需要通过`TuyaSmartHomeManager`去获取整个家庭列表的信息,然后初始化其中的一个家庭`TuyaSmartHome`，获取家庭详情信息，对家庭中的设备进行管理，控制。


### 家庭列表信息变化的回调

实现`TuyaSmartHomeManagerDelegate`代理协议后，可以在家庭列表更变的回调中进行处理。

```objc
#pragma mark - TuyaSmartHomeManagerDelegate


// 添加一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {
    
}

// 删除一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {
    
}

// MQTT连接成功
- (void)serviceConnectedSuccess {
    // 刷新当前家庭UI
}
```

### 获取家庭列表

获取家庭列表，返回数据只是家庭的简单信息。如果要获取具体家庭的详情，需要去初始化一个home，调用接口 getHomeDetailWithSuccess:failure:

```objc
- (void)getHomeList {
	
	[self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        // homes 家庭列表
    } failure:^(NSError *error) {
        NSLog(@"get home list failure: %@", error);
    }];
}
```

### 添加家庭

```objc
- (void)addHome {
	
    [self.homeManager addHomeWithName:@"you_home_name"
                          geoName:@"city_name"
                            rooms:@[@"room_name"]
                         latitude:lat
                        longitude:lon
                          success:^(double homeId) {
                
        // homeId 创建的家庭的homeId
        NSLog(@"add home success");
    } failure:^(NSError *error) {
        NSLog(@"add home failure: %@", error);
    }];
}
```