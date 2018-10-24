### 用户登录

用户登录接口调用成功之后，SDK会将用户Session储存在本地，下次启动APP时即默认已经登录，不需要再次登录。

长期未使用的情况下Session会失效，因此需要对Session过期的通知进行处理，提示用户重新登录。参见[Session过期的处理](#session-invalid)

#### 手机登录

手机登录有两种方式：验证码登录（无需注册，直接可以登录），密码登录（需要注册）

##### 验证码登录（无需注册，直接可以登录）

手机验证码登录的流程和手机注册类似：

- 发送验证码：

```objc
- (void)sendVerifyCode {
	[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
		NSLog(@"sendVerifyCode success");
	} failure:^(NSError *error) {
		NSLog(@"sendVerifyCode failure: %@", error);
	}];
}
```

- 登录:

```objc
- (void)loginByPhoneAndCode {
	[[TuyaSmartUser sharedInstance] login:@"your_country_code" phoneNumber:@"your_phone_number" code:@"verify_code" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

#### 密码登录（需要注册）

```objc
- (void)loginByPhoneAndPassword {
	[[TuyaSmartUser sharedInstance] loginByPhone:@"your_country_code" phoneNumber:@"your_phone_number" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```

#### 邮箱登录

```objc
- (void)loginByEmail {
	[[TuyaSmartUser sharedInstance] loginByEmail:@"your_country_code" email:@"your_email" password:@"your_password" success:^{
		NSLog(@"login success");
	} failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
	}];
}
```