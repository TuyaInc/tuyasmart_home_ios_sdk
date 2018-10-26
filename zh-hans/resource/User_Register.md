### 用户注册

_注：注册方法调用成功后，就可以正常使用SDK的所有功能了（注册成功即为登录成功），不需要再次调用登录方法。_

#### 手机注册

手机注册需要以下两个步骤：

- 发送验证码到手机

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:1 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

- 手机收到验证码后，使用验证码注册

```objc
- (void)registerByPhone {
	[[TuyaSmartUser sharedInstance] registerByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" code:@"verify_code" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

#### 邮箱注册 （不需要验证码）

邮箱注册不需要发送验证码，直接注册即可：

```objc
- (void)registerByEmail {
	[[TuyaSmartUser sharedInstance] registerByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"register success");
	} failure:^(NSError *error) {
		NSLog(@"register failure: %@", error);
	}];
}
```

#### 邮箱注册 2.0 （需要验证码）

邮箱注册需要以下两个步骤：

- 发送验证码到邮箱

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:@"country_code" email:@"email" success:^{
        NSLog(@"sendVerifyCode success");
    } failure:^(NSError *error) {
        NSLog(@"sendVerifyCode failure: %@", error);
    }];
}
```

- 邮箱收到验证码后，使用验证码注册

```objc
- (void)registerByEmail {
	[[TuyaSmartUser sharedInstance] registerByEmail:@"country_code" email:@"email" password:@"password" code:@"verify_code" success:^{
        NSLog(@"register success");
    } failure:^(NSError *error) {
        NSLog(@"register failure: %@", error);
    }];
}
```