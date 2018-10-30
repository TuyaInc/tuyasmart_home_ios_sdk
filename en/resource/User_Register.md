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