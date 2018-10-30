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
