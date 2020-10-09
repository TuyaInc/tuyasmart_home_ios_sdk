# 智能场景

智能场景分为「一键执行场景」和「自动化场景」，下文分别简称为「场景」和「自动化」。

场景是用户添加动作，手动触发；自动化是由用户设定条件，当条件触发后自动执行设定的动作。

涂鸦云支持用户根据实际生活场景，通过设置气象或设备条件，当条件满足时，让一个或多个设备执行相应的任务。



| 类名                               | 说明                                                         |
| ---------------------------------- | ------------------------------------------------------------ |
| TuyaSmartScene                     | 提供了单个场景的添加、编辑、删除、执行4种操作，需要使用场景id进行初始化，场景id指的是 `TuyaSmartSceneModel` 的 `sceneId` 字段，可以从场景列表中获取。 |
| TuyaSmartSceneManager              | 主要提供了场景里条件、任务、设备、城市相关的所有数据，和场景列表数据获取。 |
| TuyaSmartScenePreConditionFactory  | 提供快捷创建自动化生效条件方法的工具类                       |
| TuyaSmartSceneConditionFactory     | 提供快捷创建场景条件方法的工具类                             |
| TuyaSmartSceneActionFactory        | 提供快捷创建场景动作方法的工具类                             |
| TuyaSmartSceneConditionExprBuilder | 提供快捷创建场景条件表达式方法的工具类                       |



在使用智能场景相关的接口之前，需要首先了解场景条件和场景任务这两个概念。

## 场景条件

场景条件对应 `TuyaSmartSceneConditionModel` 类，涂鸦云支持以下条件类型：

- 气象条件：包括温度、湿度、天气、PM2.5、空气质量、日落日出，用户选择气象条件时，可以选择当前城市。
- 设备条件：指用户可预先选择一个设备的功能状态，当该设备达到该状态时，会触发当前场景里的任务，但同一设备不能同时作为条件和任务，避免操作冲突。
- 定时条件：指可以按照指定的时间去执行预定的任务。

## 场景任务

场景任务是指当该场景满足已经设定的气象或设备条件时，让一个或多个设备执行某种操作，对应 `TuyaSmartSceneActionModel` 类。或者关闭、开启一个自动化。

**新增场景时，场景条件和场景任务对象的创建，参考本文档末尾的示例。**

## 智能场景管理

### 获取场景列表
**接口说明**

获取场景列表数据。场景和自动化一起返回，通过条件 conditions 字段是否为空数组来区分场景和自动化。

```objc
- (void)getSceneListWithHomeId:(long long)homeId
                       success:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| homeId |家庭 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|

**示例代码**

Objc:

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

Swift:

```swift
// 获取家庭下的场景列表
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



### 获取条件列表
**接口说明**
获取条件列表，如温度、湿度、天气、PM2.5、日落日出等，注意：设备也可作为条件。
条件中的温度分为摄氏度和华氏度，根据需求传入需要的数据。

```objc
- (void)getConditionListWithFahrenheit:(BOOL)fahrenheit
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;
```
**参数说明**

|参数|说明|
| ------ | ----- |
| fahrenheit |YES：使用华氏单位，NO：使用摄氏单位|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 获取任务设备列表

**接口说明**

添加任务时，需获取任务的设备列表，用来选择执行相应的任务。

```objc
- (void)getActionDeviceListWithHomeId:(long long)homeId
                              success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                              failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| homeId |家庭 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 获取条件设备列表

**接口说明**

添加条件时，除了温度、湿度、天气等这些气象条件可以作为任务执行条件外，设备也可以作为条件，即获取条件设备列表，然后选择一个设备执行相应的任务作为条件。

```objc
- (void)getConditionDeviceListWithHomeId:(long long)homeId
                                 success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                                 failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| homeId |家庭 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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

### 获取任务设备的 dp 列表

**接口说明**

添加或编辑场景任务时，选择设备后，需要根据选择设备的 deviceId 获取设备 dp 列表，进而选择某一个 dp 功能点，即指定该设备执行该项任务。

```objc
- (void)getActionDeviceDPListWithDevId:(NSString *)devId
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| devId |设备 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|

**示例代码**

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



### 获取条件设备的 dp 列表

**接口说明**

选择场景条件时，选择了设备，需要根据选择设备的 deviceId 获取设备 dp 列表，进而选择某一个 dp 功能点，即指定该设备执行该 dp 功能作为该场景的执行条件。

```objc

- (void)getCondicationDeviceDPListWithDevId:(NSString *)devId
                                    success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                    failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| devId |设备 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 获取城市列表

**接口说明**

选择场景气象条件时，根据国家码获取城市列表，用户可以选择当前城市。（注：国外部分国家的城市列表可能暂时不全，如果是国外用户，建议根据经纬度获取城市信息。） countryCode 使用 isoCountryCode，例如中国 = "CN"。

```objc
- (void)getCityListWithCountryCode:(NSString *)countryCode
                           success:(void(^)(NSArray<TuyaSmartCityModel *> *list))success
                           failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| countryCode |国家码，使用 isoCountryCode ，例如中国 = "CN"|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 根据经纬度获取城市信息

**接口说明**

```objc
- (void)getCityInfoWithLatitude:(NSString *)latitude
                      longitude:(NSString *)longitude
                        success:(void(^)(TuyaSmartCityModel *model))success
                        failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| latitude |纬度|
| longitude | 经度 |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 根据城市 Id 获取城市信息

**接口说明**

根据城市id获取城市信息，城市 Id 可以从城市列表获取。

```objc
- (void)getCityInfoWithCityId:(NSString *)cityId
                      success:(void(^)(TuyaSmartCityModel *model))success
                      failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| cityId |城市 Id|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

Objc:

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



### 场景排序

**接口说明**

对已经存在的场景进行排序。

```objc
- (void)sortSceneWithHomeId:(long long)homeId
                sceneIdList:(NSArray<NSString *> *)sceneIdList
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| homeId |家庭 Id|
| sceneIdList |排序后的场景 Id 数组|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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

### 获取场景背景图片列表

**接口说明**

获取场景支持的背景图片 url 列表。

```objc
- (void)getSmartSceneBackgroundCoverWithsuccess:(TYSuccessList)success
                                        failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



## 单个场景操作

`TuyaSmartScene` 提供了单个场景的添加、编辑、删除、执行4种操作，需要使用场景 id 进行初始化，场景 id 指的是 `TuyaSmartSceneModel` 的 `sceneId` 字段，可以从场景列表中获取。


### 添加场景

**接口说明**

添加场景需要传入场景名称，家庭的 Id，背景图片的 url，是否显示在首页，前置条件列表（生效时间段），条件列表，任务列表（至少一个任务），满足任一条件还是满足所有条件时执行。也可以只设置名称和任务，背景图片，不设置条件，但是需要手动执行。

```objc
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
**参数说明**

|参数|说明|
| ------ | ----- |
| name| 场景名 |
| homeId | 家庭 Id |
| background | 背景图 url，只能使用「获取场景背景图片列表」接口中提供的背景图 |
| showFirstPage | 是否显示在首页标识 |
| preConditionList | 生效时间段，已前置条件数组的形式传入 |
| conditionList | 条件数组 |
| actionList | 动作数组 |
| matchType |条件的匹配类型，「与」或者「或」|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 编辑场景

**接口说明**

编辑场景的名称、背景图、前置条件（生效时间段）、条件列表、任务列表、满足任一条件还是满足所有条件时执行。

```objc
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
**参数说明**

|参数|说明|
| ------ | ----- |
| name| 场景名 |
| background | 背景图 url，只能使用「获取场景背景图片列表」接口中提供的背景图 |
| showFirstPage | 是否显示在首页标识 |
| preConditionList | 生效时间段，以前置条件数组的形式传入 |
| conditionList | 条件数组 |
| actionList | 动作数组 |
| matchType |条件的匹配类型，「与」或者「或」|
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|

**示例代码**

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



### 删除场景

**接口说明**

删除指定场景。

```objc

- (void)deleteSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**


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



### 执行场景

**接口说明**

执行指定场景。

注：这个方法只管发送指令到云端执行场景，具体设备执行成功与否可以参考 [设备管理->设备代理监听](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#%E8%AE%BE%E5%A4%87%E4%BB%A3%E7%90%86%E7%9B%91%E5%90%AC) 来监听设备的 dp 点变化。

```objc
- (void)executeSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


```
**参数说明**

|参数|说明|
| ------ | ----- |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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



### 开启自动化场景（只有自动化场景才可以开启和失效）

**接口说明**

开启一个自动化。

```objc
- (void)enableSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**


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



### 失效自动化场景（只有自动化场景才可以开启和失效）

**接口说明**

使一个自动化场景失效，不再自动执行。

```objc
- (void)disableSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

```
**参数说明**

|参数|说明|
| ------ | ----- |
| success |接口发送成功回调|
| failure |接口发送失败回调，error 标示失败原因|
**示例代码**

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

### 监听场景信息变更

**接口说明**

场景添加、编辑、删除、执行、开启和关闭操作的监听回调方法。

```objc
- (void)sceneManager:(TuyaSmartSceneManager *)manager state:(NSString *)state sceneId:(NSString *)sceneId;
```

**参数说明**

|参数|说明|
| ------ | ----- |
| TuyaSmartSceneManager |场景数据管理类，可以使用该类获取场景列表数据 |
| state | 状态变化字符串，例如：update（更新）、disable（关闭自动化) |
| sceneId | 场景Id |

**示例代码**

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

## 场景条件和场景动作对象创建示例

SDK在 3.14.0 及以上版本加入了 `TuyaSmartSceneDataFactory` 这个工具类集合，用于便捷的创建场景的条件、动作、生效时间段条件。

如果使用的是 3.14.0 以前的版本，请参照以下示例创建条件和动作。
如果使用的是 3.14.0 及以上版本，推荐使用 `TuyaSmartSceneDataFactory` 提供的工具类创建条件和动作。

### 场景条件

#### 创建场景条件对象 TuyaSmartSceneConditionModel
气象条件包括温度、湿度、天气、PM2.5、空气质量、日落日出，这里以设置温度条件为例创建气象条件对象。场景条件也可以设置定时条件和设备条件。

从“获取条件列表”接口可以获取到所有气象条件的 `TuyaSmartSceneDPModel` 对象列表。可以根据 `TuyaSmartSceneDPModel` 对象的 `entityName` 和 `entityId` 区分不同的气象条件。从获取城市信息相关的接口，获取到 `TuyaSmartCityModel` 对象，使用其中的 `cityId` 值作为定位信息。

选择完具体的条件值之后,如果将界面选择的温度、城市等信息保存在了 `TuyaSmartSceneDPModel` 对象中(也可以存在任何你喜欢的对象中)，可以通过一个 `TuyaSmartSceneDPModel` 对象初始化一个 `TuyaSmartSceneConditionModel` 条件对象，示例方法如下，这里使用了Category为 `TuyaSmartSceneConditionModel` 增加了一个分类方法：


	//新增初始化方法
	- (instancetype)initWithSmartSceneDPModel:(TuyaSmartSceneDPModel *)dpModel {
	    
	    if (self = [super init]) {
	        self.entityType = dpModel.entityType;
	        self.iconUrl = dpModel.iconUrl;
	        if (dpModel.entityType == 3) {
	        	//气象条件
	            self.entityId = dpModel.cityId;
	            self.entityName = dpModel.cityName;
	            self.entitySubIds = dpModel.entitySubId;
	            self.cityName = dpModel.cityName;
	            self.cityLatitude = dpModel.cityLatitude;
	            self.cityLongitude = dpModel.cityLongitude;
	        } else if (dpModel.entityType == 7) {
	        	//定时条件
	            NSString *value = dpModel.valueRangeJson[dpModel.selectedRow][0];
	            self.extraInfo = @{@"delayTime" : value};
	        } else {
	        	//设备条件
	            self.entityId = dpModel.devId;
	            TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:dpModel.devId];
	            self.entityName = device.deviceModel.name;
	            self.entitySubIds = [NSString stringWithFormat:@"%ld", (long)dpModel.dpId];
	        }
	        //expr 数组的组装见下文
	        self.expr = dpModel.expr;
	    }
	    return self;
	}


#### expr 表达式组装

`TuyaSmartSceneConditionModel` 的 expr 属性描述了条件的表达式，如“温度低于 15℃”这样的一个条件，就可以用 expr 来描述。expr 是一个数组（这里要注意，最外层一定是数组），数组中的每一个对象描述了一个条件，如 @[@"$temp",@"<",@15] 这个条件数组就描述了温度低于 15℃ 这个条件。注意，每个气象条件都应该对应一个 `TuyaSmartSceneConditionModel` ，所以 expr 数组中只包含一个条件数组。

气象条件 expr 示例：

- 温度 @[@[@"$temp",@"<",@15]]
- 湿度 @[@[@"$humidity",@"==",@"comfort"]]
- 天气 @[@[@"$condition",@"==",@"snowy"]]
- PM2.5 @[@[@"$pm25",@"==",@"fine"]]
- 空气质量 @[@[@"$aqi",@"==",@"fine"]]
- 日出日落 @[@[@"$sunsetrise",@"==",@"sunrise"]]

定时条件 expr 示例:

定时条件使用一个字典表示，例如 {timeZoneId = "Asia/Shanghai",loops = "0000000",time = "08:00",date = "20180308"}。其中 loops 中的每一位分别表示周日到周六的每一天，1 表示生效，0 表示不生效。注意这个表示定时的字典也需要使用数组包起来，因为 expr 是个数组。

设备条件 expr 示例：

设备条件使用一个数组表示选定的条件值。选择的条件组装的 expr 可以表示为 @[@[@"$dp1",@"==",@YES]] ,这里可以表示一个“电灯开”的条件。其中 `dp1` 是 `TuyaSmartSceneDPModel` 中提供的 dp 点的名称。
###场景动作
场景动作类是 `TuyaSmartSceneActionModel` ，其中的 `actionExecutor` 属性即表示场景动作类型。场景动作类型包括:

- dpIssue 设备
- deviceGroupDpIssue 群组
- ruleTrigger 触发场景
- ruleEnable 启动自动化
- ruleDisable 禁用自动化
- delay 延时动作

新建完 `TuyaSmartSceneActionModel` 的对象后，分别设置对应的属性，重点关注三个属性 entityId 、 actionExecutor 、 executorProperty，这三个属性描述了哪个对象要做动作，做什么类型的动作，具体做什么动作。

1. 设备。 entityId 属性对应设备的 devId ， actionExecutor 是 dpIssue ，executorProperty是一个字典，比如 {"1":YES} ,表示 dp 点 “1” ，执行的动作是 YES ，这个可以表示灯打开等布尔类型的 dp 点。dp 点的 Id 和 dp 可取的值可以通过“获取任务设备的 dp 列表”接口获取到。
2. 群组。entityId 属性对应群组的 groupId , actionExecutor 是 deviceGroupDpIssue ，其他的属性和设备动作相同。
3. 触发场景。 entityId 是场景 sceneId ，actionExecutor 是 ruleTrigger ，executorProperty 不需要。
4. 启动自动化。 entityId 是自动化 sceneId ，actionExecutor 是 ruleEnable ，executorProperty 不需要。
5. 禁用自动化。entityId 是自动化 sceneId ，actionExecutor 是 ruleDisable ，executorProperty不需要。
6. 延时动作。 entityId 是 delay ，actionExecutor 是 delay ，executorProperty 是延时的时间，用一个字典表示，形式和 key 为 {@"minutes":@"1",@"seconds":@"30"} ,表示 1 分 30 秒。目前最大支持 5 小时，即 300 分钟。

### TuyaSmartSceneDataFactory 工具类集合

TuyaSmartSceneDataFactory 中包涵以下创建工具类：

|类名|说明|
|---|---|
|TuyaSmartScenePreConditionFactory|用于创建自动化场景的前置条件，如生效时间段。|
TuyaSmartSceneConditionFactory|用于创建自动化场景的条件，如天气条件、设备条件。|
|TuyaSmartSceneActionFactory|用于创建场景动作，如设备动作。|

以及两个辅助类：

|类名|说明|
|---|---|
| TuyaSmartSceneExprModel |用于储存场景条件中的 expr 表达式。|
| TuyaSmartSceneConditionExprBuilder |自动化场景中条件表达式的生成工具类。|


生效时间段、条件、动作的创建，所有支持的类型可以参照 SDK 头文件中的注释使用。注意：因为要适配多语言，条件和动作中，未生成用来显示条件和动作的详情的 `exprDisplay` 和 `actionDisplayNew` ，需要开发者根据条件中的表达式 `expr` 和动作中的执行参数 `executorProperty` 手动拼接生成。

####使用示例

以创建一个开关类型的设备条件为例，使用顺序如下：
1. 使用 `TuyaSmartSceneConditionExprBuilder` 创建一个 `TuyaSmartSceneExprModel` 对象，生成创建条件所需的表达式`expr` 。
2. 使用 `TuyaSmartSceneConditionFactory` 中的 API ，传入第一步中生成的 `TuyaSmartSceneExprModel` 对象以及其他必需参数，生成条件对象。

**接口说明**

```objc
//创建exprModel
+ (TuyaSmartSceneExprModel *)createBoolExprWithType:(NSString *)type
                                             isTrue:(BOOL)isTrue
                                           exprType:(ExprType)exprType;
```

**参数说明**

|参数|说明|
| ------ | ----- |
| type | 天气类型或者设备 dpId |
| isTrue |布尔值参数|
| exprType |区分创建的是天气类型还是设备类型的枚举值|

**接口说明**

```objc
//创建一个设备条件。
+ (TuyaSmartSceneConditionModel *)createDeviceConditionWithDevice:(TuyaSmartDeviceModel *)device
                                                          dpModel:(TuyaSmartSceneDPModel *)dpModel
                                                        exprModel:(TuyaSmartSceneExprModel *)exprModel;
```

**参数说明**

|参数|说明|
| ------ | ----- |
| device | 设备model |
| dpModel |要创建的设备条件的 dpModel ，如设备下开关这个 dp 的 dpModel |
| exprModel | 使用 TuyaSmartSceneConditionExprBuilder 创建的 model 对象 |

**示例代码**

```objc
TuyaSmartSceneExprModel *exprModel = [TuyaSmartSceneConditionExprBuilder createBoolExprWithType:dpModel.entitySubId
                                                                            isTrue:YES
                                                                          exprType:exprType];
TuyaSmartSceneConditionModel *conditionModel = [TuyaSmartSceneConditionFactory createDeviceConditionWithDevice:deviceModel
                                                                                     dpModel:self.model
                                                                                   exprModel:exprModel];
```


生成前置条件和动作直接使用 `TuyaSmartScenePreConditionFactory` 和 `TuyaSmartSceneActionFactory` 中提供的 API 即可。
