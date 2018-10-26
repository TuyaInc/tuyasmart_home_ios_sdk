## 单个场景操作
TuyaSmartScene`提供了单个场景的添加、编辑、删除、执行4种操作，需要使用场景id进行初始化，场景id指的是`TuyaSmartSceneModel`的`sceneId`字段，可以从场景列表中获取。


#### 添加场景

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
#### 编辑场景

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
#### 删除场景

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
#### 执行场景

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

#### 开启场景（只有至少带有至少一个条件的场景才可以开启和失效场景）
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

#### 失效场景（只有至少带有至少一个条件的场景才可以开启和失效场景）
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