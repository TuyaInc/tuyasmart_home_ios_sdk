## Home management

After login, user shall use the `TuyaSmartHomeManager to obtain` information of home list and initiate one home `TuyaSmartHome` and attain details of a home and manage and control devices in the home. 


### Callback of information in the home list

After the `TuyaSmartHomeManagerDelegate` delegate protocol is realized, user can proceed operations in the home list change. 

```objc
#pragma mark - TuyaSmartHomeManagerDelegate


// Add a home
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {
    
}

// Delete a home
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {
    
}

// The MQTT connection succeeds.
- (void)serviceConnectedSuccess {
    // Update the current home UI
}
```

### Obtain the home list.

```objc
- (void)getHomeList {
    
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        // home list
    } failure:^(NSError *error) {
        NSLog(@"get home list failure: %@", error);
    }];
}
```

### Add home

```objc
- (void)addHome {
    
    [self.homeManager addHomeWithName:@"you_home_name"
                          geoName:@"city_name"
                            rooms:@[@"room_name"]
                         latitude:lat
                        longitude:lon
                          success:^(double homeId) {
                
        // homeId : create homeId of home 
        NSLog(@"add home success");
    } failure:^(NSError *error) {
        NSLog(@"add home failure: %@", error);
    }];
}
```