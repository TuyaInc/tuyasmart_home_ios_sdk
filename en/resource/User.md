## User management

Tuya Cloud supports various kinds of user systems such as mobile phone, email and UID. Mobile phone supports verification code login and password login. The registration and login of each user system will be separately described later.

|    Class Name    |         Description         |
| :--------------: | :-------------------------: |
|  TuyaSmartUser   |    User-related classes     |
| TuyaSmartRequest | Universal interface classes |



The `countryCode` parameter (country code) needs to be provided in the registration and login method for region selection of Tuya Cloud. Data of all available regions is independent. The Chinese Mainland account `(country code: 86)` cannot be used in the `USA (country code: 1)`. The Chinese Mainland account does not exist in the USA region.

For details about available region, please refer to the [Tuya Cloud-Available Region](https://docs.tuya.com/cn/cloudapi/api/cloudapi/)

All functions of user are realized by using the `TuyaSmartUser` Class (singleton).



### Use Mobile Phone for Login

Tuya Smart provides the mobile phone verification code login system.



#### Use Mobile Phone Password for Registration

The mobile phone and password registration process is divided into the following two steps: get a mobile phone verification code - Register a mobile phone and password account.

**API Description**

Send verification code. Used for mobile phone verification code login, register, password reset.

```objective-c
- (void)sendVerifyCode:(NSString *)countryCode
           phoneNumber:(NSString *)phoneNumber
                  type:(NSInteger)type
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| countryCode | country code, for example: 86                                |
| phoneNumber | Mobile phone number                                          |
| type        | 0: mobile phone verification code login, 1: mobile phone verification code register, 2: mobile phone password reset. |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



**API Description**

Register a mobile phone and password account.

```objective-c
- (void)registerByPhone:(NSString *)countryCode
            phoneNumber:(NSString *)phoneNumber
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| countryCode | country code, for example: 86                                |
| phoneNumber | Mobile phone number                                          |
| password    | password                                                     |
| code        | After the verification code sending, the verification code received |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



#### Use Mobile Phone Verification Code for Login

The mobile phone number and verification code login process is divided into the following two steps: get the mobile phone verification code (the API refers to the first interface of "Use Mobile Phone Password for Registration") - verification code login.

**API Description**

verification code login

```objective-c
- (void)loginWithMobile:(NSString *)mobile
            countryCode:(NSString *)countryCode
                   code:(NSString *)code
                success:(TYSuccessHandler)success
                failure:(TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| mobile      | Mobile phone number                                          |
| countryCode | country code, for example: 86                                |
| code        | After the verification code sending, the verification code received |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



#### Use Mobile Phone Password for Login

**API Description**

SDK provides mobile phone number and password login method.

```objective-c
- (void)loginByPhone:(NSString *)countryCode
         phoneNumber:(NSString *)phoneNumber
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                   |
| :---------- | :---------------------------- |
| countryCode | country code, for example: 86 |
| phoneNumber | Mobile phone number           |
| password    | password                      |
| success     | Success Callback              |
| failure     | Failure Callback              |

**Api Example**

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



#### Resetting Password by Using Mobile Phone

The process of resetting the password of the mobile phone number is divided into the following two steps: obtain the mobile phone verification code (the API refers to the first interface of "Use Mobile Phone Password for Registration") - reset the password.

**API Description**

Resetting Password by Using Mobile Phone

```
- (void)resetPasswordByPhone:(NSString *)countryCode
                 phoneNumber:(NSString *)phoneNumber
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                   |
| :---------- | :---------------------------- |
| countryCode | country code, for example: 86 |
| phoneNumber | Mobile phone number           |
| newPassword | new password                  |
| code | After the verification code sending, the verification code received                  |
| success     | Success Callback              |
| failure     | Failure Callback              |

**Api Example**

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



### Use Email for Login

Tuya Smart provides the email password login system.



#### User Email Password Registration

The email registration process is divided into the following two steps: get email verification code - register email password account.

**API Description**

send verification code, used for email password register.

```objective-c
- (void)sendVerifyCodeByRegisterEmail:(NSString *)countryCode
                                email:(NSString *)email
                              success:(nullable TYSuccessHandler)success
                              failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| countryCode | country code, for example: 86                                |
| email       | email                                                        |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



**API Description**

Email register

```objective-c
- (void)registerByEmail:(NSString *)countryCode
                  email:(NSString *)email
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| countryCode | Country code, for example: 86                                |
| email       | Email                                                        |
| password    | Password                                                     |
| code        | After the verification code sending, the verification code received |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



#### Use Email Password for Login

**API Description**

SDK provides email and password login method.

```objective-c
- (void)loginByEmail:(NSString *)countryCode
               email:(NSString *)email
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                   |
| :---------- | :---------------------------- |
| countryCode | Country code, for example: 86 |
| phoneNumber | Mobile phone number           |
| password    | Password                      |
| success     | Success Callback              |
| failure     | Failure Callback              |

**Api Example**

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



#### Reset email password

**API Description**

The process of resetting the password of the email is divided into the following two steps: obtain the email verification code (the API refers to the first interface of "User Email Password Registration") - reset the password.

```objective-c
- (void)resetPasswordByEmail:(NSString *)countryCode
                       email:(NSString *)email
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| countryCode | Country code, for example: 86                                |
| email       | Email                                                        |
| newPassword | New password                                                 |
| code        | After the verification code sending, the verification code received |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



### Use uid for Login

#### User uid Registration And Login

**API Description**

If had registered, then automatically logged in. If had not registered, then automatically registered and logged in.

```objective-c
- (void)loginOrRegisterWithCountryCode:(NSString *)countryCode
                                   uid:(NSString *)uid
                              password:(NSString *)password
                            createHome:(BOOL)createHome
                               success:(nullable TYSuccessID)success
                               failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                        |
| :---------- | :--------------------------------- |
| countryCode | Country code, for example: 86      |
| uid         | Email                              |
| password    | Password                           |
| createHome  | Whether to create a default family |
| success     | Success Callback                   |
| failure     | Failure Callback                   |

**Api Example**

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



### Third Party Login

User needs to configure corresponding `AppID` and `AppSecret` in the `Tuya developer platform` – `App development` – `Third-party login`. The client shall be developed according to requirements of all platforms. After corresponding code is obtained, relevant login interface of tuyaSDK shall be invoked.



#### Login on Wechat

**API Description**

Login on Wechat

```objective-c
- (void)loginByWechat:(NSString *)countryCode
                 code:(NSString *)code
              success:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                        |
| :---------- | :--------------------------------- |
| countryCode | Country code, for example: 86      |
| code         | Code from Wechat authorization login                             |
| success     | Success Callback                   |
| failure     | Failure Callback                   |

**Api Example**

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



#### Login on QQ

**API Description**

Login on QQ

```objective-c
- (void)loginByQQ:(NSString *)countryCode
           userId:(NSString *)userId
      accessToken:(NSString *)accessToken
          success:(nullable TYSuccessHandler)success
          failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                          |
| :---------- | :----------------------------------- |
| countryCode | Country code, for example: 86        |
| userId        | User id |
| accessToken        | AccessToken from QQ authorization login |
| success     | Success Callback                     |
| failure     | Failure Callback                     |

**Api Example**

Objc:
```objc
- (void)loginByQQ {
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

**API Description**

Login on Facebook

```objective-c
- (void)loginByFacebook:(NSString *)countryCode
                  token:(NSString *)token
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                             |
| :---------- | :-------------------------------------- |
| countryCode | Country code, for example: 86           |
| token       | Token from Facebook authorization login |
| success     | Success Callback                        |
| failure     | Failure Callback                        |

**Api Example**

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



#### Login by Twitter

**API Description**

Login by Twitter

```objective-c
- (void)loginByTwitter:(NSString *)countryCode
                   key:(NSString *)key
                secret:(NSString *)secret
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                            |
| :---------- | :------------------------------------- |
| countryCode | Country code, for example: 86          |
| key         | Key from Twitter authorization login   |
| secret      | ecret from Twitter authorization login |
| success     | Success Callback                       |
| failure     | Failure Callback                       |

**Api Example**

Objc:

```objc

- (void)loginByTwitter {
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
    TuyaSmartUser.sharedInstance()?.login(byTwitter: "your_country_code", key: "twitter_key", secret: "twitter_secret", success: {
       	print("login success")
    }, failure: { (error) in
        if let e = error {
            print("login failure: \(e)")
        }
    })
}
```



### Login by Auth2

**API Description**

Auth2 is a general login interface. You can use some auth2 login type by passed type parameters.

```objective-c
- (void)loginByAuth2WithType:(NSString *)type
                 countryCode:(NSString *)countryCode
                 accessToken:(NSString *)accessToken
                   extraInfo:(NSDictionary *)extraInfo
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param       | Description                                     |
| :---------- | :---------------------------------------------- |
| type        | type of Auth2 login(@"ap" for login with apple) |
| countryCode | Country code, for example: 86                   |
| accessToken | AccessToken                                     |
| extraInfo   | Extra info                                      |
| success     | Success Callback                                |
| failure     | Failure Callback                                |

**Api Example**

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



#### Login with Apple

**API Description**

The SDK supports Login with Apple from 3.14.0. After Apple login authorization is successful, information such as token and extraInfo are passed to the SDK through the Auth2 interface.

**Param Description**

| Param       | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| type        | @"ap"                                                        |
| countryCode | Country code, for example: 86                                |
| accessToken | credential.identityToken                                     |
| extraInfo   | @{@"userIdentifier": credential.user, @"email": credential.email, @"nickname":credential.fullName.nickname, @"snsNickname": credential.fullName.nickname} |
| success     | Success Callback                                             |
| failure     | Failure Callback                                             |

**Api Example**

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



### Modify User Avatar

**Interface description**

**API Description**

Used to upload user-defined avatars.

**Param Description**

| Param    | Description                             |
| :------- | :-------------------------------------- |
| headIcon | Head Icon Image                         |
| success  | Success Callback                        |
| failure  | Failure Callback                        |

**Api Example**

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



### Set the Unit of Temperature

**API Description**

Set the temperature in Celsius or Fahrenheit

```objective-c
- (void)updateTempUnitWithTempUnit:(NSInteger)tempUnit
                           success:(nullable TYSuccessHandler)success
                           failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param    | Description                              |
| :------- | :--------------------------------------- |
| tempUnit | Temperature unit. 1 for `°C`, 2 for `°F` |
| success  | Success Callback                         |
| failure  | Failure Callback                         |

**Api Example**

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



### Modify nickname

**API Description**

Modify nickname

```objective-c
- (void)updateNickname:(NSString *)nickName
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param    | Description      |
| :------- | :--------------- |
| nickName | Nick name        |
| success  | Success Callback |
| failure  | Failure Callback |

**Api Example**

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

**API Description**

Update timezone

```objective-c
- (void)updateTimeZoneWithTimeZoneId:(NSString *)timeZoneId
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param      | Description                        |
| :--------- | :--------------------------------- |
| timeZoneId | TimeZone ID. e.g. `Asia/Shanghai`. |
| success    | Success Callback                   |
| failure    | Failure Callback                   |

**Api Example**

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



### Update location

**API Description**

If need, location can be reported through this api:

```objective-c
- (void)updateLatitude:(double)latitude longitude:(double)longitude;
```

**Param Description**

| Param     | Description                        |
| :-------- | :--------------------------------- |
| latitude  | latitude |
| longitude | longitude                   |

**Api Example**

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



### Logout

**API Description**

When the user account is switched, it is necessary to call the logout interface.

```objective-c
- (void)loginOut:(nullable TYSuccessHandler)success
         failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param      | Description                        |
| :--------- | :--------------------------------- |
| success    | Success Callback                   |
| failure    | Failure Callback                   |

**Api Example**

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

**API Description**

After one week, the account will be permanently disabled, and all information in the account will be deleted. If you log in to the account again before it is permanently disabled, your deregistration will be canceled.

```objective-c
- (void)cancelAccount:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param   | Description      |
| :------ | :--------------- |
| success | Success Callback |
| failure | Failure Callback |

**Api Example**

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
		// Log out
		[[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];

		// Go to login page
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
    // Log out
    TuyaSmartUser.sharedInstance()?.loginOut(nil, failure: nil)
    // Go to login page
}
```

