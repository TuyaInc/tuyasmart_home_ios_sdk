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

Objc:

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:1 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

Swift:

```swift
func sendVerifyCode() {
    TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 1, success: {
        print("sendVerifyCode success")
    }, failure: { (error) in
        if let e = error {
            print("sendVerifyCode failure: \(e)")
        }
    })
}
```



- Use the verification code for registration after it is received on the mobile phone.

Objc:

```objc
- (void)registerByPhone {
	[[TuyaSmartUser sharedInstance] registerByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" code:@"verify_code" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

Swift:

```swift
func registerByPhone() {
    TuyaSmartUser.sharedInstance()?.register(byPhone: "your_country_code", phoneNumber: "your_phone_number", password: "your_password", code: "verify_code", success: {
        print("register success")
    }, failure: { (error) in
        if let e = error {
            print("register failure: \(e)")
        }
    })
}
```



#### Registration with email (do not need the verification code)

The verification code is not required in registration with email.

Objc:

```objc
- (void)registerByEmail {
	[[TuyaSmartUser sharedInstance] registerByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

Swift:

```swift
func registerByEmail() {
    TuyaSmartUser.sharedInstance()?.register(byEmail: "your_country_code", email: "your_email", password: "your_password", success: {
        print("register success")
    }, failure: { (error) in
        if let e = error {
            print("register failure: \(e)")
        }
    })
}
```



#### Registration with email 2.0 (verification code is required.)

Registration with email takes two steps:

- Send the verification code to an email.

Objc:

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:@"country_code" email:@"email" success:^{
                NSLog(@"sendVerifyCode success");
            } failure:^(NSError *error) {
                NSLog(@"sendVerifyCode failure: %@", error);
            }];
}
```

Swift:

```swift
 func sendVerifyCode() {
     TuyaSmartUser.sharedInstance()?.sendVerifyCode(byRegisterEmail: "country_code", email: "email", success: {
        print("sendVerifyCode success")
     }, failure: { (error) in
        if let e = error {
            print("sendVerifyCode failure: \(e)")
        }
    })
 }
```

- Use the verification code for registration after it is received in the email.

Objc:

```objc
- (void)registerByEmail {
	    [[TuyaSmartUser sharedInstance] registerByEmail:@"country_code" email:@"email" password:@"password" code:@"verify_code" success:^{
        NSLog(@"register success");
    } failure:^(NSError *error) {
        NSLog(@"register failure: %@", error);
    }];
}
```

Swift:

```swift
func registerByEmail() {
    TuyaSmartUser.sharedInstance()?.register(byEmail: "country_code", email: "email", password: "password", code: "verify_code", success: {
        print("register success")
    }, failure: { (error) in
        if let e = error {
            print("register failure: \(e)")
        }
    })
}
```



### User Login

After the user login interface is successfully invoked, the SDK will save the user session in local files, and when the App is started again, the login will be bypassed.
The session will become invalid if it is not used for a long time, therefore the notice to expired sessions has to be handled, and the user will be notified to log in again. See [Handling of Expired Session](#handling-of-expired-session)

#### Login of mobile phone

Mobile phones has two login modes: verification code login (direct login without registration) and password login (registration is required).

##### Verification code login (direct login without registration)

The process of verification code login with mobile phone is similar to that of registration on mobile phone .

- Send verification code:

Objc:

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

Swift:

```swift
func sendVerifyCode() {
    TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 0, success: {
        print("sendVerifyCode success")
    }, failure: { (error) in
        if let e = error {
            print("sendVerifyCode failure: \(e)")
        }
    })
}
```



- Login:

Objc:

```objc
- (void)loginByPhoneAndCode {
	[[TuyaSmartUser sharedInstance] login:@"your_country_code" phoneNumber:@"your_phone_number" code:@"verify_code" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```
Swift:

```swift
func loginByPhoneAndCode() {
    TuyaSmartUser.sharedInstance()?.login("your_country_code", phoneNumber: "your_phone_number", code: "verify_code", success: {
        print("login success")
    }, failure: { (error) in
      	if let e = error {
            print("login failure: \(e)")
        }
    })
}
```

#### Password login (registration is required)

Objc:

```objc
- (void)loginByPhoneAndPassword {
        [[TuyaSmartUser sharedInstance] loginByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

Swift:

```swift
func loginByPhoneAndPassword() {
    TuyaSmartUser.sharedInstance()?.login(byPhone: "your_country_code", phoneNumber: "your_phone_number", password:"your_password", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```

#### Email login

Objc:

```objc
- (void)loginByEmail {
	[[TuyaSmartUser sharedInstance] loginByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

Swift:

```swift
func loginByEmail() {
    TuyaSmartUser.sharedInstance()?.login(byEmail: "your_country_code", email: "your_email", password: "your_password", success: {
        print("login success")
    }, failure: { (error) in
        if let e = error {
           	print("login failure: \(e)")
        }
    })
}
```


### Third Party Login

User needs to configure corresponding `AppID` and `AppSecret` in the `Tuya developer platform` – `App development` – `Third-party login`. The client shall be developed according to requirements of all platforms. After corresponding code is obtained, relevant login interface of tuyaSDK shall be invoked.

#### Login on Wechat
Objc:
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
Swift:

```swift
func loginByWechat() {
    /**
	 *  Login on Wechat
	 *
	 *  @param countryCode Country code
	 *  @param code The code obtained from login authorized by Wechat.
	 *  @param success Callback of successful operation.
	 *  @param failure Callback of failed operation.
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

#### Login on QQ
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
    [[TuyaSmartUser sharedInstance] loginByQQ:@"your_country_code" openId:@"qq_open_id" accessToken:@"access_token" success:^{
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

#### Login on Facebook
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

#### Login by Twitter
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


### Resetting Password by User

#### Resetting Password by Using Mobile Phone

The process of resetting password by using mobile phone is similar to that of registration with mobile phone.

- Send verification code:

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

- Reset password:

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

#### Reset email password

Resetting password by using email takes two steps:

- Send the verification code to an email.

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

- Use the verification code to reset password after the verification code is received.

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


### Modify nickname

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

### Update timezone

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

### Logout

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

### Disable account (deregister user)
After one week, the account will be permanently disabled, and all information in the account will be deleted. If you log in to the account again before it is permanently disabled, your deregistration will be canceled.


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

### Handling of Expired Session

If you have not logged in to your account for a long time, the session expiration error will be returned when you access the server interface. You have to monitor the notification of the 	`TuyaSmartUserNotificationUserSessionInvalid` and log in to the account again after the login page is displayed.


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

