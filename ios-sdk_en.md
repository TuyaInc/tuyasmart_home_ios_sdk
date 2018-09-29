title: iOS SDK 开发指南
subtitle: iOS SDK 开发指南 
published: true    
---

# Guidelines for Accessing Tuya Smart iOS SDK

## Function Overview

The Tuya Smart App SDK provides the interface encapsulation for the communication with hardware and Tuya Cloud to accelerate the App R&D. Main functions of it include: 

- Network configuration, control, state reporting, timer task, group, firmware upgrading and sharing related to hardware.
- Account system (general account functions such as registration, login, resetting password, etc. of mobile phone number and Email)
- See [Tuya Cloud api invoking](https://docs.tuya.com/cn/cloudapi/appAPI/index.html) for Tuya Cloud HTTP API interface encapsulation.

## Preparation work

### Register Tuya Developer Account

Go to the [Tuya Smart Development Platform](https://developer.tuya.com) to register a developer account, create products and create function points, etc. Please refer to the [Contact workflow](https://docs.tuya.com/cn/overview/dev-process.html) for details. 

### Obtain the iOS App ID and App Secret.
Go to the development platform -> App management -> Create App -> Obtain iOS `App ID` and `App Secret`-> Initiate SDK

![cmd-markdown-logo](http://images.airtakeapp.com/smart_res/developer_default/sdk_zh.jpeg) 

### Joint debugging mode
- Use the hardware control panel to perform debugging on real devices.
- Use the development platform to simulate device debugging. 

### SDK Demo
SDK Demo is a complete App that includes main processes including login, registration, sharing, network configuration, control, etc. Developer can refer to the Demo codes in the development. [Download Link](https://github.com/TuyaInc/tuyasmart_ios_sdk)

## Integrated SDK

### Use CocoaPods for quick integration (SDK basically supports system version 8.0)

Add the following content in the `Podfile` file.

```ruby
platform :ios, '8.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit", :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git"
end
```

Then run the `pod update` command in the root directory of project.
For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/) It is recommended to update the CocoaPods to the latest version.


### Initiate SDK

Add the following content in the `PrefixHeader.pch` file of the project. 

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Open the `AppDelegate.m` file, and use the `App ID` and `App Secret` obtained from the developer platform in the `[AppDelegate application:didFinishLaunchingWithOptions:]` method to initiate the SDK:


```objc
[[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
```

Now, the preparation is fully completed, and the App development can start immediately.

### Update the old version (please ignore this upgrade if your former development is not based on Tuya Smart SDK.)

Check whether the data for upgrade is needed. The data upgrading is needed to upgrade TuyaSDK to TuyaHomeSDK. The upgrade Version interface shall be invoked for upgrade. 



```objc
if ([TuyaSmartSDK sharedInstance].checkVersionUpgrade) {
    [[TuyaSmartSDK sharedInstance] upgradeVersion:^{
        
    } failure:^(NSError *error) {
        
    }];
}
```



### Requirements for example codes

Unless otherwise specified, all example codes shall be in the implementation files of the `ViewController` class.


```objc
@interface ViewController : UIViewController

@end

@implementation ViewController

// All example codes shall be in here.

@end
```

We agree that the attribute of `prop` in reference like `self.prop` has been properly realized in the `ViewController` Class. For example:


```objc
self.device = [[TuyaSmartDevice alloc] initWithDeviceId:@"your_device_id"];
```

To run it correctly, the `TuyaSmartDevice` attribute has to be added in the `ViewController` Class. 

```objc
@property (nonatomic, strong) TuyaSmartDevice *device;
```

The rest can be done in the same manner:

### Agreement on returning error

In using SDK, the error returned from interface can be obtained by using the` error.localizedDescription`.


```objc
[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
	NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    // Output details of error
	NSLog(@"error message: %@", error.localizedDescription);
}];
```

### Set common parameter
Pass public parameters to SDK. Currently, `latitude` and `longitude` are supported.
If you need to collect position information of device, you need to report the latitude and longitude. 


```objc 
[[TuyaSmartSDK sharedInstance] setValue:<#latitude#> forKey:@"latitude"];
[[TuyaSmartSDK sharedInstance] setValue:<#longitude#> forKey:@"longitude"];
```

## User management

Tuya Cloud supports various kinds of user systems such as mobile phone, email and UID. Mobile phone supports verification code login and password login. The registration and login of each user system will be separately described later. 

The `countryCode` parameter (country code) needs to be provided in the registration and login method for region selection of Tuya Cloud. Data of all available regions is independent. The Chinese Mainland account `(country code: 86)` cannot be used in the `USA (country code: 1)`. The Chinese Mainland account does not exist in the USA region.

For details about available region, please refer to the [Tuya Cloud-Available Region](https://docs.tuya.com/cn/cloudapi/api/cloudapi/)

All functions of user are realized by using the `TuyaSmartUser` Class (singleton).

### User Registration

_Note: after the registration method is successfully invoked, all functions of SDK can be normally used. Successful registration means successful login, and the login method does not need to be invoked again._

#### Registration with mobile phone

Registration with mobile phone takes two steps:


- Send the verification code to mobile phone.

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:1 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

- Use the verification code for registration after it is received on the mobile phone.

```objc
- (void)registerByPhone {
	[[TuyaSmartUser sharedInstance] registerByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" code:@"verify_code" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

#### Registration with email (do not need the verification code)

The verification code is not required in registration with email.

```objc
- (void)registerByEmail {
	[[TuyaSmartUser sharedInstance] registerByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

#### Registration with email 2.0 (verification code is required.)

Registration with email takes two steps:

- Send the verification code to an email.

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:@"country_code" email:@"email" success:^{
                NSLog(@"sendVerifyCode success");
            } failure:^(NSError *error) {
                NSLog(@"sendVerifyCode failure: %@", error);
            }];
}
```

- Use the verification code for registration after it is received in the email.

```objc
- (void)registerByEmail {
	    [[TuyaSmartUser sharedInstance] registerByEmail:@"country_code" email:@"email" password:@"password" code:@"verify_code" success:^{
        NSLog(@"register success");
    } failure:^(NSError *error) {
        NSLog(@"register failure: %@", error);
    }];
}
```

### User Login

After the user login interface is successfully invoked, the SDK will save the user session in local files, and when the App is started again, the login will be bypassed. 
The session will become invalid if it is not used for a long time, therefore the notice to expired sessions has to be handled, and the user will be notified to log in again. See [Handling of Expired Session](#session-invalid)


#### Login of mobile phone

Mobile phones has two login modes: verification code login (direct login without registration) and password login (registration is required).

##### Verification code login (direct login without registration) 

The process of verification code login with mobile phone is similar to that of registration on mobile phone .

- Send verification code:

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

- Login:

```objc
- (void)loginByPhoneAndCode {
	[[TuyaSmartUser sharedInstance] login:@"your_country_code" phoneNumber:@"your_phone_number" code:@"verify_code" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

#### Password login (registration is required)

```objc
- (void)loginByPhoneAndPassword {
	[[TuyaSmartUser sharedInstance] loginByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

#### Email login

```objc
- (void)loginByEmail {
	[[TuyaSmartUser sharedInstance] loginByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```


### Third Party Login

User needs to configure corresponding `AppID` and `AppSecret` in the `Tuya developer platform` – `App development` – `Third-party login`. The client shall be developed according to requirements of all platforms. After corresponding code is obtained, relevant login interface of tuyaSDK shall be invoked. 

#### Login on Wechat
```objc
- (void)loginByWechat {
  	/**
	 *  Login on Wechat
	 *
	 *  @param countryCode Country code
	 *  @param code The code obtained from login authorized by Wechat.
	 *  @param success Callback of successful operation.
	 *  @param failure Callback of failed operation.
	 */
    [[TuyaSmartUser sharedInstance] loginByWechat:@"your_country_code" code:@"wechat_code" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
    }];
}

```

#### Login on QQ
```objc
- (void)loginByQQ {
    /**
	 *  QQ登录
	 *
	 *  @param countryCode 国家区号
	 *  @param userId QQ授权登录获取的userId
	 *  @param accessToken QQ授权登录获取的accessToken
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByQQ:@"your_country_code" openId:@"qq_open_id" accessToken:@"access_token" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
 
}

```


#### Login on Facebook 
```objc
- (void)loginByFacebook {
	/**
	 *  facebook登录
	 *
	 *  @param countryCode 国家区号
	 *  @param token facebook授权登录获取的token
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByFacebook:@"your_country_code" token:@"facebook_token" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
}

```


#### Login by Twitter 
```objc

- (void)loginByTwitter {
	/**
	 *  twitter登录
	 *
	 *  @param countryCode 国家区号
	 *  @param key twitter授权登录获取的key
	 *  @param secret twitter授权登录获取的secret
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByTwitter:@"your_country_code" key:@"twitter_key" secret:@"twitter_secret" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
   
}
```

### 4.3 Resetting Password by User

#### Resetting Password by Using Mobile Phone

The process of resetting password by using mobile phone is similar to that of registration with mobile phone. 

- Send verification code:

```objc
- (void)sendVerifyCode {
	[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:2 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

- Reset password:

```objc
- (void)resetPasswordByPhone {
	[TuyaSmartUser sharedInstance] resetPasswordByPhone:@"your_country_code" phoneNumber:@"your_phone_number" newPassword:@"your_password" code:@"verify_code" success:^{
		NSLog(@"resetPasswordByPhone success");
	} failure:^(NSError *error) {
		NSLog(@"resetPasswordByPhone failure: %@", error);
	}];
}
```

#### Reset email password

Resetting password by using email takes two steps:

- Send the verification code to an email.

```objc
- (void)sendVerifyCodeByEmail {
	[TuyaSmartUser sharedInstance] sendVerifyCodeByEmail:@"your_country_code" email:@"your_email" success:^{
		NSLog(@"sendVerifyCodeByEmail success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCodeByEmail failure: %@", error);
	}];
}
```

- Use the verification code to reset password after the verification code is received.

```objc
- (void)resetPasswordByEmail {
	[TuyaSmartUser sharedInstance] resetPasswordByEmail:@"your_country_code" email:@"your_email" newPassword:@"your_password" code:@"verify_code" success:^{
		NSLog(@"resetPasswordByEmail success");
	} failure:^(NSError *error) {
		NSLog(@"resetPasswordByEmail failure: %@", error);
	}];
}
```



### Modify nickname

```objc
- (void)modifyNickname:(NSString *)nickname {
	[[TuyaSmartUser sharedInstance] updateNickname:nickname success:^{
		NSLog(@"updateNickname success");
	} failure:^(NSError *error) {
		NSLog(@"updateNickname failure: %@", error);
	}];
}
```

### Logout

```objc
- (void)loginOut {
	[TuyaSmartUser sharedInstance] loginOut:^{
		NSLog(@"logOut success");
	} failure:^(NSError *error) {
		NSLog(@"logOut failure: %@", error);
	}];
}
```

### Disable account (deregister user)
After one week, the account will be permanently disabled, and all information in the account will be deleted. If you log in to the account again before it is permanently disabled, your deregistration will be canceled.


```objc
- (void)cancelAccount {
	[TuyaSmartUser sharedInstance] cancelAccount:^{
		NSLog(@"cancel account success");
	} failure:^(NSError *error) {
		NSLog(@"cancel account failure: %@", error);
	}];
}
```

### <span id='session-invalid'>Handling of Expired Session</span>

If you have not logged in to your account for a long time, the session expiration error will be returned when you access the server interface. You have to monitor the notification of the 	`TuyaSmartUserNotificationUserSessionInvalid` and log in to the account again after the login page is displayed.


```objc

- (void)loadNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)sessionInvalid {
	if ([[TuyaSmartUser sharedInstance] isLogin]) {
		NSLog(@"sessionInvalid");
		// 注销用户
		[[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
		
		//跳转至登录页面
		MyLoginViewController *vc = [[MyLoginViewController alloc] init];
		self.window.rootViewController = vc;
	    [self.window makeKeyAndVisible];
	}
}
```

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

## Home information management

<!-- 主要功能：用来获取和修改，解散家庭。获取，添加和删除家庭的成员。新增，解散房间，房间进行排序。

单个家庭信息管理相关的所有功能对应`TuyaSmartHome`类，需要使用家庭Id进行初始化。错误的家庭Id可能会导致初始化失败，返回`nil`。初始化 home 对象之后需要获取家庭的详情接口（getHomeDetailWithSuccess:failure:），home 实例对象中的属性 homeModel,roomList,deviceList,groupList 才有数据。 -->

Main function: it is used to obtain, change and dismiss a home. Obtain, add and delete member of a home. Add, dismiss and remove room.
The home ID needs to be used to initiate all TuyaSmartHome classes related to all functions for home information management. Wrong home ID may cause initiation failure, and the nil will be returned. 


### Callback of information change of home

After the `TuyaSmartHomeDelegate` delegate protocol is realized, user can proceed operations in the home information change. 

```objc
- (void)initHome {
    self.home = [TuyaSmartHome homeWithHomeId:homeId];
    self.home.delegate = self;
}

#pragma mark - TuyaSmartHomeDelegate

//Update information of home, such as name.
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self reload];
}

// The change of relation between home and room.
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home {
    [self reload];
}

// Received change of shared device list.
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
    [self reload];
}

// room information change, such as name.
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

// The change of relation between  room and devices and group. 
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room {
    [self reload];
}

//Add device
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self reload];
}

//Remove Device
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self reload];
}

//Update information of device, such as name.
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self reload];
}

//Update dp data of device.
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self reload];
}

// Add group.
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self reload];
}

// Momove group.
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reload];
}

//Update information of group, such as name.
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reload];
}
```

### Obtain information of home. 

```objc
- (void)getHomeDetailInfo {
	
	[self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        // homeModel home information
        NSLog(@"get home detail success");
    } failure:^(NSError *error) {
        NSLog(@"get home detail failure: %@", error);
    }];
}
```

### Update home information

```objc
- (void)updateHomeInfo {
    [self.home updateHomeInfoWithName:@"new_home_name" geoName:@"city_name" latitude:lat longitude:lon success:^{
        NSLog(@"update home info success");
    } failure:^(NSError *error) {
        NSLog(@"update home info failure: %@", error);
    }];
}

```

### Dismiss home

```objc
- (void)dismissHome {
	
	[self.home dismissHomeWithSuccess:^() {
        NSLog(@"dismiss home success");
    } failure:^(NSError *error) {
        NSLog(@"dismiss home failure: %@", error);
    }];
}
```


### Add room

```objc
- (void)addHomeRoom {
    [self.home addHomeRoomWithName:@"room_name" success:^{
        NSLog(@"add room success");
    } failure:^(NSError *error) {
        NSLog(@"add room failure: %@", error);
    }];
}
```

### Remove room

```objc
- (void)removeHomeRoom {
    [self.home removeHomeRoomWithRoomId:roomId success:^{
        NSLog(@"remove room success");
    } failure:^(NSError *error) {
        NSLog(@"remove room failure: %@", error);
    }];
}
```

### Sort room

```objc
- (void)sortHomeRoom {
    [self.home sortRoomList:(NSArray<TuyaSmartRoomModel *> *) success:^{
        NSLog(@"sort room success");
    } failure:^(NSError *error) {
        NSLog(@"sort room failure: %@", error);
    }];   
}
```



## Room information management

The roomId needs to be used to initiate all `TuyaSmartRoom` classes related to all functions for room information management. Wrong roomId may cause initiation failure, and the `nil` will be returned.

### Update room name

```objc
- (void)updateRoomName {
    [self.room updateRoomName:@"new_room_name" success:^{
        NSLog(@"update room name success");
    } failure:^(NSError *error) {
        NSLog(@"update room name failure: %@", error);
    }];
}
```

### Add device to a room

```objc
- (void)addDevice {
    [self.room addDeviceWithDeviceId:@"devId" success:^{
        NSLog(@"add device to room success");
    } failure:^(NSError *error) {
        NSLog(@"add device to room failure: %@", error);
    }];
}
```

### Remove device from a room

```objc
- (void)removeDevice {
    [self.room removeDeviceWithDeviceId:@"devId" success:^{
        NSLog(@"remove device from room success");
    } failure:^(NSError *error) {
        NSLog(@"remove device from room failure: %@", error);
    }];
}
```

### Add group in a room

```objc
- (void)addGroup {
    [self.room addGroupWithGroupId:@"groupId" success:^{
        NSLog(@"add group to room success");
    } failure:^(NSError *error) {
        NSLog(@"add group to room failure: %@", error);
    }];
}
```

### Remove group in a room

```objc
- (void)removeGroup {
    [self.room removeGroupWithGroupId:@"groupId" success:^{
        NSLog(@"remove group from room success");
    } failure:^(NSError *error) {
        NSLog(@"remove group from room failure: %@", error);
    }];
}
```

### Change relation between room and group and devices in batches.

```objc
- (void)saveBatchRoomRelation {
    [self.room saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList success:^{
        NSLog(@"save batch room relation success");
    } failure:^(NSError *error) {
        NSLog(@"save batch room relation failure: %@", error);
    }];
}
```


## Network Configuration

The Tuya hardware module supports two network configuration modes, namely, quick connection mode (TLink, it is referred to as the EZ mode) and hotspot mode (AP mode). The quick connection mode features convenient operation. It is recommended to use the hotspot mode as the backup in case the quick connection mode fails. The wired network configuration is used in Zigbee, and no Wifi configuration information needs to be entered. 

**Process of EZ mode network configuration:**

Connect mobile phone to the Wifi of router -> Switch to the EZ mode -> Start network configuration (send configuration data) -> The device receives the configuration data -> The device is connected to the Wifi of router -> Activate the device -> Network configuration succeeds.

**Process of AP mode network configuration**

Switch to the AP mode -> Connect the hotspot device -> Start network configuration (send configuration data) -> The device receives the configuration data -> Device turns off hotspot automatically-> The device is connected to the Wifi of router -> Activate the device -> Network configuration succeeds.

All functions related to the network configuration are realized by using the `TuyaSmartActivator` Class (singleton).

**Wired network configuration of zigbee**

Reset zigbee gateway -> connect mobile phone to the same hotspot of the gateway -> mobile phone sends the activation instruction -> device receives the activation data -> activate the device -> network configuration succeeds

### Preparation

Before the EZ/AP mode network configuration, the SDK needs to obtain the network configuration Token from the Tuya Cloud. The term of validity of Token is 5 minutes, and the Token become invalid once the network configuration succeeds. A new Token has to be obtained if you have to reconfigure network. 


```
- (void)getToken {
	[[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
		NSLog(@"getToken success: %@", token);
		// TODO: startConfigWiFi
	} failure:^(NSError *error) {
		NSLog(@"getToken failure: %@", error.localizedDescription);
	}];
}
```

### Start network configuration.

EZ mode network configuration:

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// Set the delegate of TuyaSmartActivator, and realize the delegate method.
	[TuyaSmartActivator sharedInstance].delegate = self;
	
	// Start network configuration.
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeEZ ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
	
	if (!error && deviceModel) {
		//Network configuration succeeds.
    }
    
    if (error) {
        //Network configuration fails.
    }	
}

```


The AP mode network configuration is the same to the EZ mode network configuration. You just need to change the first parameter of the `[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]` to TYActivatorModeAP. But the `ssid` and `password` needs to be the name and password of router hotspot instead of the device hotspot.

### Wired network configuration of zigbee

```objc
- (void)startConfigWiFiToken:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;
	
	// 开始配网
	[[TuyaSmartActivator sharedInstance] startConfigWiFiWithToken:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
	
	if (!error && deviceModel) {
		//配网成功
    }
    
    if (error) {
        //配网失败
    }	

}

```

### Stop network configuration.

The App will continuously broadcast the network configuration information until the network configuration succeeds or the timeout is reached once the network configuration starts. The `[TuyaSmartActivator stopConfigWiFi]` method has to be invoked if you need to cancel the network configuration or the network configuration is completed. 

```objc
- (void)stopConfigWifi {
	[TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}
```


### Activate the ZigBee sub-device

The `stopActiveSubDeviceWithGwId` method has to be invoked if you need to cancel the network configuration or the network configuration is completed.

```objc
- (void)activeSubDevice {

	[[TuyaSmartActivator sharedInstance] activeSubDeviceWithGwId:@"your_device_id" success:^{
		NSLog(@"active sub device success");
	} failure:^(NSError *error) {
		NSLog(@"active sub device failure: %@", error);
	}];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    
    if (deviceModel) {
        //配网成功,zigbee子设备没有做超时失败处理
    }   
}
```

### Stop activating the ZigBee sub-device

```objc
- (void)stopActiveSubDevice {
	[[TuyaSmartActivator sharedInstance] stopActiveSubDeviceWithGwId:@"your_device_id"];
}
```


## Device control

The device ID needs to be used to initiate all `TuyaSmartDevice` classes related to all functions for device control. Wrong device Id may cause initiation failure, and the `nil` will be returned.


### Update device information

#### Update single device information

```objc
- (void)updateDeviceInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	
	__weak typeof(self) weakSelf = self;
	[self.device syncWithCloud:^{
		NSLog(@"syncWithCloud success");
		NSLog(@"deviceModel: %@", weakSelf.device.deviceModel);
	} failure:^{
		NSLog(@"syncWithCloud failure");
	}];
}
```


### Functions of device


The `dps` (`NSDictionary` type) attribute of the `TuyaSmartDeviceModel` class defines the state of the device, and the state is called data point (DP) or function point.
Each `key` in the `dps` dictionary refers to a `dpId` of a function point, and `Value` refers to the `dpValue` of a function point. The `dpValue` is the value of the function point. 
Refer to the functions of product in the [Tuya developer platform](https://developer.tuya.com/) for definition of function points of products. See the following figure. 

![功能点](./images/ios_dp_sample.jpeg)


The control instructions shall be sent in the format given below:

`{"<dpId>":"<dpValue>"}`

According to the definition of function points of the product in the back end, the example codes are as follows. 

```objc
- (void)publishDps {
    // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    
    NSDictionary *dps;
	//设置dpId为1的布尔型功能点示例 作用:开关打开 
	dps = @{@"1": @(YES)};
	
	//设置dpId为4的字符串型功能点示例 作用:设置RGB颜色为ff5500
	dps = @{@"4": @"ff5500"};

	//设置dpId为5的枚举型功能点示例 作用:设置档位为2档
	dps = @{@"5": @"2"};

	//设置dpId为6的数值型功能点示例 作用:设置温度为20°
	dps = @{@"6": @(20)};
	
	//设置dpId为15的透传型(byte数组)功能点示例 作用:透传红外数据为1122
	dps = @{@"15": @"1122"};
	
	//多个功能合并发送
	dps = @{@"1": @(YES), @"4": @(ff5500)};
	
	[self.device publishDps:dps success:^{
		NSLog(@"publishDps success");
		
		//下发成功，状态上报通过 deviceDpsUpdate方法 回调
		
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
	
	
}
```
##### Precautions:
- Special attention shall be paid to the type of data in sending the control commands.  For example, the data type of function points shall be value, and the `@{@"2": @(25)}` instead of `@{@"2": @"25"}` shall be sent for the control command. 
- In the transparent transmission, the byte string shall be the string format, and all letters shall be in the lower case, and the string must have even bits.  The correct format shall be: `@{@"1": @"011f"}` instead of `@{@"1": @"11f"}`


For more concepts of function points, please refer to the [QuickStart-Related Concepts of Function Points](https://docs.tuya.com/cn/creatproduct/#_7)

#### Update device status

After the `TuyaSmartDeviceDelegate` delegate protocol is realized, user can update the UI of the App device control in the callback of device status change. 


```objc
- (void)initDevice {
	self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
	NSLog(@"deviceDpsUpdate: %@", dps);
	// TODO: 刷新界面UI
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
	//当前设备信息更新 比如 设备名、设备在线状态等
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
	//当前设备被移除
}

```

### Modify the device name

```objc
- (void)modifyDeviceName:(NSString *)mame {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	
	[self.device updateName:name success:^{
		NSLog(@"updateName success");
	} failure:^(NSError *error) {
		NSLog(@"updateName failure: %@", error);
	}];
}
```

### Remove device

After a device is removed, it will be in the to-be-network-configured status (quick connection mode).

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	
	[self.device remove:^{
		NSLog(@"remove success");
	} failure:^(NSError *error) {
		NSLog(@"remove failure: %@", error);
	}];
}
```

### Obtain Wifi signal strength of device

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    // self.device.delegate = self;
	
	[self.device getWifiSignalStrengthWithSuccess:^{
		NSLog(@"get wifi signal strength success");
	} failure:^(NSError *error) {
		NSLog(@"get wifi signal strength failure: %@", error);
	}];
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal {
    NSLog(@" signal : %@", signal);
}
```

### Obtain the sub-device list of a gateway

```objc
- (void)getSubDeviceList {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	
	[self.device getSubDeviceListFromCloudWithSuccess:^(NSArray<TuyaSmartDeviceModel *> *subDeviceList) {
        NSLog(@"get sub device list success");
    } failure:^(NSError *error) {
        NSLog(@"get sub device list failure: %@", error);
    }];
}
```

### Firmware upgrade

**Firmware upgrade process:**

Obtain device upgrade information -> send module upgrade instructions -> module upgrade succeeds -> send upgrade instructions to the device control module -> the upgrade of device control module succeeds 


#### Obtain device upgrade information:

```objc
- (void)getFirmwareUpgradeInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	
	[self.device getFirmwareUpgradeInfo:^(NSArray<TuyaSmartFirmwareUpgradeModel *> *upgradeModelList) {
		NSLog(@"getFirmwareUpgradeInfo success");
	} failure:^(NSError *error) {
		NSLog(@"getFirmwareUpgradeInfo failure: %@", error);
	}];
}
```

#### Send upgrade instruction:

```objc
- (void)upgradeFirmware {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	// 设备类型type 从获取设备升级信息接口 getFirmwareUpgradeInfo 返回的类型
	// TuyaSmartFirmwareUpgradeModel - type

	[self.device upgradeFirmware:type success:^{
		NSLog(@"upgradeFirmware success"); 
	} failure:^(NSError *error) {
		NSLog(@"upgradeFirmware failure: %@", error); 
	}];
}
```


#### Callback interface: 
```objc
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级成功
}

- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级失败
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
	//固件升级的进度
}

```

## Shared devices

Two sharing modes are provided. 
- Home member based sharing. If you want share all your devices with you families. You can set them to the `TuyaSmartHomeMember` of the home `TuyaSmartHome` so that they can share your devices `TuyaSmartDevice`. Then all members of your home have the permission to control your devices. If one of your home members is set to be the administrator, he will have all permissions to all devices in your home. If your home member is not the administrator, he will only be granted the control permission of devices. 
- Device-based sharing. Sometimes, you need to share some devices with your families, and they will solely have control permission to devices you have shared and cannot change names, remove devices, perform firmware upgrade and restore factory setting, etc. but send device control instructions and obtain status updating. 

### Share with home members 

All functions related to the share with home members are realized by using the `TuyaSmartHomeMember` Class.

#### Add home member

```objc
- (void)addShare {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember addHomeMemberWithHomeId:homeId countryCode:@"your_country_code" account:@"account" name:@"name" isAdmin:YES success:^{
        NSLog(@"addNewMember success");
    } failure:^(NSError *error) {
        NSLog(@"addNewMember failure: %@", error);
    }];
}
```

####  Obtain home member list


```objc
- (void)initMemberList {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember getHomeMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartHomeMemberModel *> *memberList) {
        NSLog(@"getMemberList success: %@", memberList);
    } failure:^(NSError *error) {
        NSLog(@"getMemberList failure");
    }];
}
```


#### Change member name and administrator identity

```objc
- (void)modifyMemberName:(TuyaSmartMemberModel *)memberModel name:(NSString *)name {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember updateHomeMemberNameWithMemberId:memberModel.memberId name:name isAdmin:YES success:^{
        NSLog(@"modifyMemberName success");
    } failure:^(NSError *error) {
        NSLog(@"modifyMemberName failure: %@", error);
    }];
}
```

#### Remove home member


```objc
- (void)removeMember:(TuyaSmartMemberModel *)memberModel {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember removeHomeMemberWithMemberId:memberModel.memberId success:^{
        NSLog(@"removeMember success");
    } failure:^(NSError *error) {
        NSLog(@"removeMember failure: %@", error);
    }];
}
```


### Share devices (sharing based on device dimensions)

All functions related to the device sharing are realized by using the `TuyaSmartHomeDeviceShare` Class.

#### Add sharing


```objc

- (void)addMemberShare {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
	
    [self.deviceShare addShareWithHomeId:homeId countryCode:@"your_country_code" userAccount:@"user_account" devIds:(NSArray<NSString *> *) success:^(TuyaSmartShareMemberModel *model) {
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
	
```

#### Add sharing (add device for sharing)

```objc

- (void)addMemberShare {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
	
    [self.deviceShare addShareWithMemberId:memberId devIds:(NSArray<NSString *> *) success:^{
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
	
```


#### Obtain share member list

Obtain all active sharer user lists

```objc

- (void)getShareMemberList {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	[self.deviceShare getShareMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartShareMemberModel *> *list) {
	    
		NSLog(@"getShareMemberList success");
	
	} failure:^(NSError *error) {
	    
		NSLog(@"getShareMemberList failure: %@", error);

	}];
	
}
	
```

Obtain the list of all users that have received the shared devices.

```objc

- (void)getReceiveMemberList {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	[self.deviceShare getReceiveMemberListWithSuccess:^(NSArray<TuyaSmartShareMemberModel *> *list) {
	    
		NSLog(@"getReceiveMemberList success");
	
	} failure:^(NSError *error) {
	    
		NSLog(@"getReceiveMemberList failure: %@", error);

	}];
    
}
```

#### Obtain the shared data

Obtain the shared data of each active sharer

```objc

- (void)getShareMemberDetail {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getShareMemberDetailWithMemberId:memberId success:^(TuyaSmartShareMemberDetailModel *model) {
    
    	NSLog(@"getShareMemberDetail success");
        
    } failure:^(NSError *error) {

    	NSLog(@"getShareMemberDetail failure: %@", error);

    }];
    
}
```


Obtain the shared data received by a device

```objc

- (void)getReceiveMemberDetail {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getReceiveMemberDetailWithMemberId:memberId success:^(TuyaSmartReceiveMemberDetailModel *model) {
    
    	NSLog(@"getReceiveMemberDetail success");
        
    } failure:^(NSError *error) {

    	NSLog(@"getReceiveMemberDetail failure: %@", error);

    }];
    
}
```

#### Remove memeber

Delete active sharer

```objc

- (void)removeShareMember {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeShareMemberWithMemberId:memberId success:^{
        
    	NSLog(@"removeShareMember success");

    } failure:^(NSError *error) {
    
    	NSLog(@"removeShareMember failure: %@", error);

    }];
    
}
     
```


Remove member that receives the sharing

```objc

- (void)removeReceiveMember {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeReceiveShareMemberWithMemberId:memberId success:^{
        
    	NSLog(@"removeReceiveMember success");

    } failure:^(NSError *error) {
    
    	NSLog(@"removeReceiveMember failure: %@", error);

    }];
    
} 
```

#### Modify nickname

Modify nickname of active sharer

```objc

- (void)updateShareMemberName {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare renameShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
    	NSLog(@"updateShareMemberName success");
    	
    } failure:^(NSError *error) {
        
    	NSLog(@"updateShareMemberName failure: %@", error);

    }];
     
```

Modify nickname of the member that receives the sharing

```objc

- (void)updateReceiveMemberName {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare renameReceiveShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
    	NSLog(@"updateReceiveMemberName success");
    	
    } failure:^(NSError *error) {
        
    	NSLog(@"updateReceiveMemberName failure: %@", error);

    }];
     
}
```

#### Share device

Add device to be shared

```objc

- (void)addDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare addDeviceShareWithHomeId:homeId countryCode:@"country_code" userAccount:@"user_account" devId:@"dev_id" success:^(TuyaSmartShareMemberModel *model) {
        
    	NSLog(@"addDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"addDeviceShare failure: %@", error);
        
    }];
    
}
     
```


Remove device sharing

```objc

- (void)removeDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeDeviceShareWithMemberId:memberId devId:@"dev_id" success:^{
        
    	NSLog(@"removeDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
     
 }
```


Remove the received device for sharing

```objc

- (void)removeDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeReceiveDeviceShareWithDevId:@"dev_id" success:^{
        
    	NSLog(@"removeDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
    
}
     
```


#### Obtain device-sharing member list

```objc

- (void)getDeviceShareMemberList {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getDeviceShareMemberListWithDevId:@"dev_id" success:^(NSArray<TuyaSmartShareMemberModel *> *list) {
        
        NSLog(@"getDeviceShareMemberList success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"getDeviceShareMemberList failure: %@", error);
	
    }];
    
}
         
```

#### Obtain device sharing information

```objc

- (void)getShareInfo {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	 [self.deviceShare getShareInfoWithDevId:@"dev_id" success:^(TuyaSmartReceivedShareUserModel *model) {
	         
        NSLog(@"get shareInfo success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"get shareInfo failure: %@", error);
	
    }];
	 
}
         
```



## Timer task

The design idea is given in the following figure:

![Timer](./images/ios-sdk-timer.jpg)
All functions of timer task are realized by using the `TuyaSmartUser` Class.

*Note: loops: @"0000000", 0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively.*

### Add timer task

Add a timer to the required task specified by a device.

```objc
- (void)addTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	
	[self.timer addTimerWithTask:@"timer_task_name" loops:@"1000000" devId:@"device_id" time:@"18:00" dps:dps timeZone:@"+08:00" success:^{
		NSLog(@"addTimerWithTask success");
	} failure:^(NSError *error) {
		NSLog(@"addTimerWithTask failure: %@", error);
	}];
}
```

### Obtain status of timer task

Obtain all task modules of a specified device.

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer getTimerTaskStatusWithDeviceId:@"device_id" success:^(NSArray<TPTimerTaskModel *> *list) {
		NSLog(@"getTimer success %@:", list);
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

### Update status of timer task

Update the status of a designated task specified by a device. 0 denotes off, and 1 denotes on. 

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer updateTimerTaskStatusWithTask:@"timer_task_name" devId:@"device_id" status:1 success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

### Update the status of timer

Update the status of a designated timer specified by a device. 0 denotes off, and 1 denotes on.

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer updateTimerStatusWithTask:@"timer_task_name" devId:@"device_id" timerId:@"timer_id" status:1 success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

### Remove timer

Remove the timer of a task specified by a device. 

```objc
- (void)removeTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer removeTimerWithTask:@"timer_task_name" devId:@"device_id" timerId:@"timer_id" success:^{
		NSLog(@"removeTimer success");
	} failure:^(NSError *error) {
		NSLog(@"removeTimer failure: %@", error);
	}];
}
```

### Update timer

Update the timer of a task specified by a device.

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	
	[self.timer updateTimerWithTask:@"timer_task_name" loops:@"1000000" devId:@"device_id" timerId:@"timer_id" time:@"18:00" dps:dps timeZone:@"+08:00" success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

### Obtain all timers of timer task

Obtain all timer modules of task required by a device.

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer getTimerWithTask:@"timer_task_name" devId:@"device_id" success:^(NSArray<TPTimerModel *> *list) {
		NSLog(@"getTimer success %@:", list); 
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

### Obtain all timers of all timer tasks

Obtain all timer modules of task required by a device.

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer getAllTimerWithDeviceId:@"device_id" success:^(NSDictionary *dict) {
		NSLog(@"getTimer success %@:", list); 
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

## Group management

The Tuya Cloud supports the group management system. User can create group, change group name, manage devices of group, manage multiple devices via the group and dismiss group.

All functions of group are realized by using the `TuyaSmartGroup` class, and all functions need to be initiated by using the group Id. Wrong group Id may cause initiation failure, and the `nil` will be returned.


### Create a group

```objc
- (void)createNewGroup {
    
    [TuyaSmartGroup createGroupWithName:@"your_group_name" productId:@"your_group_product_id" homeId:homeId devIdList:(NSArray<NSString *> *)selectedDevIdList success:^(TuyaSmartGroup *group) {
        NSLog(@"create new group success %@:", group); 
    } failure:^(NSError *error) {
        NSLog(@"create new group failure");
    }];
}
```

### Obtain device list of group

Obtain the device list of product when the group is not created.

```objc
- (void)getGroupDevList {
    
    [TuyaSmartGroup getDevList:@"your_group_product_id" homeId:homeId success:^(NSArray<TuyaSmartGroupDevListModel *> *list) {
        NSLog(@"get group dev list success %@:", list); 
    } failure:^(NSError *error) {
        NSLog(@"get group dev list failure");
    }];
}
```

Obtain the device list of a group when the group is created.

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

### Send dp command of a group

```objc
- (void)publishDps {
//    self.smartGroup = [TuyaSmartGroup groupWithGroupId:@"your_group_id"];
	
	NSDictionary *dps = @{@"1": @(YES)};
	[self.smartGroup publishDps:dps success:^{
		NSLog(@"publishDps success");
	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];
```

### Modify the group name

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

### Modify group device list

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
### Dismiss group

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


### Callback interface

Callback and data updating after the group sends DP.

```objc

#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps {
	//可以在这里刷新群组操作面板的UI
}

```

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

### Obtain scene list

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
### Obtain condition list

Obtain condition list. The condition can be temperature, humidity, weather, PM2.5, sunrise and sunset. It shall be noted that the device can also be a condition. The temperature can be in the Celsius system and Fahrenheit, and data shall be uploaded based on needs. 

```objc
- (void)getConditionList {
    [[TuyaSmartSceneManager sharedInstance] getConditionListWithFahrenheit:YES success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
        NSLog(@"get condition list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get condition list failure: %@", error);
    }];
}
```
### Obtain the action device list

When adding tasks, the device list of task shall be obtained. 

```objc
- (void)getActionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get action device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device list failure: %@", error);
	}];
}
```
### Obtain the condition device list

Except for meteorological conditions such as temperature, humidity and weather, etc., the device can also be a condition. The condition device list shall be obtained, and one device that is carrying out some tasks will be used as a condition. 

```objc
- (void)getConditionDeviceList {
	[[TuyaSmartSceneManager sharedInstance] getConditionDeviceListWithHomeId:homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
		NSLog(@"get condition device list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device list failure: %@", error);
	}];
}
```

### Obtain the dp list of action device

When adding or editing scene actions, the user needs to obtain the device dp list based on the deviceId of devices to select a dp function point so as to assign the action to the device. 

```objc
- (void)getActionDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getActionDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get action device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get action device dp list failure: %@", error);
	}];
}
```

### Obtain the dp list of condition device

When selecting scene conditions, the user needs to obtain the device dp list based on the deviceId to select a dp function point so that the operation of the dp function of a device can be used as the condition of the scene.

```objc
- (void)getCondicationDeviceDPList {
	[[TuyaSmartSceneManager sharedInstance] getCondicationDeviceDPList:@"your_device_id" success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
		NSLog(@"get condition device dp list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get condition device dp list failure: %@", error);
	}];
}    
```

### Obtain the city list

When selecting meteorological conditions for scene, user can obtain the city list according to the country code. The user can select the city he is currently in. (Note: city list of some foreign countries may be incomplete temporarily. If you are not in China, it is recommended that you obtain the city information according to the altitude and longitude.)

```objc
- (void)getCityList {
	[[TuyaSmartSceneManager sharedInstance] getCityList:@"your_country_code" success:^(NSArray<TuyaSmartCityModel *> *list) {
		NSLog(@"get city list success:%@", list);
	} failure:^(NSError *error) {
   		NSLog(@"get city list failure: %@", error);    
	}];
}
```

### Obtain the city information according to the altitude and longitude of city

```objc
- (void)getCityInfo {
	[[TuyaSmartSceneManager sharedInstance] getCityInfo:@"your_location_latitude" longitude:@"your_location_longitude" success:^(TuyaSmartCityModel *city) {
		NSLog(@"get city info success:%@", city);
	} failure:^(NSError *error) {
		NSLog(@"get city info failure:%@", error);       
	}];
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

### Sort scene


```objc
- (void) sortScene {
	[[TuyaSmartSceneManager sharedInstance] sortSceneWithHomeId:homeId sceneIdList:(NSArray<NSString *> *) success:^{
        NSLog(@"sort scene success"); 
    } failure:^(NSError *error) {
        NSLog(@"sort scene failure:%@", error);
    }];
}
```

## Message center

All functions related to the message center are realized by using the `TuyaSmartMessage` class. Obtaining message list, deleting messages in batches and checking for message update are supported. 

### Obtain message list

```objc
- (void)getMessageList {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
}
```

### Delete messages

Delete messages in batches. `messgeIdList` denotes the id group of messages to be deleted, and the message id can be attained from the message list. 

```objc
- (void)deleteMessage {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessage:(NSArray <NSString *> *)messgeIdList success:^{
		NSLog(@"delete message success");
    } failure:^(NSError *error) {
    	NSLog(@"delete message failure:%@", error);
    }];
}
```
### Obtain the timestamp of the latest news

The timestamp of the latest news can be compared with that of local latest message. If the former is bigger than the later, a red dot will be displayed to hint the new message. 

```objc
- (void)getMessageMaxTime {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageMaxTime:^(int result) {
		NSLog(@"get message max time success:%d", result);
	} failure:^(NSError *error) {
		NSLog(@"get message max time failure:%@", error);
	}];
}
```

## Feedback

If user intends to submit feedback, he has to select the type of feedback first and fill the feedback content. After submission, a feedback talk will be generated based on the selected type of feedback. User may continue to fill feedback in the session, and the feedback will be displayed in the feedback list of the session. 

All functions related to the feedback will be realized by using the `TuyaSmartFeedback` class. Obtaining feedback talk list, feedback content list in the session and feedback type list and adding feedback are supported. 

### Obtain feedback talk list

Obtain the feedback talk list submitted by user

```objc
- (void)getFeedbackTalkList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackTalkList:^(NSArray<TuyaSmartFeedbackTalkListModel *> *list) {
		NSLog(@"get feedback talk list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback talk list failure:%@", error);
	}];
}
```
### Obtain feedback list

Obtain the feedback content list from the feedback talk. The `hdId` and `hdType` can be attained from the TuyaSmartFeedbackTalkListModel.

```objc
- (void)getFeedbackList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackList:@"your_hdId" hdType:(NSInteger)hdType success:^(NSArray<TuyaSmartFeedbackModel *> *list) {
		NSLog(@"get feedback list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback list failure:%@", error);
	}];
}
```
### Obtain feedback type list
The feedback type can be selected first when adding feedback. 

```objc
- (void)getFeedbackTypeList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackTypeList:^(NSArray<TuyaSmartFeedbackTypeListModel *> *list) {
		NSLog(@"get feedback type list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback type list failure:%@", error);
	}];
}
```
### Add feedback

Add and submit feedback. The `hdId` and `hdType` can be obtained from the `TuyaSmartFeedbackTalkListModel`.

```objc
- (void)addFeedback {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack addFeedback:@"your_feedback_content" hdId:@"your_hdId" hdType:(NSInteger)hdType success:^{
		NSLog(@"add feedback success");
	} failure:^(NSError *error) {
		NSLog(@"add feedback failure:%@", error);
	}];
}
```

## Common interface

Invoke the api interface of server

```objc

- (void)load {
    //self.request = [TuyaSmartRequest alloc] init];

    /**
	 *  请求服务端接口
	 *
	 *  @param apiName	Name of interface
	 *  @param postData parameter value assigned from service
	 *  @param version  No. of interface.
	 *  @param success  Callback of successful operation
	 *  @param failure  Callback of failed operation
	 */
    [self.request requestWithApiName:@"api_name" postData:@"post_data" version:@"api_version" success:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
	
}


```

## Integrate push

For Apps developed by using the Tuya SDK, the Tuya platform supports push function, sending operation push to users and alarm push of products. 

### Configure Xcode

Clock project -> `TARGETS` -> `Capabilities`, and switch on the `Push Notification` switch. The effect is as follows.

![ios-push](./images/ios-push.png)


### Configure the Tuya Developer Platform

Log in to the Tuya Developer Platform -> enter relevant App ->Configure the Push function->Upload the push certificate.

![ios-push-setting](./images/ios-push-setting.png)



### Initialization

Initiate push in the `didFinishLaunchingWithOptions` method. 

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

### Register pushId

Register pushId in Tuya SDK in the `didRegisterForRemoteNotificationsWithDeviceToken`. 

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


### Receive notification

Execute in the delegate method `didReceiveRemoteNotification` when the remote notification is received. 


```objc
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {


}
```

### Send push

#### Add operation push

Tuya Developer Platform -> User operation -> Message center ->Add message

#### Add alarm push

Tuya Developer Platform -> Product -> Extended function ->Set alarm -> Add rules for alarms (apply the push mode)


## FAQ

1. Why are errors reported in running the `pod install`?  
Please confirm that the latest version cocoapod is used. Run the `pod --version` command to check the version of pod, and ensure that the version 1.3.0 or beyond is used. 

2. Why the `“Error Domain=NSURLErrorDomain Code=-999 is canceled”` error is reported when invoking the SDK interface?  
Please conform that the object you request is a global variable, or the it will be released early, for example, `self.feedBack = [[TuyaSmartFeedback alloc] init]`;

3. How to enable the debugging mode and print logs? 
Invoke the following codes: `[[TuyaSmartSDK sharedInstance] setDebugMode:YES];` when the SDK is initiated. 

4. The device do not report the status when the control instruction is sent.  
Please check the data type of function points. For example, the data type of function points shall be value, and the @{@"2": @(25)} instead of @{@"2": @"25"} shall be sent for the control command.

