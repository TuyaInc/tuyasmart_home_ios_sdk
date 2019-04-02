基于Tuya SDK开发的app，Tuya平台支持Push功能，支持给用户发送运营Push和产品的告警Push。

### Xcode配置

点击项目 - `TARGETS` - `Capabilities`, 将这里的 `Push Notification `的开关打开，效果如下图所示：

![ios-push](./images/ios-push.png)


### 涂鸦开发者平台配置
登录涂鸦开发者平台 - 进入对应APP - 推送配置 - 上传push证书

![ios-push-setting](./images/ios-push-setting.png)



### 初始化
在 `didFinishLaunchingWithOptions` 方法中初始化push

```objc
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	
    [application registerForRemoteNotifications];
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
   	
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        //iOS10需要加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
            } else {
                //点击不允许
            }
        }];
    }
    
}

```

### 注册pushId
在`didRegisterForRemoteNotificationsWithDeviceToken`中注册pushId到Tuya SDK

```objc

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
        
    NSString *pushId = [[[[deviceToken description]
                 stringByReplacingOccurrencesOfString:@" " withString:@""]
                stringByReplacingOccurrencesOfString:@"<" withString:@""]
               stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"pushId is %@",pushId);
    
    [[TuyaSmartSDK sharedInstance] setValue:pushId forKey:@"deviceToken"];
}

```


### 接收通知
接收到远程通知，在代理方法didReceiveRemoteNotification中执行

```objc
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler {


}
```

### 发送Push

#### 新增运营Push
涂鸦开发者平台 - 用户运营 - 消息中心 - 新增消息
![ios-push-setting](./images/ios-push-setting-operation.png)

#### 新增告警Push
涂鸦开发者平台 - 对应产品 - 扩展功能 - 告警设置 - 新增告警规则(应用推送方式)
![ios-push-setting](./images/ios-push-setting-warning.png)



#### 测试步骤：

- Tuya 平台现在对外只支持正式推送证书，所以需要用正式证书打包成ipa文件，上传到 testflight 或者 App Store 才能正常收到推送
- 如果通过Xcode 直接安装的包，是测试证书，不能收到推送。用开发证书打包 ipa文件，安装后也是不能收到推送