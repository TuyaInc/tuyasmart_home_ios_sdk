# 用户管理

涂鸦云支持多种用户体系：手机、邮箱、UID。其中手机支持验证码登录和密码登录两种方式，每种体系的注册登录会在后面单独介绍。UID 登录主要用于已经有自己账号体系的场景。

|       类名       |       说明       |
| :--------------: | :--------------: |
|  TuyaSmartUser   | 涂鸦用户相关的类 |



在注册登录方法中，需要提供 `countryCode` 参数（国家区号），用于就近选择涂鸦云的可用区。各个可用区的数据是相互独立的，因此在`中国大陆（86）`注册的账号，在`美国(1)`无法使用（用户不存在）。

可用区相关概念请查看：[涂鸦云-可用区](https://docs.tuya.com/zh/iot/introduction-of-tuya/tuya-smart-cloud-platform-overview?id=K914joiyhhf7r#title-6-%E9%80%8F%E6%9E%90%E6%B6%82%E9%B8%A6%E4%BA%91)

用户相关的所有功能对应 `TuyaSmartUser` 类（单例）。

**`TuyaSmartUser` 数据模型**

| **字段**    | **类型**  | **描述**                                                     |
| ----------- | --------- | ------------------------------------------------------------ |
| headIconUrl | NSString  | 用户头像链接                                                 |
| nickname    | NSString  | 用户昵称                                                     |
| userName    | NSString  | 用户名。如果主账号是手机号，userName 就是手机号。如果主账号是邮箱，userName 就是邮箱 |
| phoneNumber | NSString  | 手机号                                                       |
| email       | NSString  | 邮箱                                                         |
| countryCode | NSString  | 国家码，86：中国，1：美国                                    |
| isLogin     | BOOL      | 登录的状态                                                   |
| regionCode  | NSString  | 当前账号所在的国家区域。AY：中国，AZ：美国，EU：欧洲         |
| timezoneId  | NSString  | 用户时区信息，例如： `Asia/Shanghai`                         |
| tempUnit    | NSInteger | 温度单位。1：`°C`， 2：`°F`                                  |
| snsNickname | NSString  | 第三方账号的昵称                                             |
| regFrom     | TYRegType | 账号注册的类型                                               |




## 手机账号体系

涂鸦智能提供手机验证码登录体系。



### 手机密码注册

手机号密码注册流程分为以下两步：`获取手机验证码` - `注册账号`

**接口说明**

发送验证码，用于手机验证码登录/注册，手机密码重置。

```objective-c
- (void)sendVerifyCode:(NSString *)countryCode
           phoneNumber:(NSString *)phoneNumber
                  type:(NSInteger)type
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| countryCode | 国家码，例如：86                                             |
| phoneNumber | 手机号码                                                     |
| type        | 发送验证码的类型，0:登录验证码，1:注册验证码，2:重置密码验证码 |
| success     | 接口发送成功回调                                             |
| failure     | 接口发送失败回调，error 表示失败原因                         |

**示例代码**

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:1 success:^{
    NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    NSLog(@"sendVerifyCode failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 1, success: {
    print("sendVerifyCode success")
}, failure: { (error) in
    if let e = error {
        print("sendVerifyCode failure: \(e)")
    }
})
```



**接口说明**

注册手机账号

```objective-c
- (void)registerByPhone:(NSString *)countryCode
            phoneNumber:(NSString *)phoneNumber
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                     |
| phoneNumber | 手机号码                             |
| password    | 密码                                 |
| code        | 经过验证码发送接口，收到的验证码     |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



### 手机密码登录

**接口说明**

SDK 提供手机号密码的登录方式

```objective-c
- (void)loginByPhone:(NSString *)countryCode
         phoneNumber:(NSString *)phoneNumber
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| phoneNumber | 手机号码                             |
| password    | 密码     |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



### 手机号重置密码

手机号重置密码流程分为以下两步：获取手机验证码（ API 参考“手机密码注册”的第一个接口） - 重置密码

**接口说明**

手机号重置密码

```objective-c
- (void)resetPasswordByPhone:(NSString *)countryCode
                 phoneNumber:(NSString *)phoneNumber
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                     |
| phoneNumber | 手机号码                             |
| newPassword | 新密码                               |
| code        | 经过验证码发送接口，收到的验证码     |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



### 手机验证码登录

手机号验证码登录流程分为以下两步：获取手机验证码（ API 参考“手机密码注册”的第一个接口） - 验证码登录

**接口说明**

验证码登录

```objective-c
- (void)loginWithMobile:(NSString *)mobile
            countryCode:(NSString *)countryCode
                   code:(NSString *)code
                success:(TYSuccessHandler)success
                failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| mobile      | 手机号码                             |
| countryCode | 国家码，例如：86                     |
| code        | 经过验证码发送接口，收到的验证码     |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



###  验证码验证接口

**接口说明**

验证验证码，用于注册、登录、重设密码 时验证的校验

```objective-c
- (void)checkCodeWithUserName:(NSString *)userName
                       region:(NSString *_Nullable)region
                  countryCode:(NSString *)countryCode
                         code:(NSString *)code
                         type:(NSInteger)type
                      success:(TYSuccessBOOL)success
                      failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| userName    | 手机号或邮箱                                                 |
| region      | 区域，默认填 nil                                             |
| countryCode | 国家码，例如：86                                             |
| code        | 经过验证码发送接口，收到的验证码                             |
| type        | 类型, 1: 注册时验证码验证⽤, 2: 验证码登录时⽤, 3: 重置密码时⽤ |
| success     | 接口发送成功回调                                             |
| failure     | 接口发送失败回调，error 表示失败原因                         |

**示例代码**

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] checkCodeWithUserName:@"email_or_phone_number" region:@"region" countryCode:@"your_country_code" code:@"verify_code" type:1 success:^(BOOL result) {
		if (result) {
				NSLog(@"valid code!");
    } else {
				NSLog(@"invalid code!");
    }
} failure:^(NSError *error) {
		NSLog(@"check code failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.checkCode(withUserName: "email_or_phone_number", region: "region", countryCode: "your_country_code", code: "verify_code", type: type, success: { (result) in
		if result {
				print("valid code!")
		} else {
				print("invalid code!")
		}
}, failure: { (error) in
		if let error = error {
				print("check code failure: \(error)")
		}
})
```



## 邮箱账号体系

涂鸦智能提供手机验证码登录体系。



### 邮箱密码注册

邮箱注册流程分为以下两步：获取邮箱验证码 - 注册邮箱密码账户



**接口说明**

发送验证码，用于邮箱注册

```
- (void)sendVerifyCodeByRegisterEmail:(NSString *)countryCode
                                email:(NSString *)email
                              success:(nullable TYSuccessHandler)success
                              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                     |
| email       | 邮箱                                 |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



**接口说明**

注册邮箱密码账户

```objective-c
- (void)registerByEmail:(NSString *)countryCode
                  email:(NSString *)email
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| email       | 邮箱                                 |
| password    | 密码                                 |
| code    | 经过验证码发送接口，收到的验证码                 |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



### 邮箱密码登录

**接口说明**

SDK提供邮箱密码的登录方式

```objective-c
- (void)loginByEmail:(NSString *)countryCode
               email:(NSString *)email
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                     |
| email       | 手机号码                             |
| password    | 密码                                 |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



### 邮箱重置密码

**接口说明**

邮箱重置密码流程分为以下两步：获取邮箱验证码( API 参考“邮箱密码注册”的第一个接口) - 重置密码

```objective-c
- (void)resetPasswordByEmail:(NSString *)countryCode
                       email:(NSString *)email
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| email       | 邮箱                             |
| newPassword | 新密码                               |
| code        | 经过验证码发送接口，收到的验证码     |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



###  验证码验证接口

**接口说明**

验证验证码，用于注册、登录、重设密码 时验证的校验

```objective-c
- (void)checkCodeWithUserName:(NSString *)userName
                       region:(NSString *_Nullable)region
                  countryCode:(NSString *)countryCode
                         code:(NSString *)code
                         type:(NSInteger)type
                      success:(TYSuccessBOOL)success
                      failure:(TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| userName    | 手机号或邮箱                                                 |
| region      | 区域，默认填 nil                                             |
| countryCode | 国家码，例如：86                                             |
| code        | 经过验证码发送接口，收到的验证码                             |
| type        | 类型, 1: 注册时验证码验证⽤, 2: 验证码登录时⽤, 3: 重置密码时⽤ |
| success     | 接口发送成功回调                                             |
| failure     | 接口发送失败回调，error 表示失败原因                         |

**示例代码**

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] checkCodeWithUserName:@"email_or_phone_number" region:@"region" countryCode:@"your_country_code" code:@"verify_code" type:1 success:^(BOOL result) {
		if (result) {
				NSLog(@"valid code!");
    } else {
				NSLog(@"invalid code!");
    }
} failure:^(NSError *error) {
		NSLog(@"check code failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.checkCode(withUserName: "email_or_phone_number", region: "region", countryCode: "your_country_code", code: "verify_code", type: type, success: { (result) in
		if result {
				print("valid code!")
		} else {
				print("invalid code!")
		}
}, failure: { (error) in
		if let error = error {
				print("check code failure: \(error)")
		}
})
```



## 用户 uid 登录体系

### 用户 uid 注册和登录（已经拥有账号体系）

**接口说明**

注册和登录为一体的接口，如果注册了就自动登录，如果没有注册就自动注册并且登录。

```objective-c
- (void)loginOrRegisterWithCountryCode:(NSString *)countryCode
                                   uid:(NSString *)uid
                              password:(NSString *)password
                            createHome:(BOOL)createHome
                               success:(nullable TYSuccessID)success
                               failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| uid     | 匿名 ID，没有格式要求 |
| password | 密码                               |
| createHome | 是否创建默认家庭                  |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

Objc:

```objective-c
[[TuyaSmartUser sharedInstance] loginOrRegisterWithCountryCode:@"your_country_code" uid:@"your_uid" password:@"your_password" createHome:YES success:^(id result) {
        NSLog(@"loginOrRegisterWithCountryCode success: %@", result);
} failure:^(NSError *error) {
        NSLog(@"loginOrRegisterWithCountryCode failure: %@", error);
}];
```

Swift:

```swift
TuyaSmartUser.sharedInstance()?.loginOrRegisterWithCountryCode("your_country_code", uid: "your_uid", password: "your_password", createHome: true, success: { (result) in 
		print("loginOrRegisterWithCountryCode success: \(result)")
}, failure: { (error) in 
		if let e = error {
    		print("loginOrRegisterWithCountryCode failure: \(e)")
    }
})
```



## 第三方登录

需要在 `涂鸦开发者平台` - `应用开发` - `第三方登录` 配置对应的 `AppID` 和 `AppSecret`;
客户端按照各平台要求进行开发，获取到对应的 code 之后，调用 tuyaSDK 对应的登录接口。



### 微信登录

**接口说明**

微信登录

```objective-c
- (void)loginByWechat:(NSString *)countryCode
                 code:(NSString *)code
              success:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| code         | 微信授权登录获取的 code                |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

Objc:

```objc
- (void)loginByWechat {
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
    TuyaSmartUser.sharedInstance()?.login(byWechat: "your_country_code", code: "wechat_code", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



### QQ 登录

**接口说明**

QQ 登录

```objective-c
- (void)loginByQQ:(NSString *)countryCode
           userId:(NSString *)userId
      accessToken:(NSString *)accessToken
          success:(nullable TYSuccessHandler)success
          failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码，例如：86                    |
| userId        | 用户 ID            |
| accessToken        | QQ 授权后返回的 accessToken             |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

Objc:

```objc
- (void)loginByQQ {
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
    TuyaSmartUser.sharedInstance()?.login(byQQ: "your_country_code", userId: "qq_open_id", accessToken: "access_token", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



### Facebook登录

**接口说明**

Facebook 登录

```objective-c
- (void)loginByFacebook:(NSString *)countryCode
                  token:(NSString *)token
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| countryCode | 国家码,例如：86                      |
| token       | Facebook 授权登录获取的  token       |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

Objc:

```objc
- (void)loginByFacebook {
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
    TuyaSmartUser.sharedInstance()?.login(byFacebook: "your_country_code", token: "facebook_token", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



## Auth2登录

**接口说明**

auth2 的接口是一个通用的登录接口，可以根据传参来确认正在使用 Auth2 的类型。

```objective-c
- (void)loginByAuth2WithType:(NSString *)type
                 countryCode:(NSString *)countryCode
                 accessToken:(NSString *)accessToken
                   extraInfo:(NSDictionary *)extraInfo
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数        | 说明                                     |
| :---------- | :--------------------------------------- |
| type        | Auth2 接口调用的类型，例如：苹果登录用 "ap" |
| countryCode | 国家码,例如：86                         |
| accessToken | 授权登录的 token                      |
| extraInfo   | 额外的参数                         |
| success     | 接口发送成功回调                         |
| failure     | 接口发送失败回调，error 表示失败原因     |

**示例代码**

Objc:

```objc
- (void)loginWithAuth2 {
	[[TuyaSmartUser sharedInstance] loginByAuth2WithType:@"auth2_type" countryCode:@"your_country_code" accessToken:@"auth2_token" extraInfo:@{@"info_key": @"info_value"} success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

Swift:

```swift
func loginWithAuth2() {
	TuyaSmartUser.sharedInstance().loginByAuth2WithType("auth2_type", countryCode: "your_country_code", accessToken: "auth2_token", extraInfo: ["info_key":"info_value"], success: {
		print("login success")
	}, failure: { (error) in
		if let e = error {
				print("login failure: \(e)")
		}
	})
}
```



### 苹果登录

**接口说明**

SDK 从 3.14.0 开始支持苹果登录了，授权成功后通过 Auth2 的接口传入 token 和 extraInfo 等信息，可以实现苹果登录。

**参数说明**

| 参数        | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| type        | @"ap"                                                        |
| countryCode | 国家码,例如：86                                              |
| accessToken | credential.identityToken                                     |
| extraInfo   | @{@"userIdentifier": credential.user, @"email": credential.email, @"nickname":credential.fullName.nickname, @"snsNickname": credential.fullName.nickname} |
| success     | 接口发送成功回调                                             |
| failure     | 接口发送失败回调，error 表示失败原因                         |

**示例代码**

Objc:

```objc
- (void)loginWithApple {
	ASAuthorizationAppleIDCredential *credential = authorization.credential;
  
	[[TuyaSmartUser sharedInstance] loginByAuth2WithType:@"ap" countryCode:@"your_country_code" accessToken:credential.identityToken extraInfo:{@"userIdentifier": credential.user, @"email": credential.email, @"nickname": credential.fullName.nickname, @"snsNickname": credential.fullName.nickname} success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

Swift:

```swift
func loginWithApple() {
	let credential = authorization.credential
	TuyaSmartUser.sharedInstance().loginByAuth2(withType: "ap", countryCode: "your_country_code", accessToken: credential?.identityToken, extraInfo: 	["userIdentifier": user,"email": email,"nickname": nickname,"snsNickname": nickname], success: {
		print("login success")
	}, failure: { (error) in
		if let e = error {
				print("login failure: \(e)")
		}
	})
}
```



## 修改用户信息

### 修改用户头像

**接口描述**

用于上传用户自定义的头像。

**参数说明**

| 参数        | 说明                                 |
| :---------- | :----------------------------------- |
| headIcon       | 头像 Image         |
| success     | 接口发送成功回调                     |
| failure     | 接口发送失败回调，error 表示失败原因 |

**示例代码**

Objc:

```objc
- (void)updateHeadIcon:(UIImage *)headIcon {
	[[TuyaSmartUser sharedInstance] updateHeadIcon:headIcon success:^{
		NSLog(@"update head icon success");
	} failure:^(NSError *error) {
		NSLog(@"update head icon failure: %@", error);
	}];
}
```

Swift:

```swift
func updateHeadIcon(_ headIcon: UIImage) {
    TuyaSmartUser.sharedInstance()?.updateHeadIcon(headIcon, success: {
        print("update head icon success")
    }, failure: { (error) in
        if let e = error {
            print("update head icon failure: \(e)")
        }
    })
}
```



### 设置用户温度单位

**接口描述**

设置温度单位是摄氏度还是华氏度

```objective-c
- (void)updateTempUnitWithTempUnit:(NSInteger)tempUnit
                           success:(nullable TYSuccessHandler)success
                           failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明                                 |
| :------- | :----------------------------------- |
| tempUnit | 温度单位，1: °C，2: °F               |
| success  | 接口发送成功回调                     |
| failure  | 接口发送失败回调，error 表示失败原因 |

**示例代码**

```objc
- (void)updateTempUnitWithTempUnit:(NSInteger)tempUnit {
	[[TuyaSmartUser sharedInstance] updateTempUnitWithTempUnit:tempUnit success:^{
		NSLog(@"update temp unit success");
	} failure:^(NSError *error) {
		NSLog(@"update temp unit failure: %@", error);
	}];
}
```

Swift:

```swift
func updateTempUnit(withTempUnit tempUnit: Int) {
    TuyaSmartUser.sharedInstance().updateTempUnit(withTempUnit: tempUnit, success: {
        print("update temp unit success")
    }, failure: { error in
        if let error = error {
            print("update temp unit failure: \(error)")
        }
    })
}
```



### 修改昵称

**接口描述**

修改昵称

```objective-c
- (void)updateNickname:(NSString *)nickName
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数     | 说明                                 |
| :------- | :----------------------------------- |
| nickName | 昵称               |
| success  | 接口发送成功回调                     |
| failure  | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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

**接口描述**

更新用户时区

```objective-c
- (void)updateTimeZoneWithTimeZoneId:(NSString *)timeZoneId
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数       | 说明                                 |
| :--------- | :----------------------------------- |
| timeZoneId | 时区 ID，例如："Asia/Shanghai"       |
| success    | 接口发送成功回调                     |
| failure    | 接口发送失败回调，error 表示失败原因 |

** 示例代码**

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

**接口描述**

如果有需要的话，定位信息可以通过以下接口上报：

```objective-c
- (void)updateLatitude:(double)latitude longitude:(double)longitude;
```

**参数说明**

| 参数      | 说明                                 |
| :-------- | :----------------------------------- |
| latitude  | 纬度        |
| longitude | 经度                     |

**示例代码**

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



## 退出登录，注销账号

### 退出登录

**接口描述**

用户账号切换的时候需要调用退出登录接口

```objective-c
- (void)loginOut:(nullable TYSuccessHandler)success
         failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数       | 说明                                 |
| :--------- | :----------------------------------- |
| success    | 接口发送成功回调                     |
| failure    | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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

**接口描述**

一周后账号才会永久停用并删除以下你账户中的所有信息，在此之前重新登录，则你的停用请求将被取消

```objective-c
- (void)cancelAccount:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                 |
| :------ | :----------------------------------- |
| success | 接口发送成功回调                     |
| failure | 接口发送失败回调，error 表示失败原因 |

**示例代码**

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



## 用户数据模型

TuyaSmartUser:

| 字段        | 描述                    |
| ----------- | ----------------------- |
| nickName    | 昵称                    |
| countryCode | 国家区号                |
| phoneNumber | 手机号码                |
| userName    | 用户名称                |
| email       | 邮箱地址                |
| uid         | 用户唯一标识符          |
| sid         | 用户登录产生唯一标识 id |
| headIconUrl | 用户头像路径            |



## Session 过期的处理

长期未登录或者密码修改后的账号，在访问服务端接口的时候会返回 Session 过期的错误，需要监听 `TuyaSmartUserNotificationUserSessionInvalid` 通知，跳转至登录页面重新登录。

Objc:

```objc
- (void)loadNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)sessionInvalid {
		NSLog(@"sessionInvalid");
		//跳转至登录页面
		MyLoginViewController *vc = [[MyLoginViewController alloc] init];
		self.window.rootViewController = vc;
	  [self.window makeKeyAndVisible];
}
```

Swift:

```swift
func loadNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(sessionInvalid), name: NSNotification.Name(rawValue: "TuyaSmartUserNotificationUserSessionInvalid"), object: nil)
}
    
@objc func sessionInvalid() {
    print("sessionInvalid")
    //跳转至登录页面
		let vc = MyLoginViewController()
		window.rootViewController = vc
		window.makeKeyAndVisible()
}
```

