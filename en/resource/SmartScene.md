## Smart scene

The Tuya Cloud allows users to set meteorological or device conditions based on actual scenes in life, and if conditions are met, one or multiple devices will carry out corresponding tasks.

All functions related to scenes will be realized by using the `TuyaSmartScene` class and the `TuyaSmartSceneManager` class. The `TuyaSmartScene` class provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list. The `TuyaSmartSceneManager` class (singleton) mainly provides all data related to conditions, tasks, devices and city for scenes.

Before using interfaces related to the smart scene, you have to understand the scene conditions of scene tasks first.

### Scene conditions

All scenes conditions are defined in the `TuyaSmartSceneConditionModel` class, and Tuya supports two types of conditions:

- Meteorological conditions including temperature, humidity, weather, PM2.5, air quality and sunrise and sunset. User can select city when he/she selects the meteorological conditions.
- Device conditions: if you have preset a function status for a device, the task in the scene will be triggered when the device status is reached. To avoid conflicts in operation, the same device cannot be used for both conditions and task at the same time.
- Timing conditions: the device will carry out preset task at the required time.

### Scene action

In this case, one or multiple devices will run some operations or enable or disable an automation action (with scene conditions) when the preset meteorological or device conditions are met. All relevant functions are realized in the `TuyaSmartSceneActionModel` class.

**There are some examples at the end of this document, whice can help you about creating an object of `TuyaSmartSceneActionModel` or `TuyaSmartSceneConditionModel`.**

### Obtain scene list

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

#### Obtain scene's supported cover list
Obtain scene's supported cover url list.

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

## Scene operation

The `TuyaSmartScene` class provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list.

### Add scenes

User needs to upload the name of scene, Id of home, url of background pictures, showing the picture in the home page or not, task list (one at least) and determine carrying out task(s) when one or multiple conditions are met when he/she add a scene. The user can just set the name, tasks, background picture, but he/she has to set conditions manually.


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
### Edit scene

User needs to edit the name of scene, background pictures, condition list, task list, and determine carrying out task(s) when one or multiple conditions are met.

Objc:

```objc
- (void)modifySmartScene {
//    self.smartScene = [TuyaSmartScene sceneWithSceneId:@"your_scene_id"];
    [self.smartScene modifySceneWithName:name background:@"background_url" showFirstPage:YES condition:(NSArray<TuyaSmartSceneConditionModel *> *) actionList:(NSArray<TuyaSmartSceneActionModel *> *) matchType:TuyaSmartConditionMatchAny success:^{
        NSLog(@"modify scene success");
    } failure:^(NSError *error) {
        NSLog(@"modify scene failure: %@", error);
    }];
}
```
Swift:

```swift
func modifySmartScene() {
    smartScene?.modifyScene(withName: "name", background: "background_url", showFirstPage: true, conditionList: [TuyaSmartSceneConditionModel]!, actionList: [TuyaSmartSceneActionModel]!, matchType: TuyaSmartConditionMatchAny, success: {
        print("modify scene success")
    }, failure: { (error) in
        if let e = error {
            print("modify scene failure: \(e)")
        }
    })
}
```
### Delete scene

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
### Execute scene

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

### Enable scene (scene with at least one condition can be enabled or disabled)

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

### Disable scene (scene with at least one condition can be enabled or disabled)

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
### Obtain condition list

Obtain condition list. The condition can be temperature, humidity, weather, PM2.5, sunrise and sunset. It shall be noted that the device can also be a condition. The temperature can be in the Celsius system and Fahrenheit, and data shall be uploaded based on needs.
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
### Obtain the action device list

When adding tasks, the device list of task shall be obtained.

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
### Obtain the condition device list

Except for meteorological conditions such as temperature, humidity and weather, etc., the device can also be a condition. The condition device list shall be obtained, and one device that is carrying out some tasks will be used as a condition.

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

### Obtain the dp list of action device

When adding or editing scene actions, the user needs to obtain the device dp list based on the deviceId of devices to select a dp function point so as to assign the action to the device.

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

### Obtain the dp list of condition device

When selecting scene conditions, the user needs to obtain the device dp list based on the deviceId to select a dp function point so that the operation of the dp function of a device can be used as the condition of the scene.

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

### Obtain the city list

When selecting meteorological conditions for scene, user can obtain the city list according to the country code. The user can select the city he is currently in. (Note: city list of some foreign countries may be incomplete temporarily. If you are not in China, it is recommended that you obtain the city information according to the altitude and longitude.)Use isoCountryCode，eg:United States = "US"。

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

### Obtain the city information according to the altitude and longitude of city

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
### Obtain the city information according to the city id.

Obtain the city information according to the city id. The city id can be attained from the city list.

```objc
- (void) getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfoByCityId:@"your_city_id" success:^(TuyaSmartCityModel *city) {
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

### Sort scene


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

## Emample
#### Scene Condition
##### Create an object for `TuyaSmartSceneConditionModel`
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
##### Create expr property 
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
####Scene Action
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
6. Delay action。entityId is `delay`，actionExecutor is `delay`，executorProperty is the time to delay, which is defined with a diction, for example `{@"minutes":@"1",@"seconds":@"30"}`, representing one minutes and 30 seconds. The max time is 59m59s.
