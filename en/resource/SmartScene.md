
The `TuyaSmartScene` class provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list. 

### Add scenes

User needs to upload the name of scene, Id of home, url of background pictures, showing the picture in the home page or not, task list (one at least) and determine carrying out task(s) when one or multiple conditions are met when he/she add a scene. The user can just set the name, tasks, background picture, but he/she has to set conditions manually. 


```objc
- (void)addSmartScene {

    [TuyaSmartScene addNewSceneWithName:@"your_scene_name" homeId:homeId background:@"background_url" showFirstPage:YES conditionList:(NSArray<TuyaSmartSceneConditionModel *> *) actionList:(NSArray<TuyaSmartSceneActionModel *> *) matchType:TuyaSmartConditionMatchAny success:^(TuyaSmartSceneModel *sceneModel) {
        NSLog(@"add scene success %@:", sceneModel);
    } failure:^(NSError *error) {
        NSLog(@"add scene failure: %@", error);
    }];
}

```
### Edit scene

User needs to edit the name of scene, background pictures, condition list, task list, and determine carrying out task(s) when one or multiple conditions are met. 

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
### Delete scene

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
### Execute scene

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

### Enable scene (scene with at least one condition can be enabled or disabled)

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

### Disable scene (scene with at least one condition can be enabled or disabled)

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