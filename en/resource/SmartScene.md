# Smart Scene

Smart divides into scene or automation actions. 

Scene is a condition that users add actions and it is triggered manually; Automation action is a action set by users, and the set action is automatically executed when the condition is triggered.

The Tuya Cloud allows users to set meteorological or device conditions based on actual scenes in life, and if conditions are met, one or multiple devices will carry out corresponding tasks.

| Class | Description |
| -------------- | ---------- |
| TuyaSmartScene   |   Provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list|
| TuyaSmartSceneManager | Provides all data related to conditions, tasks, devices and city for scenes, as well as the method of obtaining scene list data.|
|TuyaSmartScenePreConditionFactory| A tool class that provides a quick way to create automation effective period condition.|
|TuyaSmartSceneConditionFactory | A tool class that provides a quick way to create scene conditions. |
|TuyaSmartSceneActionFactory | A tool class that provides a quick way to create scene actions. |
|TuyaSmartSceneConditionExprBuilder| A tool class that provides a quick way to create scene condition's expressions. |

Before using interfaces related to the smart scene, you have to understand the scene conditions and scene tasks first.

**In the following documents, manual scene and automated scene are simply referred to as scene.**

## Scene Condition

All scenes conditions are defined in the `TuyaSmartSceneConditionModel` class, and Tuya supports three types of conditions:

- Meteorological conditions including temperature, humidity, weather, PM2.5, air quality and sunrise and sunset. User can select city when he/she selects the meteorological conditions.
- Device conditions: if you have preset a function status for a device, the task in the scene will be triggered when the device status is reached. To avoid conflicts in operation, the same device cannot be used for both conditions and task at the same time.
- Timing conditions: the device will carry out preset task at the required time.

## Scene Action

In this case, one or multiple devices will run some operations or enable/disable an automation action (with scene conditions) when the preset meteorological or device conditions are met. All relevant functions are realized in the `TuyaSmartSceneActionModel` class.

**There are some examples at the end of this document, whice can help you about creating an object of `TuyaSmartSceneActionModel` or `TuyaSmartSceneConditionModel`.**



## Smart Scene Management

### Obtain Scene List

**Declaration**

Get scene list. Scenes are returned with automations, and scene and automation are distinguished by whether the conditions field is an empty array.

```objective-c
- (void)getSceneListWithHomeId:(long long)homeId
                       success:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| homeId |Home Id|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getSmartSceneList {
    [[TuyaSmartSceneManager sharedInstance] getSceneListWithHomeId:homeId success:^(NSArray<TuyaSmartSceneModel *> *list) {
        NSLog(@"get scene list success %@:", list);
    } failure:^(NSError *error) {
        NSLog(@"get scene list failure: %@", error);
    }];
}
```

Swift:

```swift
func getSmartSceneList() {
    TuyaSmartSceneManager.sharedInstance()?.getSceneList(withHomeId: homeId, success: { (list) in
        print("get scene list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get scene list failure: \(e)")
        }
    })
}
```

### Obtain Condition List

**Declaration**

Obtain condition list. The condition can be temperature, humidity, weather, PM2.5, sunrise and sunset. It shall be noted that the device can also be a condition. The temperature can be in the Celsius system and Fahrenheit, and data shall be uploaded based on needs.

```objective-c
- (void)getConditionListWithFahrenheit:(BOOL)fahrenheit
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| fahrenheit |YES: Use Fahrenheit units, NO: Use Celsius units|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getConditionList {
    [[TuyaSmartSceneManager sharedInstance] getConditionListWithFahrenheit:YES success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
        NSLog(@"get condition list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get condition list failure: %@", error);
    }];
}
```

Swift:

```swift
func getConditionList() {
    TuyaSmartSceneManager.sharedInstance()?.getConditionList(withFahrenheit: true, success: { (list) in
        print("get condition list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get condition list failure: \(e)")
        }
    })
}
```
### Obtain Action Device List

**Declaration**

When adding tasks, the device list of task shall be obtained.

```objective-c
- (void)getActionDeviceListWithHomeId:(long long)homeId
                              success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                              failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| homeId |Home Id|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getActionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get action device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device list failure: %@", error);
	}];
}
```

Swift:

```swift
func getActionDeviceList() {
    TuyaSmartSceneManager.sharedInstance()?.getActionDeviceList(withHomeId: homeId, success: { (list) in
        print("get action device list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get action device list failure: \(e)")
        }
    })
}
```
### Obtain Condition Device List

**Declaration**

Except for meteorological conditions such as temperature, humidity and weather, etc., the device can also be a condition. The condition device list shall be obtained, and one device that is carrying out some tasks will be used as a condition.

```objective-c
- (void)getConditionDeviceListWithHomeId:(long long)homeId
                                 success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                                 failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| homeId |Home Id|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getConditionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getConditionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get condition device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device list failure: %@", error);
	}];
}
```

Swift:

```swift
func getConditionDeviceList() {
    TuyaSmartSceneManager.sharedInstance()?.getConditionDeviceList(withHomeId: homeId, success: { (list) in
        print("get condition device list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get condition device list failure: \(e)")
        }
    })
}
```

### Obtain Dp List Of Action Device

**Declaration**

When adding or editing scene actions, the user needs to obtain the device dp list based on the deviceId of devices to select a dp function point so as to assign the action to the device.

```objective-c
- (void)getActionDeviceDPListWithDevId:(NSString *)devId
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| devId |Device Id|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getActionDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get action device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device dp list failure: %@", error);
	}];
}
```

Swift:

```swift
func getActionDeviceDPList() {
    TuyaSmartSceneManager.sharedInstance()?.getActionDeviceDPList(withDevId: "your_device_id", success: { (list) in
        print("get action device dp list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get action device dp list failure: \(e)")
        }
    })
}
```

### Obtain Dp List Of Condition Device

**Declaration**

When selecting scene conditions, the user needs to obtain the device dp list based on the deviceId to select a dp function point so that the operation of the dp function of a device can be used as the condition of the scene.

```objective-c
- (void)getCondicationDeviceDPListWithDevId:(NSString *)devId
                                    success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                    failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| devId |Device Id|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getCondicationDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getCondicationDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get condition device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device dp list failure: %@", error);
	}];
}
```

Swift:

```swift
func getCondicationDeviceDPList() {
    TuyaSmartSceneManager.sharedInstance()?.getCondicationDeviceDPList(withDevId: "your_device_id", success: { (list) in
        print("get condition device dp list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get condition device dp list failure: \(e)")
        }
    })
}
```

### Obtain City List

**Declaration**

When selecting meteorological conditions for scene, user can obtain the city list according to the country code. The user can select the city he is currently in. (Note: city list of some foreign countries may be incomplete temporarily. If you are not in China, it is recommended that you obtain the city information according to the altitude and longitude.)Use isoCountryCode，eg:United States = "US"。

```objective-c
- (void)getCityListWithCountryCode:(NSString *)countryCode
                           success:(void(^)(NSArray<TuyaSmartCityModel *> *list))success
                           failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| countryCode | Country code, use isoCountryCode, eg:United States = "US" |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getCityList {
	[[TuyaSmartSceneManager sharedInstance] getCityListWithCountryCode:@"your_country_code" success:^(NSArray<TuyaSmartCityModel *> *list) {
		NSLog(@"get city list success:%@", list);
	} failure:^(NSError *error) {
   		NSLog(@"get city list failure: %@", error);
	}];
}
```

Swift:

```swift
func getCityList() {
    TuyaSmartSceneManager.sharedInstance()?.getCityList(withCountryCode: "your_country_code", success: { (list) in
        print("get city list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get city list failure: \(e)")
        }
    })
}
```

### Obtain The City Information According To The Altitude And Longitude Of City

**Declaration**

```objective-c
- (void)getCityInfoWithLatitude:(NSString *)latitude
                      longitude:(NSString *)longitude
                        success:(void(^)(TuyaSmartCityModel *model))success
                        failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| latitude | Latitude |
| longitude | Longitude |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfo:@"your_location_latitude" longitude:@"your_location_longitude" success:^(TuyaSmartCityModel *city) {
		NSLog(@"get city info success:%@", city);
	} failure:^(NSError *error) {
		NSLog(@"get city info failure:%@", error);
	}];
}
```

Swift:

```swift
func getCityInfo() {
    TuyaSmartSceneManager.sharedInstance()?.getCityInfo(withLatitude: "your_location_latitude", longitude: "your_location_longitude", success: { (city) in
        print("get city info success: \(city)")
    }, failure: { (error) in
        if let e = error {
            print("get city info failure: \(e)")
        }
    })
}
```
### Obtain The City Information According To The City Id.

**Declaration**

Obtain the city information according to the city id. The city id can be attained from the city list.

```objective-c
- (void)getCityInfoWithCityId:(NSString *)cityId
                      success:(void(^)(TuyaSmartCityModel *model))success
                      failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| cityId |City Id|
| success   | Success block |
| failure   | Failure block |

**Example**

```objc
- (void) getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfoWithCityId:@"your_city_id" success:^(TuyaSmartCityModel *city) {
		NSLog(@"get city info success:%@", city);
	} failure:^(NSError *error) {
		NSLog(@"get city info failure:%@", error);
	}];
}
```

Swift:

```swift
func getCityInfo() {
    TuyaSmartSceneManager.sharedInstance()?.getCityInfo(withCityId: "your_city_id", success: { (city) in
        print("get city info success: \(city)")
    }, failure: { (error) in
        if let e = error {
            print("get city info failure: \(e)")
        }
    })
}
```

### Sort Scene

**Declaration**

```objective-c
- (void)sortSceneWithHomeId:(long long)homeId
                sceneIdList:(NSArray<NSString *> *)sceneIdList
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| homeId |Home Id|
| sceneIdList |Sorted scene Id array|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void) sortScene {
	[[TuyaSmartSceneManager sharedInstance] sortSceneWithHomeId:homeId sceneIdList:(NSArray<NSString *> *) success:^{
        NSLog(@"sort scene success");
    } failure:^(NSError *error) {
        NSLog(@"sort scene failure:%@", error);
    }];
}
```

Swift:

```swift
func sortScene() {
    TuyaSmartSceneManager.sharedInstance()?.sortScene(withHomeId: homeId, sceneIdList: ["sceneId list"], success: {
        print("sort scene success")
    }, failure: { (error) in
        if let e = error {
            print("sort scene failure: \(e)")
        }
    })
}
```

### Obtain Scene's Supported Cover List

**Declaration**

Obtain scene's supported cover url list.

```objective-c
- (void)getSmartSceneBackgroundCoverWithsuccess:(TYSuccessList)success
                                        failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| success   | Success block |
| failure   | Failure block |

**Example**


Objc:

```objc
- (void)getDefaultSceneCover {
	[[TuyaSmartSceneManager sharedInstance] getSmartSceneBackgroundCoverWithsuccess:^(NSArray *list) {
        
    } failure:^(NSError *error) {
        
    }];
}
```

Swift:

```swift
func getDefaultSceneCover() {
    TuyaSmartSceneManager.sharedInstance()?.getSmartSceneBackgroundCover(withsuccess: {(list) in
        
    }, failure: { (error) in
       
    })
}
```

## Scene Operation

The `TuyaSmartScene` class provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list.

### Add Scene

**Declaration**

User needs to upload the name of scene, Id of home, url of background pictures, showing the picture in the home page or not, task list (one at least) and determine carrying out task(s) when one or multiple conditions are met when he/she add a scene. The user can just set the name, tasks, background picture, but he/she has to set conditions manually.

```objective-c
+ (void)addNewSceneWithName:(NSString *)name
                     homeId:(long long)homeId
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
           preConditionList:(NSArray<TuyaSmartScenePreConditionModel*> *)preConditionList
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(void (^)(TuyaSmartSceneModel *sceneModel))success
                    failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| name| Scene name |
| homeId | Home Id |
| background | Background image url, can only use the background image provided in the "Obtain scene's supported cover list" interface|
| showFirstPage | Whether to display on the homepage |
| preConditionList | Effective period, passed in as an array of preconditions |
| conditionList | Condition list |
| actionList | Action list |
| matchType |Condition match type, "AND" or "OR"|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)addSmartScene {

    [TuyaSmartScene addNewSceneWithName:@"your_scene_name" homeId:homeId background:@"background_url" showFirstPage:YES conditionList:(NSArray<TuyaSmartSceneConditionModel *> *) actionList:(NSArray<TuyaSmartSceneActionModel *> *) matchType:TuyaSmartConditionMatchAny success:^(TuyaSmartSceneModel *sceneModel) {
        NSLog(@"add scene success %@:", sceneModel);
    } failure:^(NSError *error) {
        NSLog(@"add scene failure: %@", error);
    }];
}

```
Swift:

```swift
func addSmartScene() {
    TuyaSmartScene.addNewScene(withName: "your_scene_name", homeId: homeId, background: "background_url", showFirstPage: true, conditionList: [TuyaSmartSceneConditionModel]!, actionList: [TuyaSmartSceneActionModel]!, matchType: TuyaSmartConditionMatchAny, success: { (sceneModel) in
        print("add scene success :\(sceneModel)")
    }) { (error) in
        if let e = error {
            print("add scene failure: \(e)")
        }
    }
}
```

### Edit Scene

**Declaration**

User needs to edit the name of scene, background pictures, condition list, task list, and determine carrying out task(s) when one or multiple conditions are met.

```objective-c
- (void)modifySceneWithName:(NSString *)name
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
           preConditionList:(NSArray<TuyaSmartScenePreConditionModel*> *)preConditionList
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| name| Scene name |
| background | Background image url, can only use the background image provided in the "Obtain scene's supported cover list" interface|
| showFirstPage | Whether to display on the homepage |
| preConditionList | Effective period, passed in as an array of preconditions |
| conditionList | Condition list |
| actionList | Action list |
| matchType |Condition match type, "AND" or "OR"|
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)modifySmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
    [self.smartScene modifySceneWithName:name background:@"background_url" showFirstPage:YES preConditionList:(NSArray<TuyaSmartScenePreConditionModel*> *) conditionList:(NSArray<TuyaSmartSceneConditionModel *> *) actionList:(NSArray<TuyaSmartSceneActionModel *> *) matchType:TuyaSmartConditionMatchAny success:^{
        NSLog(@"modify scene success");
    } failure:^(NSError *error) {
        NSLog(@"modify scene failure: %@", error);
    }];
}
```
Swift:

```swift
func modifySmartScene() {
    smartScene?.modifyScene(withName: "name", background: "background_url", showFirstPage: true, preConditionList: [TuyaSmartScenePreConditionModel]!,conditionList: [TuyaSmartSceneConditionModel]!, actionList: [TuyaSmartSceneActionModel]!, matchType: TuyaSmartConditionMatchAny, success: {
        print("modify scene success")
    }, failure: { (error) in
        if let e = error {
            print("modify scene failure: \(e)")
        }
    })
}
```
### Delete Scene

**Declaration**

```objective-c
- (void)deleteSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| success   | Success block |
| failure   | Failure block |

**Example**


Objc:

```objc
- (void)deleteSmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
    [self.smartScene deleteSceneWithSuccess:^{
        NSLog(@"delete scene success");
    } failure:^(NSError *error) {
        NSLog(@"delete scene failure: %@", error);
    }];
}
```
Swift:

```swift
func deleteSmartScene() {
    smartScene?.delete(success: {
        print("delete scene success")
    }, failure: { (error) in
        if let e = error {
            print("delete scene failure: \(e)")
        }
    })
}
```
### Execute Scene

**Declaration**

Note: This method only sends instructions to the cloud to execute the scene. If you want to monitor the dp point change of the device, you can see [Device Management -> Delegate of Device](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#delegate-of-device).

```objective-c
- (void)executeSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| success   | Success block |
| failure   | Failure block |

**Example**


Objc:

```objc
- (void)executeSmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
	[self.smartScene executeSceneWithSuccess:^{
   		NSLog(@"execute scene success");
    } failure:^(NSError *error) {
        NSLog(@"execute scene failure: %@", error);
    }];
}
```

Swift:

```swift
func executeSmartScene() {
    smartScene?.execute(success: {
        print("execute scene success")
    }, failure: { (error) in
        if let e = error {
            print("execute scene failure: \(e)")
        }
    })
}
```

### Enable Scene (Scene With At Least One Condition Can Be Enabled Or Disabled)

**Declaration**

```objective-c
- (void)enableSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)enableSmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
	[self.smartScene enableSceneWithSuccess:^{
   		NSLog(@"enable scene success");
    } failure:^(NSError *error) {
        NSLog(@"enable scene failure: %@", error);
    }];
}
```

Swift:

```swift
func enableSmartScene() {
    smartScene?.enable(success: {
        print("enable scene success")
    }, failure: { (error) in
        if let e = error {
            print("enable scene failure: \(e)")
        }
    })
}
```

### Disable Scene (Scene With At Least One Condition Can Be Enabled Or Disabled)

**Declaration**

Disable an automated scene, the scene will not be executed automatically.

```objective-c
- (void)disableSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| success   | Success block |
| failure   | Failure block |

**Example**

Objc:

```objc
- (void)disableSmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
	[self.smartScene disableSceneWithSuccess:^{
   		NSLog(@"disable scene success");
    } failure:^(NSError *error) {
        NSLog(@"disable scene failure: %@", error);
    }];
}
```
Swift:

```swift
func disableSmartScene() {
    smartScene?.disableScene(success: {
        print("disable scene success")
    }, failure: { (error) in
        if let e = error {
            print("disable scene failure: \(e)")
        }
    })
}
```

### Monitor scene information changes

**Declaration**

The delegate method for monitoring of scene addition, editing, deletion, execution, opening and closing operations.

```objective-c
- (void)sceneManager:(TuyaSmartSceneManager *)manager state:(NSString *)state sceneId:(NSString *)sceneId;
```

**Parameters**

| Parameter |Description|
| ------ | ----- |
| TuyaSmartSceneManager | Scene data management class, you can use this class to get scene list data |
| state | state string, for example: update、disable |
| sceneId | scene id |

**Example**

Objc:

```objc
- (void)sceneManager:(TuyaSmartSceneManager *)manager state:(NSString *)state sceneId:(NSString *)sceneId {
    if ([state isEqualToString:@"update"]) {
        NSLog(@"update scene list");
    }
}
```

Swift:

```swift
func sceneManager(_ manager: TuyaSmartSceneManager!, state: String!, sceneId: String!) {
    if state == "update" {
        print("reload scene list")
    }
}
```

## Emample

The SDK has added `TuyaSmartSceneDataFactory` as a tool class collection in 3.14.0 and above, which is used to conveniently create the conditions, actions, and effective time period conditions of the scene.

If you are using a version earlier than 3.14.0, refer to the following example to create conditions and actions.
If you are using version 3.14.0 or above, it is recommended to use the tool classes provided by `TuyaSmartSceneDataFactory` to create conditions and actions.

### Scene Condition
#### Create An Object For `TuyaSmartSceneConditionModel`
From the `Obtain condition list` API, you can obtain the condition list, which is compose of TuyaSmartSceneDPModel object. With the APIs obout city, you can obtain cityId value. Now it's time to create an object of TuyaSmartSceneConditionModel, cause now we know where and what‘s the conditon is to execute the scene.

If you save the values about conditions in an object of TuyaSmartSceneDPModel(you can save it anywhere you like), you can use a initialize method like below to cheate a TuyaSmartSceneConditionModel object. You can use category to add a new method to TuyaSmartSceneConditionModel.

	//new initialize method
	- (instancetype)initWithSmartSceneDPModel:(TuyaSmartSceneDPModel *)dpModel {
	    
	    if (self = [super init]) {
	        self.entityType = dpModel.entityType;
	        self.iconUrl = dpModel.iconUrl;
	        if (dpModel.entityType == 3) {
	        	//Meteorological conditions
	            self.entityId = dpModel.cityId;
	            self.entityName = dpModel.cityName;
	            self.entitySubIds = dpModel.entitySubId;
	            self.cityName = dpModel.cityName;
	            self.cityLatitude = dpModel.cityLatitude;
	            self.cityLongitude = dpModel.cityLongitude;
	        } else if (dpModel.entityType == 7) {
	        	//Timer condition
	            NSString *value = dpModel.valueRangeJson[dpModel.selectedRow][0];
	            self.extraInfo = @{@"delayTime" : value};
	        } else {
	        	//Device conditon
	            self.entityId = dpModel.devId;
	            TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:dpModel.devId];
	            self.entityName = device.deviceModel.name;
	            self.entitySubIds = [NSString stringWithFormat:@"%ld", (long)dpModel.dpId];
	        }
	        self.expr = dpModel.expr;
	    }
	    return self;
	}
#### Create Expr Property 
The `expr` property in TuyaSmartSceneConditionModel is an expression of condition, which is a NSArray object(important, the outermost object is a NSArray object), like @[@"$temp",@"<",@15].

Example for `expr`:

Meteorological conditions:

- Temperature @[@[@"$temp",@"<",@15]]
- Humidity @[@[@"$humidity",@"==",@"comfort"]]
- Weather @[@[@"$condition",@"==",@"snowy"]]
- PM2.5 @[@[@"$pm25",@"==",@"fine"]]
- Air quality @[@[@"$aqi",@"==",@"fine"]]
- Sunset/Sunrise @[@[@"$sunsetrise",@"==",@"sunrise"]]

Timer condition:

Timer conditon's `expr` use a NSDictionry to define the timer, for emample, {timeZoneId = "Asia/Shanghai",loops = "0000000",time = "08:00",date = "20180308"}. The loops represent date from Sunday to Saturday, 1 for validate and 0 for invalidate.

Device condition:

Device conditon use a NSArray objcet to define the conditon value, for example, @[@[@"$dp1",@"==",@YES]], which can represent a condition like "when a device is open". The `dp1` is a dpId property from `TuyaSmartSceneDPModel` object.
### Scene Action
Scene action is a object of `TuyaSmartSceneActionModel `, the `actionExecutor ` property is the type of the scene action. Action type includs:

- dpIssue 	device action
- deviceGroupDpIssue 	device group action
- ruleTrigger 	trigger a smart scene
- ruleEnable 		enable an auto
- ruleDisable 	disable an auto
- delay delay 	action

Create a new object of `TuyaSmartSceneActionModel`,then set the values of properties. There are 3 important properties:entityId、actionExecutor、executorProperty, which describe which entity to act, which action type to do, and exact action execute property.

1. Device。entityId property is the device devId，actionExecutor is `dpIssue`，executorProperty is a dictionary，like {"1":YES}, "1" representing the dp of a device.

2. Group. entityId property is groupId, actionExecutor is `deviceGroupDpIssue `, executorProperty is the same as Device. 
3. Trigger Scene。entityId is sceneId，actionExecutor is `ruleTrigger`，executorProperty is nil。
4. Enable an auto。entityId a auto's sceneId，actionExecutor is `ruleEnable`，executorProperty is nil。
5. Disable an auto。entityId is an auto's sceneId，actionExecutor is `ruleDisable`，executorProperty is nil。
6. Delay action。entityId is `delay`，actionExecutor is `delay`，executorProperty is the time to delay, which is defined with a diction, for example `{@"minutes":@"1",@"seconds":@"30"}`, representing one minutes and 30 seconds.It currently supports up to 5 hours, or 300 minutes.

### TuyaSmartSceneDataFactory Tool Class Collection

TuyaSmartSceneDataFactory contains the following creation tool classes:

| Class | Description |
|---|---|
|TuyaSmartScenePreConditionFactory| Pre-conditions for creating automation scenarios, such as the effective time period.|
TuyaSmartSceneConditionFactory| Conditions for creating automated scenarios, such as weather conditions, device conditions. |
|TuyaSmartSceneActionFactory| Used to create scene actions, such as device actions. |


And two auxiliary classes:

| Class | Description |
|---|---|
| TuyaSmartSceneExprModel | Used to store expr expressions in scene conditions.|
| TuyaSmartSceneConditionExprBuilder |A tool class for generating conditional expressions in automation scenes.|

For the creation of effective time periods, conditions, and actions, all supported types can be used by referring to the comments in the SDK header file. 

Note: Because of the need to adapt to multiple languages, `exprDisplay` and `actionDisplayNew` are not generated in conditions and actions to display the details of conditions and actions. Developers need to manually generate them according to the expression `expr` in the conditions and the execution parameter `executorProperty` in the action.

#### Example

Taking the creation of an device condition as an example, the usage sequence is as follows:

1. Use `TuyaSmartSceneConditionExprBuilder` to create a` TuyaSmartSceneExprModel` object, and generate the expression `expr` required to create conditions.
2. Using the API in `TuyaSmartSceneConditionFactory`, pass in the` TuyaSmartSceneExprModel` object generated in the first step and other required parameters to generate a condition object.


**Declaration**

Create an expr model.

```objective-c
+ (TuyaSmartSceneExprModel *)createBoolExprWithType:(NSString *)type
                                             isTrue:(BOOL)isTrue
                                           exprType:(ExprType)exprType;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| type | Weather type or device dpId |
| isTrue |Boolean parameter|
| exprType |Differentiate whether a weather or device type was created|

**Declaration**

Create a device condition.

```objective-c
+ (TuyaSmartSceneConditionModel *)createDeviceConditionWithDevice:(TuyaSmartDeviceModel *)device
                                                          dpModel:(TuyaSmartSceneDPModel *)dpModel
                                                        exprModel:(TuyaSmartSceneExprModel *)exprModel;
```
**Parameters**

| Parameter |Description|
| ------ | ----- |
| device | Device model |
| dpModel |Dp model |
| exprModel | Model object created with TuyaSmartSceneConditionExprBuilder. |

**Example**

```objective-c
TuyaSmartSceneExprModel *exprModel = [TuyaSmartSceneConditionExprBuilder createBoolExprWithType:dpModel.entitySubId
                                                                            isTrue:YES
                                                                          exprType:exprType];
TuyaSmartSceneConditionModel *conditionModel = [TuyaSmartSceneConditionFactory createDeviceConditionWithDevice:deviceModel
                                                                                     dpModel:self.model
                                                                                   exprModel:exprModel];
```


To generate preconditions and actions, use the APIs provided in `TuyaSmartScenePreConditionFactory` and`TuyaSmartSceneActionFactory`.
