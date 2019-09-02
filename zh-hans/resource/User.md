## 用户管理

涂鸦云支持多种用户体系：手机、邮箱、UID。其中手机支持验证码登录和密码登录两种方式，每种体系的注册登录会在后面单独介绍。

在注册登录方法中，需要提供`countryCode`参数（国家区号），用于就近选择涂鸦云的可用区。各个可用区的数据是相互独立的，因此在`中国大陆（86）`注册的账号，在`美国(1)`无法使用（用户不存在）。

可用区相关概念请查看：[涂鸦云-可用区](https://docs.tuya.com/cn/cloudapi)

用户相关的所有功能对应`TuyaSmartUser`类（单例）。



### SDK账户升级

如果是 tuyasmart_ios_sdk 开发过的用户，现在需要升级到 tuyasmart_home_ios_sdk，否则忽略账户升级

#### 检查是否需要升级

检查是否需要从 tuyasmart_ios_sdk 升级到 tuyasmart_home_ios_sdk

```
/**
 * 检测是否需要升级数据 从tuyasmart_ios_sdk 升级到 tuyasmart_home_ios_sdk
 * @return BOOL
 */
- (BOOL)checkVersionUpgrade;
```

#### 开始升级

升级成功后，服务端会创建一个默认的家庭

Objc:

```objective-c
/**
 * SDK数据升级
 */
[[TuyaSmartSDK sharedInstance] upgradeVersion:^{
    
} failure:^(NSError *error) {
    
}];
```

Swift:

```swift
/**
 * SDK数据升级
 */
TuyaSmartSDK.sharedInstance()?.upgradeVersion({
            
}, failure: { (e) in
            
})
```



### 手机账号体系

涂鸦智能提供手机验证码登陆体系。

#### 手机密码注册

1. 获取手机验证码

Objc:

```objective-c
/**
 *  发送验证码，用于手机验证码登录/注册，手机密码重置。
 *  @param type 0: 验证码登录, 1: 验证码注册, 2:验证码重设密码
 */
[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:1 success:^{
    NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    NSLog(@"sendVerifyCode failure: %@", error);
}];
```

Swift:

```swift
/**
 *  发送验证码，用于手机验证码登录/注册，手机密码重置。
 *  @param type 0: 验证码登录, 1: 验证码注册, 2:验证码重设密码
 */
TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 1, success: {
    print("sendVerifyCode success")
}, failure: { (error) in
    if let e = error {
        print("sendVerifyCode failure: \(e)")
    }
})
```



2. 注册手机密码账户

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] registerByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" code:@"verify_code" success:^{
    NSLog(@"register success");
} failure:^(NSError *error) {
    NSLog(@"register failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.register(byPhone: "your_country_code", phoneNumber: "your_phone_number", password: "your_password", code: "verify_code", success: {
    print("register success")
}, failure: { (error) in
    if let e = error {
        print("register failure: \(e)")
    }
})
```



#### 手机验证码登录

1. 获取手机验证码

Objc:

```objective-c
/**
 *  发送验证码，用于手机验证码登录/注册，手机密码重置。
 *  @param type 0: 验证码登录, 1: 验证码注册, 2:验证码重设密码
 */
[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
    NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    NSLog(@"sendVerifyCode failure: %@", error);
}];
```

Swift:

```swift
/**
 *  发送验证码，用于手机验证码登录/注册，手机密码重置。
 *  @param type 0: 验证码登录, 1: 验证码注册, 2:验证码重设密码
 */
TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 0, success: {
    print("sendVerifyCode success")
}, failure: { (error) in
    if let e = error {
        print("sendVerifyCode failure: \(e)")
    }
})
```



2. 验证码登录

Objc:


```objective-c
[[TuyaSmartUser sharedInstance] loginWithMobile:@"your_phone_number" countryCode:@"your_country_code" code:@"verify_code" success:^{
		NSLog(@"login success");
} failure:^(NSError *error) {
    NSLog(@"login failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.login(withMobile: "your_phone_number", countryCode: "your_country_code", code: "verify_code", success: {
    print("login success")
}, failure: { (error) in
    if let e = error {
        print("login failure: \(e)")
    }
})
```



#### 手机密码登录

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] loginByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" success:^{
		NSLog(@"login success");
} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.login(byPhone: "your_country_code", phoneNumber: "your_phone_number", password: "your_password", success: {
    print("login success")
}, failure: { (error) in
    if let e = error {
        print("login failure: \(e)")
    }
})
```



### 邮箱账号体系

涂鸦智能提供邮箱密码登陆体系。

#### 邮箱密码注册

1. 获取邮箱验证码

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:@"your_country_code" email:@"your_email" success:^{
  	NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    NSLog(@"sendVerifyCode failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.sendVerifyCode(byRegisterEmail: "your_country_code", email: "your_email", success: {
    print("sendVerifyCode success")
}, failure: { (error) in
    if let e = error {
        print("sendVerifyCode failure: \(e)")
    }
})
```



2. 注册邮箱密码账户

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] registerByEmail:@"your_country_code" email:@"your_email" password:@"your_password" code:@"verify_code" success:^{
    NSLog(@"register success");
} failure:^(NSError *error) {
    NSLog(@"register failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.register(byEmail: "your_country_code", email: "your_email", password: "your_password", code: "verify_code", success: {
    print("register success")
}, failure: { (error) in
    if let e = error {
        print("register failure: \(e)")
    }
})
```



#### 邮箱密码登录

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] loginByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
    NSLog(@"login success");
} failure:^(NSError *error) {
    NSLog(@"login failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.login(byEmail: "your_country_code", email: "your_email", password: "your_password", success: {
    print("login success")
}, failure: { (error) in
    if let e = error {
        print("login failure: \(e)")
    }
})
```



### 用户uid登录体系

#### 用户uid注册

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] registerByUid:@"your_uid" password:@"your_password" countryCode:@"your_country_code" success:^{
    NSLog(@"register success");
} failure:^(NSError *error) {
    NSLog(@"register failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.register(byUid: "your_uid", password: "your_password", countryCode: "your_country_code", success: {
    print("register success")
}, failure: { (error) in
    if let e = error {
        print("register failure: \(e)")
    }
})
```



#### 用户uid登陆

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] loginByUid:@"your_uid" password:@"your_password" countryCode:@"your_country_code" success:^{
    NSLog(@"login success");
} failure:^(NSError *error) {
    NSLog(@"login failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.login(byUid: "your_uid", password: "your_password", countryCode: "your_country_code", success: {
    print("login success")
}, failure: { (error) in
    if let e = error {
        print("login failure: \(e)")
    }
})
```



### 第三方登录

需要在 `涂鸦开发者平台` - `应用开发` - `第三方登录` 配置对应的`AppID`和`AppSecret`;
客户端按照各平台要求进行开发，获取到对应的code之后，调用tuyaSDK对应的登录接口。

#### 微信登录

Objc:

```objc
- (void)loginByWechat {
  	/**
	 *  微信登录
	 *
	 *  @param countryCode 国家区号
	 *  @param code 微信授权登录获取的code
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
        [[TuyaSmartUser sharedInstance] loginByWechat:@"your_country_code" code:@"wechat_code" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
    }];
}

```

Swift:

```swift
func loginByWechat() {
    /**
	 *  微信登录
	 *
	 *  @param countryCode 国家区号
	 *  @param code 微信授权登录获取的code
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    TuyaSmartUser.sharedInstance()?.login(byWechat: "your_country_code", code: "wechat_code", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



#### QQ登录

Objc:

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
    [[TuyaSmartUser sharedInstance] loginByQQ:@"your_country_code" userId:@"qq_open_id" accessToken:@"access_token" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];

}

```

Swift:

```swift
 func loginByQQ() {
     /**
	 *  QQ登录
	 *
	 *  @param countryCode 国家区号
	 *  @param userId QQ授权登录获取的userId
	 *  @param accessToken QQ授权登录获取的accessToken
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    TuyaSmartUser.sharedInstance()?.login(byQQ: "your_country_code", userId: "qq_open_id", accessToken: "access_token", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



#### Facebook登录

Objc:

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

Swift:

```swift
 func loginByFacebook() {
     /**
	 *  facebook登录
	 *
	 *  @param countryCode 国家区号
	 *  @param token facebook授权登录获取的token
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    TuyaSmartUser.sharedInstance()?.login(byFacebook: "your_country_code", token: "facebook_token", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```

#### Twitter登录

Objc:

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

Swift:

```swift
func loginByTwitter() {
    /**
	 *  twitter登录
	 *
	 *  @param countryCode 国家区号
	 *  @param key twitter授权登录获取的key
	 *  @param secret twitter授权登录获取的secret
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    TuyaSmartUser.sharedInstance()?.login(byTwitter: "your_country_code", key: "twitter_key", secret: "twitter_secret", success: {
       	print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



###  用户重置密码

#### 手机号重置密码

手机号重置密码流程和注册流程类似：

- 发送验证码

Objc:

```objc
- (void)sendVerifyCode {
	[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:2 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

Swift:

```swift
func sendVerifyCode() {
    TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 2, success: {
        print("sendVerifyCode success")
    }, failure: { (error) in
        if let e = error {
            print("sendVerifyCode failure: \(e)")
        }
    })
}
```



- 重置密码

Objc:

```objc
- (void)resetPasswordByPhone {
	[TuyaSmartUser sharedInstance] resetPasswordByPhone:@"your_country_code" phoneNumber:@"your_phone_number" newPassword:@"your_password" code:@"verify_code" success:^{
		NSLog(@"resetPasswordByPhone success");
	} failure:^(NSError *error) {
		NSLog(@"resetPasswordByPhone failure: %@", error);
	}];
}
```

Swift:

```swift
func resetPasswordByPhone() {
    TuyaSmartUser.sharedInstance()?.resetPassword(byPhone: "your_country_code", phoneNumber: "your_phone_number", newPassword: "your_password", code: "verify_code", success: {
        print("resetPasswordByPhone success")
    }, failure: { (error) in
        if let e = error {
            print("resetPasswordByPhone failure: \(e)")
        }
    })
}
```



#### 邮箱重置密码

邮箱重置密码需要两个步骤：

- 发送验证码到邮箱

Objc:

```objc
- (void)sendVerifyCodeByEmail {
	[TuyaSmartUser sharedInstance] sendVerifyCodeByEmail:@"your_country_code" email:@"your_email" success:^{
		NSLog(@"sendVerifyCodeByEmail success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCodeByEmail failure: %@", error);
	}];
}
```

Swift:

```swift
func sendVerifyCodeByEmail() {
    TuyaSmartUser.sharedInstance()?.sendVerifyCode(byEmail: "your_country_code", email: "your_email", success: {
        print("sendVerifyCodeByEmail success")
    }, failure: { (error) in
        if let e = error {
            print("sendVerifyCodeByEmail failure: \(e)")
        }
    })
}
```

- 收到验证码后，使用验证码重置密码

Objc:

```objc
- (void)resetPasswordByEmail {
	[TuyaSmartUser sharedInstance] resetPasswordByEmail:@"your_country_code" email:@"your_email" newPassword:@"your_password" code:@"verify_code" success:^{
		NSLog(@"resetPasswordByEmail success");
	} failure:^(NSError *error) {
		NSLog(@"resetPasswordByEmail failure: %@", error);
	}];
}
```

Swift:

```swift
func resetPasswordByEmail() {
    TuyaSmartUser.sharedInstance()?.resetPassword(byEmail: "your_country_code", email: "your_email", newPassword: "your_password", code: "verify_code", success: {
        print("resetPasswordByEmail success")
    }, failure: { (error) in
        if let e = error {
            print("resetPasswordByEmail failure: \(e)")
        }
    })
}
```



### 修改昵称

Objc:

```objc
- (void)modifyNickname:(NSString *)nickname {
	[[TuyaSmartUser sharedInstance] updateNickname:nickname success:^{
		NSLog(@"updateNickname success");
	} failure:^(NSError *error) {
		NSLog(@"updateNickname failure: %@", error);
	}];
}
```

Swift:

```swift
func modifyNickname(_ nickName: String) {
    TuyaSmartUser.sharedInstance()?.updateNickname(nickName, success: {
        print("updateNickname success")
    }, failure: { (error) in
        if let e = error {
            print("updateNickname failure: \(e)")
        }
    })
}
```



### 更新用户时区

Objc:

```objc
- (void)updateTimeZoneId:(NSString *)timeZoneId {
	[[TuyaSmartUser sharedInstance] updateTimeZoneWithTimeZoneId:timeZoneId success:^{
		NSLog(@"update timeZoneId success");
	} failure:^(NSError *error) {
		NSLog(@"update timeZoneId failure: %@", error);
	}];
}
```

Swift:

```swift
func updateTimeZoneId(_ timeZoneId: String) {
    TuyaSmartUser.sharedInstance()?.updateTimeZone(withTimeZoneId: timeZoneId, success: {
        print("update timeZoneId success")
    }, failure: { (error) in
        if let e = error {
            print("update timeZoneId failure: \(e)")
        }
    })
}
```



### 更新用户定位

如果有需要的话，定位信息可以通过以下接口上报：

Objc:

```objc
- (void)updateLocation {
  double latitude = 30.000;
  double longitude = 120.000;
  [[TuyaSmartSDK sharedInstance] updateLatitude:latitude longitude:longitude];
}
```

Swift:

```swift
func updateLocation() {
  TuyaSmartSDK.sharedInstance()?.updataLatitude(latitude, longitude: longitude);
}
```



### 登出

Objc:

```objc
- (void)loginOut {
	[TuyaSmartUser sharedInstance] loginOut:^{
		NSLog(@"logOut success");
	} failure:^(NSError *error) {
		NSLog(@"logOut failure: %@", error);
	}];
}
```

Swift:

```swift
func loginOut() {
    TuyaSmartUser.sharedInstance()?.loginOut({
        print("logOut success")
    }, failure: { (error) in
        if let e = error {
            print("logOut failure: \(e)")
        }
    })
}
```



### 停用账号（注销用户）

一周后账号才会永久停用并删除以下你账户中的所有信息，在此之前重新登录，则你的停用请求将被取消

Objc:

```objc
- (void)cancelAccount {
	[TuyaSmartUser sharedInstance] cancelAccount:^{
		NSLog(@"cancel account success");
	} failure:^(NSError *error) {
		NSLog(@"cancel account failure: %@", error);
	}];
}
```

Swift:

```swift
func cancelAccount() {
    TuyaSmartUser.sharedInstance()?.cancelAccount({
        print("cancel account success")
    }, failure: { (error) in
        if let e = error {
            print("cancel account failure: \(e)")
        }
    })
}
```



### Session过期的处理

长期未登录的账号，在访问服务端接口的时候会返回Session过期的错误，需要监听`TuyaSmartUserNotificationUserSessionInvalid`通知，跳转至登录页面重新登录。

Objc:

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

Swift:

```swift
func loadNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(sessionInvalid), name: NSNotification.Name(rawValue: "TuyaSmartUserNotificationUserSessionInvalid"), object: nil)
}
    
@objc func sessionInvalid() {
    guard TuyaSmartUser.sharedInstance()?.isLogin == true else {
        return
    }
        
    print("sessionInvalid")
    // 注销用户
    TuyaSmartUser.sharedInstance()?.loginOut(nil, failure: nil)
    //跳转至登录页面
}
```

