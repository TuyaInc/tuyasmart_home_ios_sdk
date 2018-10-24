## 智能场景
涂鸦云支持用户根据实际生活场景，通过设置气象或设备条件，当条件满足时，让一个或多个设备执行相应的任务。

场景相关的功能对应`TuyaSmartScene`和`TuyaSmartSceneManager`两个类，`TuyaSmartScene`提供了单个场景的添加、编辑、删除、执行4种操作，需要使用场景id进行初始化，场景id指的是`TuyaSmartSceneModel`的`sceneId`字段，可以从场景列表中获取。`TuyaSmartSceneManager`类（单例）则主要提供了场景里条件、任务、设备、城市相关的所有数据。

在使用智能场景相关的接口之前，需要首先了解场景条件和场景任务这两个概念。

### 场景条件
场景条件对应`TuyaSmartSceneConditionModel`类，涂鸦云支持两种条件类型：

- 气象条件：包括温度、湿度、天气、PM2.5、空气质量、日落日出，用户选择气象条件时，可以选择当前城市。
- 设备条件：指用户可预先选择一个设备的功能状态，当该设备达到该状态时，会触发当前场景里的任务，但同一设备不能同时作为条件和任务，避免操作冲突。
- 定时条件：指可以按照指定的时间去执行预定的任务。

### 场景任务
场景任务是指当该场景满足已经设定的气象或设备条件时，让一个或多个设备执行某种操作，对应`TuyaSmartSceneActionModel`类。或者关闭、开启一个自动化（带有场景条件的就叫做自动化）

### 获取场景列表
```objc
// 获取家庭下的场景列表
- (void)getSmartSceneList {
    [[TuyaSmartSceneManager sharedInstance] getSceneListWithHomeId:homeId success:^(NSArray<TuyaSmartSceneModel *> *list) {
        NSLog(@"get scene list success %@:", list);
    } failure:^(NSError *error) {
        NSLog(@"get scene list failure: %@", error);
    }];
}
```
### 添加场景

添加场景需要传入场景名称，家庭的Id，背景图片的url，是否显示在首页，条件列表，任务列表（至少一个任务），满足任一条件还是满足所有条件时执行。也可以只设置名称和任务，背景图片，不设置条件，但是需要手动执行。


```objc
- (void)addSmartScene {

    [TuyaSmartScene addNewSceneWithName:@"your_scene_name" homeId:homeId background:@"background_url" showFirstPage:YES conditionList:(NSArray<TuyaSmartSceneConditionModel *> *) actionList:(NSArray<TuyaSmartSceneActionModel *> *) matchType:TuyaSmartConditionMatchAny success:^(TuyaSmartSceneModel *sceneModel) {
        NSLog(@"add scene success %@:", sceneModel);
    } failure:^(NSError *error) {
        NSLog(@"add scene failure: %@", error);
    }];
}

```
### 编辑场景

编辑场景的名称、背景图、条件列表、任务列表、满足任一条件还是满足所有条件时执行

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
### 删除场景

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
### 执行场景

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

### 开启场景（只有至少带有至少一个条件的场景才可以开启和失效场景）
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

### 失效场景（只有至少带有至少一个条件的场景才可以开启和失效场景）
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
### 获取条件列表

获取条件列表，如温度、湿度、天气、PM2.5、日落日出等，注意：设备也可作为条件。
条件中的温度分为摄氏度和华氏度，根据需求传入需要的数据。

```objc
- (void)getConditionList {
    [[TuyaSmartSceneManager sharedInstance] getConditionListWithFahrenheit:YES success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
        NSLog(@"get condition list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get condition list failure: %@", error);
    }];
}
```
### 获取任务设备列表

添加任务时，需获取任务的设备列表，用来选择执行相应的任务。

```objc
- (void)getActionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get action device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device list failure: %@", error);
	}];
}
```
### 获取条件设备列表

添加条件时，除了温度、湿度、天气等这些气象条件可以作为任务执行条件外，设备也可以作为条件，即获取条件设备列表，然后选择一个设备执行相应的任务作为条件。

```objc
- (void)getConditionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getConditionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get condition device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device list failure: %@", error);
	}];
}
```
### 获取任务设备的dp列表

添加或编辑场景任务时，选择设备后，需要根据选择设备的deviceId获取设备dp列表，进而选择某一个dp功能点，即指定该设备执行该项任务。

```objc
- (void)getActionDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get action device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device dp list failure: %@", error);
	}];
}
```
### 获取条件设备的dp列表

选择场景条件时，选择了设备，需要根据选择设备的deviceId获取设备dp列表，进而选择某一个dp功能点，即指定该设备执行该dp功能作为该场景的执行条件。

```objc
- (void)getCondicationDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getCondicationDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get condition device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device dp list failure: %@", error);
	}];
}    
```
### 获取城市列表

选择场景气象条件时，根据国家码获取城市列表，用户可以选择当前城市。（注：国外部分国家的城市列表可能暂时不全，如果是国外用户，建议根据经纬度获取城市信息。）

```objc
- (void)getCityList {
	[[TuyaSmartSceneManager sharedInstance] getCityList:@"your_country_code" success:^(NSArray<TuyaSmartCityModel *> *list) {
		NSLog(@"get city list success:%@", list);
	} failure:^(NSError *error) {
   		NSLog(@"get city list failure: %@", error);    
	}];
}
```
### 根据经纬度获取城市信息

```objc
- (void)getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfo:@"your_location_latitude" longitude:@"your_location_longitude" success:^(TuyaSmartCityModel *city) {
		NSLog(@"get city info success:%@", city);
	} failure:^(NSError *error) {
		NSLog(@"get city info failure:%@", error);       
	}];
}
```
### 根据城市id获取城市信息

根据城市id获取城市信息，城市id可以从城市列表获取。

```objc
- (void) getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfoByCityId:@"your_city_id" success:^(TuyaSmartCityModel *city) {
		NSLog(@"get city info success:%@", city);     
	} failure:^(NSError *error) {
		NSLog(@"get city info failure:%@", error);       
	}];
}
```

### 场景排序


```objc
- (void) sortScene {
	[[TuyaSmartSceneManager sharedInstance] sortSceneWithHomeId:homeId sceneIdList:(NSArray<NSString *> *) success:^{
        NSLog(@"sort scene success"); 
    } failure:^(NSError *error) {
        NSLog(@"sort scene failure:%@", error);
    }];
}
```